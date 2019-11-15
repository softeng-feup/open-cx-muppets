import 'package:flutter/material.dart';

class FriendTitle extends StatelessWidget {
  final String name;
  final Color color;

  FriendTitle({@required this.name, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(top: 20),
      child: Text(
        name,
        style: TextStyle(fontSize: 30, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
