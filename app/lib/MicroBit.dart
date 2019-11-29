import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MicroBit {
  static const String UARTserviceUUID = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String TXcharacteristicUUID = '6E400002-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String RXcharacteristicUUID = '6E400003-B5A3-F393-E0A9-E50E24DCCA9E';
  static const int scanDuration = 3;

  static final FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice microbit;
  BluetoothService uartService;
  BluetoothCharacteristic txCharacteristic;
  BluetoothCharacteristic rxCharacteristic;
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
      if (service.uuid.toString().toUpperCase() == UARTserviceUUID) {
        this.uartService = service;
        _setCharacteristics();
      }
    });
  }

  void _setCharacteristics() {
    List<BluetoothCharacteristic> characteristics =
        this.uartService.characteristics;

    for (BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString().toUpperCase() == TXcharacteristicUUID) {
        this.txCharacteristic = c;
      } else if (c.uuid.toString().toUpperCase() == RXcharacteristicUUID) {
        this.rxCharacteristic = c;
      }
    }
  }

  Future<List<int>> readFrom() async {
    return await this.txCharacteristic.read();
  }

  void writeTo(List<int> byteArray) async {
    await this.rxCharacteristic.write(byteArray);
    print('Sent ' + String.fromCharCodes(byteArray));
  }

  bool isConnnected() {
    return this.connected;
  }

  void disconnect() async {
    await this.microbit.disconnect();
    this.connected = false;
    print('Disconected...');
  }
}
