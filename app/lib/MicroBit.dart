import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/MicrobitUARTservice.dart';

class MicroBit {
  
  static const int scanDuration = 3;

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

    // Listen to scan results
    await for(var scanResult in flutterBlue.scanResults){
      bool found = false;
      for (ScanResult result in scanResult) {
        if (_checkDeviceName(result.device.name, deviceName) && !this.connected) {
            this.microbit = result.device;
            found = true;
            break;
        }
      }
      if(found) {
        break;
      }
    }

    // Stop scanning
    flutterBlue.stopScan();

    print('Moving to MB');
    await _connectDevice();

    print('This.connected is ' + this.connected.toString());
    return this.connected;
  }

  bool _checkDeviceName(String deviceName, String expectedName) {
    return deviceName == 'BBC micro:bit [' + expectedName + ']';
  }

  Future<void> _connectDevice() async {
    await this.microbit.connect(autoConnect: false);
    await _setUartService();
    this.connected = true;
  }

  Future<void> _setUartService() async {
    List<BluetoothService> services = await this.microbit.discoverServices();

    services.forEach((service) {
      if (service.uuid.toString().toUpperCase() == MicroBitUARTservice.getUUID()) {
        this.uartService = new MicroBitUARTservice(service);
      }
    });
  }

  bool isConnnected() {
    return this.connected;
  }

  void disconnect() async {
    await this.microbit.disconnect();
    this.connected = false;
    print('Disconected...');
  }

  Future<void> writeTo(int value) async{
    await this.uartService.write(value);
    print('Sent ' + value.toString() + ' to Micro:bit');
  }

  void subscribe(Function onData) {
    this.uartService.subscribe(onData);
  }
}
