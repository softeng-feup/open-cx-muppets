import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPage extends StatelessWidget {
  final bool skipable;

  GetStartedPage({this.skipable = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Logo(width: 120),
        centerTitle: true,
        backgroundColor: bluePage,
      ),
      body: PageView(
        controller: PageController(
          initialPage: 0,
        ),
        children: skipable
            ? <Widget>[
                _SkipablePage1(),
                _TutorialsPage(),
              ]
            : <Widget>[
                _Page1(),
                _TutorialsPage(),
              ],
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }
}

class _SkipablePage1 extends StatefulWidget {
  final _bigBoldFont = TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);
  final _bigFont = TextStyle(fontSize: 20.0);

  @override
  _SkipablePage1State createState() => _SkipablePage1State();
}

class _SkipablePage1State extends State<_SkipablePage1> {
  bool _checkboxValue = false;

  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('show_tutorial', false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to', style: widget._bigBoldFont),
            Expanded(flex: 2, child: BlackLogo(width: 250)),
            Expanded(
              flex: 1,
              child: Text(
                'This short tutorial will help you get started with the app',
                textAlign: TextAlign.center,
                style: widget._bigFont,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  FadeRoute(page: HomePage()),
                );
                if (_checkboxValue == true) {
                  _savePreferences();
                }
              },
              color: purpleButton,
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              padding: EdgeInsets.all(12),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
            ListTile(
              title: Text('Do not show this again',),
              leading: Checkbox(
                activeColor: teal,
                checkColor: Colors.black,
                value: _checkboxValue,
                onChanged: (bool) {
                  setState(() {
                    _checkboxValue = bool;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  _checkboxValue = !_checkboxValue;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class _Page1 extends StatelessWidget {
  final _bigBoldFont = TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);
  final _bigFont = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to', style: _bigBoldFont),
            Expanded(flex: 2, child: BlackLogo(width: 250)),
            Expanded(
              flex: 1,
              child: Text(
                'This short tutorial will help you get started with the app',
                textAlign: TextAlign.center,
                style: _bigFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Micro:Meets tutorials'),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  FadeRoute(page: _ConnectMicrobitPage()),
                );
              },
              color: purpleButton,
              child: Text(
                '1. How to connect to your Micro:bit device',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              padding: EdgeInsets.all(12),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  FadeRoute(page: _ConnectMicrobitPage()),
                );
              },
              color: purpleButton,
              child: Text(
                '2. How new connections work',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              padding: EdgeInsets.all(12),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectMicrobitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Logo(width: 120),
        centerTitle: true,
        backgroundColor: bluePage,
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Follow these steps to connect to your Micro:bit device',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SizedBox.expand(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                     _buildEnterPairingModeTile(),
                     _buildGetMicrobitNameTile(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }
}

Widget _buildEnterPairingModeTile() {
  return ExpansionTile(
    title: Text( 
      '1. Enter Pairing Mode on your Micro:bit device',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    children: <Widget>[
      ListTile (
        title: Text(
          'Hold down A and B buttons',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
        ),
        subtitle: Image.asset('assets/images/microbit-A&B-buttons.png', width: 300, height: 150,),
      ),
      ListTile(
        title: Text(
          'While holding A and B, press the RESET button',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)
        ),
        subtitle: Image.asset('assets/images/microbit-reset-button.png', width: 300, height: 150,),
      ),
      ListTile(
        title: Text(
          'While still holding A and B, wait until the screen is filled',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)
        ),
        subtitle: Image.asset('assets/images/microbit-filled-screen.png', width: 300, height: 150,),
      ),
    ],
  );
}



Widget _buildGetMicrobitNameTile() {
    return ExpansionTile(
      title: Text(
        '2. Get your Micro:bit name',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        ListTile(
          title: Text(
            'Your companion device has a name!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)
          ),
          subtitle: Image.asset('assets/images/microbit-device-name.png', width: 300, height: 500,),
        )
      ],
    );
  }
