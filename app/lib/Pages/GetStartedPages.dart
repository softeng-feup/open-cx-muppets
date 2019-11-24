import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                _Page2(),
              ]
            : <Widget>[
                _Page1(),
                _Page2(),
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

class _Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is another page',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'This short tutorial will help you get started with the app and start connecting with others',
          )
        ],
      ),
    );
  }
}
