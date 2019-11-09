import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Theme.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget implements PreferredSizeWidget {
  PageHeader({
    @required this.destinationPage
  });

  final Widget destinationPage;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: destinationPage == null? (){} : () {
                Navigator.push(
                  context,
                  FadeRoute(page: destinationPage),
                );
              }
            ),
            getLogo(),
            Icon(Icons.arrow_back_ios,color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  Widget getLogo() {
    return Container(
      width: 120,
      child: Image.asset('assets/images/NameLogoWhite.png',
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}