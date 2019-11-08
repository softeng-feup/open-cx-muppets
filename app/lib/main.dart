import 'package:app/Pages/ContactsPage.dart';
import 'package:app/Pages/FriendProfilePage.dart';
import 'package:app/Pages/FriendsPage.dart';
import 'package:app/Pages/InterestsPage.dart';
import 'package:app/Pages/LoginPage.dart';
import 'package:app/Pages/Profilepage.dart';
import 'package:flutter/material.dart';

import 'Pages/Homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micro:Meets',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}