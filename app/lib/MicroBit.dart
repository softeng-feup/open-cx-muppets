import 'dart:async';
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/MicrobitUARTservice.dart';

class MicroBit {
  static const int scanDuration = 2;
  static const int maxNumTries = 100;

  static final FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice microbit;
  MicroBitUARTservice uartService;

  bool connected;

  MicroBit() {
    this.connected = false;
  }

  Future<bool> connect(String deviceName) async {
    // Start scanning
    try {
      flutterBlue.startScan(timeout: Duration(seconds: scanDuration));
    } on PlatformException catch (e) {
      print('Starting Scan: ${e.message}');
    }

    int numTries = 0;
    bool found = false;
    // Listen to scan results

    await for (List<ScanResult> scanResult in flutterBlue.scanResults) {
      print('Received scan results (Length: ${scanResult.length})');

      numTries++;
      for (ScanResult result in scanResult) {
        print('Analysing scan result: ${result.device.name}');
        if (_checkDeviceName(result.device.name, deviceName) && !found && !this.connected) {
          found = true;
          this.microbit = result.device;
          break;
        }
      }

      if (found || numTries >= maxNumTries) {
        break;
      }
    }

    // Stop scanning
    print('Stopping scan');
    flutterBlue.stopScan();

    if (found) {
      print('Moving to MB');
      await _connectDevice();
      var state = await this.microbit.state.first;
      if (state == BluetoothDeviceState.connected)
        await _setUartService();
        this.connected = true;
    }

    print('This.connected is ' + this.connected.toString());
    return this.connected;
  }

  bool _checkDeviceName(String deviceName, String expectedName) {
    return deviceName == 'BBC micro:bit [' + expectedName + ']';
  }

  Future<void> _connectDevice() async {

    await this.microbit.connect(autoConnect: false);

  }

  Future<void> _setUartService() async {
    List<BluetoothService> services = await this.microbit.discoverServices();

    services.forEach((service) {
      if (service.uuid.toString().toUpperCase() ==
          MicroBitUARTservice.getUUID()) {
        this.uartService = new MicroBitUARTservice(service);
      }
    });
  }

  bool isConnnected() {
    return this.connected;
  }

  Future<void> disconnect() async {
    if (this.microbit != null) {
      this.uartService.unsubscribe();
      await this.microbit.disconnect();
      this.microbit = null;
      this.connected = false;
    }
  }

  Future<void> writeTo(int value) async {
    await this.uartService.write(value);
    print('Sent ' + value.toString() + ' to Micro:bit');
  }

  void subscribe(Function onData) {
    this.uartService.subscribe(onData);
  }
}
