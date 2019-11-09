import 'package:app/Pages/ContactsPage.dart';
import 'package:app/Pages/FriendProfilePage.dart';
import 'package:app/Pages/FriendsPage.dart';
import 'package:app/Pages/InterestsPage.dart';
import 'package:app/Pages/Profilepage.dart';
import 'package:app/Pages/LoginPage.dart';
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
  bool _firstRun;

  Future<bool> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('first_run') ?? true;
    await prefs.setBool('first_run', false);

    return isFirstRun;
  }

  @override
  void initState() {
    super.initState();

    final Future<bool> preferencesFuture = Future.delayed(
      Duration(seconds: 3),
      () => _loadPreferences(),
    );

    preferencesFuture.then((isFirstRun) {
      setState(() {
        _firstRun = isFirstRun;
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
        home: (_firstRun ? LoginPage() : HomePage()),
      );
    }
  }
}