import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/Animations/FadeIn.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getFadeInIcon(),
            _getFadeInLogo(),
          ],
        ),
      ),
    );
  }

  Widget _getFadeInIcon() {
    return Container(
      width: 300,
      margin: EdgeInsets.all(25),
      child: FadeIn(
        duration: 2,
        child: Image.asset(
          'assets/images/IconOriginal.png',
        ),
      ),
    );
  }

  Widget _getFadeInLogo() {
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      width: 250,
      margin: EdgeInsets.all(25),
      child: FadeIn(
        duration: 2,
        child: Image.asset(
          'assets/images/NameLogo.png',
        ),
      ),
        
    );
  }
}
