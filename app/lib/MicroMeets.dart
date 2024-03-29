import 'package:app/Database/Database.dart';
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
    final userID = prefs.getInt('id') ?? -1;

    print(userID);

    // The current used id is saved on the phone and then passed to the database
    MMDatabase().setID(userID);

    return showTut;
  }

  @override
  void initState() {
    super.initState();

    final Future<bool> preferencesFuture = Future.delayed(
      Duration(microseconds: 5500000),
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