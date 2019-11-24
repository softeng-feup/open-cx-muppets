import 'package:app/Pages/GetStartedPages.dart';
import 'package:app/Pages/LogoPage.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MicroMeets extends StatefulWidget {
  @override
  _MicroMeetsState createState() => _MicroMeetsState();
}

class _MicroMeetsState extends State<MicroMeets> {
  bool _loading = true;
  bool _showTutorial;

  Future<bool> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final showTut = prefs.getBool('show_tutorial') ?? true;

    return showTut;
  }

  @override
  void initState() {
    super.initState();

    final Future<bool> preferencesFuture = Future.delayed(
      Duration(seconds: 3),
      () => _loadPreferences(),
    );

    preferencesFuture.then((showTut) {
      setState(() {
        _showTutorial = showTut;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return MaterialApp(
        title: 'Micro:Meets',
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: LogoPage(),
      );
    } else {
      return MaterialApp(
        title: 'Micro:Meets',
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: (_showTutorial ? GetStartedPage(skipable: true) : HomePage()),
      );
    }
  }
}