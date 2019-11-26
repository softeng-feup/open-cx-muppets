import 'package:flutter_blue/flutter_blue.dart';

class MicroBit {

  static const UARTserviceUUID = '6E400001B5A3F393E0A9E50E24DCCA9E';
  static const TXcharacteristicUUID = '6E400002B5A3F393E0A9E50E24DCCA9E';
  static const RXcharacteristicUUID = '6E400003B5A3F393E0A9E50E24DCCA9E';

  BluetoothDevice microbit;
  BluetoothService uartService;
  BluetoothCharacteristic TXcharacteristic;
  BluetoothCharacteristic RXcharacteristic;
  bool connected;

  MicroBit() {
    this.connected = false;
  }

  setDevice(BluetoothDevice device) {
    this.microbit = device;
  }

  Future<bool> setUartService() async {

    List<BluetoothService> services = await this.microbit.discoverServices();

    services.forEach((service) {
      if (service.uuid.toString() == UARTserviceUUID)
        this.uartService = service;
        return true;
    });

    return false;
  }

  bool isConnnected() {
    return connected;
  }



}