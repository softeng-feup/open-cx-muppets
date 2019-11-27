import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;

  PageTitle({
    @required this.title,
    this.color = Colors.white,
    this.fontSize = 30
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
        padding: EdgeInsets.only(bottom: 16, right: 22, left: 22),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
