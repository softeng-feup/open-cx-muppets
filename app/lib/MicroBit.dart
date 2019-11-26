import 'package:flutter_blue/flutter_blue.dart';

class MicroBit {

  static const String UARTserviceUUID = '6E400001B5A3F393E0A9E50E24DCCA9E';
  static const String TXcharacteristicUUID = '6E400002B5A3F393E0A9E50E24DCCA9E';
  static const String RXcharacteristicUUID = '6E400003B5A3F393E0A9E50E24DCCA9E';
  static const int scanDuration = 10;

  FlutterBlue flutterBlue;
  BluetoothDevice microbit;
  BluetoothService uartService;
  BluetoothCharacteristic txCharacteristic;
  BluetoothCharacteristic rxCharacteristic;
  bool connected;

  MicroBit() {
    this.flutterBlue = FlutterBlue.instance;
    this.connected = false;
  }

  bool connect(String deviceName) {

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: scanDuration));

    // Listen to scan results
    flutterBlue.scanResults.listen((scanResult) {
      
     for(ScanResult result in scanResult) {
        if( _checkDeviceName(result.device.name, deviceName)) {
          return _connectDevice(result.device);
        }
     }
    
    });

    // Stop scanning  
    flutterBlue.stopScan();
    return false;
  }

  bool _checkDeviceName(String deviceName, String expectedName ) {
    return deviceName == 'BBC micro:bit [' + expectedName + ']';
  }

  Future<bool> _connectDevice(BluetoothDevice device) async {
    
    this.microbit = device;
    this.connected = true;

    this.microbit.connect();
    return await _setUartService();    
  }

  Future<bool> _setUartService() async {

    List<BluetoothService> services = await this.microbit.discoverServices();

    services.forEach((service) {
      if (service.uuid.toString().toUpperCase() == UARTserviceUUID)
        this.uartService = service;
        return _setCharacteristics();
    });

    return false;
  }

  bool _setCharacteristics() {
    List<BluetoothCharacteristic> characteristics = this.uartService.characteristics;

    for(BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString().toUpperCase() == TXcharacteristicUUID) {
        this.txCharacteristic = c;
      }
      else if (c.uuid.toString().toUpperCase() == RXcharacteristicUUID) {
        this.rxCharacteristic = c;
      }
      else return false;
    }

    return true;
  }

  Future<List<int>> readFrom() async {
    return await txCharacteristic.read();
  }

  void writeTo(List<int> byteArray) async {
    await rxCharacteristic.write(byteArray);
  }

  bool isConnnected() {
    return connected;
  }

}