import 'package:flutter/material.dart';

class FieldBox extends StatelessWidget {
  final String fieldName;
  final Color textColor;
  final Color labelTextColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final bool password;

  final TextEditingController controller;

  FieldBox({
    @required this.fieldName,
    @required this.textColor,
    @required this.labelTextColor,
    @required this.enabledBorderColor,
    @required this.focusedBorderColor,
    this.password = false,
    @required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 5),
      child: TextField(
        obscureText: password,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: TextStyle(
            fontSize: 14,
            color: labelTextColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
