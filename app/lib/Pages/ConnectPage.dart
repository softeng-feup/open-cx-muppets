import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logo.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final _connections = <String>[];
  final _db = new StringDB();
  static bool _active = false;

  Widget _buildConnections() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _connections.length) {
            _connections.addAll(_db.getDevices(3)); /*4*/
          }
          return _buildRow(_connections[index]);
        });
  }

  Widget _buildRow(String device) {
    return ListTile(
      title: Text(device),
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

class StringDB {
  final List<String> _devices;

  StringDB()
      : this._devices = [
          'ZeTo',
          'Cajo',
          'Gaspar',
          'Vitor',
          'Sofes',
          'Cenas',
          'Jorge',
          'Ventuzelos',
          'Lajes',
          'Pinheiro',
          'Gaspaccio'
        ];

  List<String> getDevices(int numDevices) {
    return List<String>.generate(
        numDevices, (int index) => this._devices[index]);
  }
}
