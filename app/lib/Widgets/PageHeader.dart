import 'dart:ffi';

import 'package:app/Theme.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:flutter/material.dart';



class PageHeader extends StatelessWidget implements PreferredSizeWidget {
  bool back;


  PageHeader({
    this.back = true
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 26.0,
      color: bluePage,
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(top: 30.0, left: 12.0, right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: back ? widgets(context) : single(context),
      ),
    );
  }

  Widget widgets(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Logo(width: 120),
        Icon(Icons.arrow_back_ios, color: Colors.transparent),
      ],
    );
  }

  single(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Logo(width: 120),
        ]
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
