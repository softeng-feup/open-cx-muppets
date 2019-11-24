import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;

  PageTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 30, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
