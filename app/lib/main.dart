import 'package:flutter/material.dart';

import 'Pages/Homepage.dart';
import 'Pages/Profilepage.dart';

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
      home: ProfilePage(),
    );
  }
}