import 'dart:math';

import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/MicroBit.dart';

class ConnectPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothState.on) {
          return ConnectionsPage();
        }
        return BluetoothOffScreen(state: state);
        }
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluePage,
        title: Logo(width: 120),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.blue,
            ),
            Text(
              'Bluetooth Adapter is ${state.toString().substring(15)}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: teal),
    );
  }
}

class ConnectionsPage extends StatefulWidget {

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectionsPage> {
  static MicroBit microbit = new MicroBit();
  static bool _active = false;
  List<User> _connections = <User>[];
  final _db = MMDatabase();

  Widget _buildConnections() {
    return FutureBuilder(
      builder: (context, futureSnap) {
        if (futureSnap.connectionState == ConnectionState.done &&
            futureSnap.hasData != null) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: futureSnap.data.length,
              itemBuilder: (context, i) {
                _connections = futureSnap.data;
                return _buildRow(_connections[i]);
              });
        }
        return Container();
      },
      future: _db.getRangeOfUsers(pollMicrobit(2)),
    );
  }

  Future<Widget> _buildNotConnected(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Micro:bit Device not connected',
          ),
        );
      }
    );
  }

  Widget _buildRow(User user) {
    return ExpansionTile(
      leading: CircleAvatar(child: Image.asset('assets/images/IconWhite.png'),
      radius: 25.0,),
      title: Text(user.name),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Text('Interests: '),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Text(user.interests.toString()),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluePage,
        title: Logo(width: 120),
        centerTitle: true,
        actions: <Widget>[
          Switch(
              value: _active,
              activeColor: teal,
              onChanged: (bool) {
                setState(() => _active = bool);
              }),
        ],
      ),
      body: _active
          ? _buildConnections()
          : Center(
              child: Text(
                'Connections disabled',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25.0,
                ),
              ),
            ),
      bottomNavigationBar: Footer(color: teal),
    );
  }
}

List<int> pollMicrobit(int numElements) {
  List<int> result = <int>[];
  Random random = Random(TimeOfDay.now().minute);

  while (numElements != 0) {
    int index = random.nextInt(3) + 1;

    if (result.indexOf(index) == -1) {
      result.add(index);
      numElements--;
    }
  }

  return result;
}
