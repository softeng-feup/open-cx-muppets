import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/MicroBit.dart';
import 'dart:convert';

class ConnectionsPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectionsPage> {
  static MicroBit microbit = new MicroBit();
  static List<int> _idsList = new List<int>();
  static bool _active = false;
  static BluetoothState _bluetoothState;
  static List<User> _connections = <User>[];
  final _db = MMDatabase();

  @override
  void initState() {
    if (microbit.isConnnected()) {
      microbit.subscribe(_onData);
    }
    //Uncomment to mock users
    //_db.getUser(1).then((user) => _connections.add(user));
    super.initState();
  }

  Widget _buildConnections() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _connections.length,
      itemBuilder: (context, i) {
        return _buildRow(_connections[i]);
      },
    );
  }

  void _onData(List<int> bytesRead) {
    const int IdFlag = 36;

    List<int> id = new List<int>();

    for (final int byte in bytesRead) {
      if (byte == IdFlag) {
        int newId = int.parse(utf8.decode(id));
        if (!_idsList.contains(newId)) {
          _db.getUser(newId).then((user) {
            if (user.id != -1) {
              setState(() {
                _connections.add(user);
                _idsList.add(newId);
              });
            }
          });
          print('New id received: $newId');
        }
        id.clear();
      } else
        id.add(byte);
    }
  }

  Widget _buildRow(User user) {
    return ExpansionTile(
      leading: CircleAvatar(
        child: Container(
          padding: EdgeInsets.all(2.0),
          child: WhiteIconLogo(),
        ),
        backgroundColor: bluePage,
        radius: 25.0,
      ),
      title: Text(user.name),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: Text('Interests: '),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            user.interests.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        pairButton(user.id)
      ],
    );
  }

  Widget _buildBluetoothOn() {
    if (_active) return _buildConnections();

    return Center(
      child: Text(
        'Connections disabled',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _buildBluetoothOff() {
    if (microbit.isConnnected() && _bluetoothState == BluetoothState.off) {
      _idsList.clear();
      _connections.clear();

      print('Disconnecting Micro:bit');
      microbit.disconnect().then((a) => print('Micro:bit Disconnected'));
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.bluetooth_disabled,
            size: 200.0,
            color: Colors.blue,
          ),
          Text(
            'Bluetooth Adapter is ${_bluetoothState.toString().substring(15)}.',
            style: Theme.of(context)
                .primaryTextTheme
                .subhead
                .copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Future<String> _microbitDialog(BuildContext context) {
    if (!microbit.isConnnected() && _bluetoothState == BluetoothState.on) {
      TextEditingController _controller = TextEditingController();

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Insert your Micro:Bit name'),
            content: TextField(
              autofocus: true,
              controller: _controller,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text.toLowerCase());
                },
                child: Text('Connect'),
              ),
            ],
          );
        },
      );
    }

    return Future.value(null);
  }

  Future<void> _errorDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        _bluetoothState = snapshot.data;
        if (_bluetoothState == BluetoothState.off) _active = false;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: bluePage,
            title: Logo(width: 120),
            centerTitle: true,
            actions: <Widget>[
              Switch(
                value: _active,
                activeColor: teal,
                onChanged: (_bluetoothState == BluetoothState.off)
                    ? null
                    : (value) {
                        if (value && !microbit.isConnnected()) {
                          _microbitDialog(context).then((name) {
                            print('Connecting...');
                            if (name != null && name != '') {
                              microbit.connect(name).then((connected) {
                                if (connected) {
                                  print('Connection Successful');
                                  microbit
                                      .writeTo(_db.getID())
                                      .then((a) => microbit.subscribe(_onData));
                                } else {
                                  print('Connection failed');
                                  _errorDialog(context,
                                      'Microbit with name $name is not accessible. Please try again!')
                                      .then((id) { setState(() {
                                        _active = false;
                                      });});
                                }
                              });
                            } else {
                              //Comment to mock users
                              setState(() {
                                _active = false;
                              });
                            }
                          });
                        }
                        setState(() => _active = value);
                      },
              ),
            ],
          ),
          body: (_bluetoothState == BluetoothState.on)
              ? _buildBluetoothOn()
              : _buildBluetoothOff(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: (_bluetoothState == BluetoothState.on && _active)
                ? purpleButton
                : Colors.grey,
            elevation: 2.0,
            child: Icon(Icons.refresh),
            onPressed: (_bluetoothState == BluetoothState.on && _active)
                ? () => setState(() {
                    _idsList.clear();
                    _connections.clear();
                    print('clicked');
                  })
                : null,
          ),
          bottomNavigationBar: Footer(color: purpleButton),
        );
      },
    );
  }

  Widget pairButton(int id) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Center(
          child: RaisedButton(
            elevation: 5,
            disabledColor: teal,
            color: teal,
            padding: EdgeInsets.all(8.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
            onPressed: () => _db.addFriend(id),
            child:
            Text("PAIR", style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
    );
  }
}
