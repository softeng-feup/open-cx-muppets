import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/Widgets/Tutorials.dart';

class GetStartedPage extends StatelessWidget {
  final bool skipable;

  GetStartedPage({this.skipable = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(),
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
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: Text('Welcome to', style: TextStyle(color: bluePage, fontSize: 30)),
            ),
            Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: bluePage,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        bottom: BorderSide(
                          color: bluePage,
                          width: 1.0,
                          style: BorderStyle.solid,
                        )
                    )
                  ),
                  child: BlackLogo(width: 250)
            ),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text(
                'This short tutorial will help you get started with the app',
                textAlign: TextAlign.center,
                style: TextStyle(color: bluePage, fontSize: 20)
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Icon(Icons.chevron_right, size: 50, color: teal,),
                  Text('Swipe left', style: TextStyle(color: bluePage, fontSize: 20))
                ],
              )
            )
          ],
      ),
    );
  }
}

class _TutorialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 22),
          child: PageTitle(title: 'Tutorials', color:bluePage),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getButtons(context, 'How to connect to your Micro:bit device'),
            getButtons(context, 'How new connections work')
          ],
        )
      ]
    );
  }

  getButtons(context, title){
    return Container(
      width: 300,
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: ConnectMicrobitTutorial()),
          );
        },
        color: purpleButton,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        padding: EdgeInsets.all(16.0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

