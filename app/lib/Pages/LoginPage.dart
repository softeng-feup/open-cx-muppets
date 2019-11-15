import 'package:app/Pages/Profilepage.dart';
import 'package:app/Widgets/FieldBox.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Animations/FadeRoute.dart';
import '../Theme.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getIcon(),
            getLogo(),
            FieldBox(
              fieldName: 'username',
              textColor: purpleButton,
              labelTextColor: teal,
              enabledBorderColor: teal,
              focusedBorderColor: teal,
            ),
            FieldBox(
              fieldName: 'password',
              textColor: purpleButton,
              labelTextColor: teal,
              enabledBorderColor: teal,
              focusedBorderColor: teal,
              password: true,
            ),
            getButton("Login", context, null)
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: teal),
    );
  }

  getButton(String option, BuildContext context, Widget destinationPage) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: 250,
      child: RaisedButton(
        //If destinationPage is null it does nothing; otherwise it transitions to the page
        onPressed: destinationPage == null
            ? () {}
            : () {
                Navigator.push(
                  context,
                  FadeRoute(page: destinationPage),
                );
              },
        padding: EdgeInsets.all(12),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
        color: purpleButton,
        child: Text("$option",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget getIcon() {
    return Container(
      width: 250,
      child: Image.asset(
        'assets/images/IconOriginal.png',
      ),
    );
  }

  Widget getLogo() {
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      width: 150,
      child: Image.asset(
        'assets/images/NameLogo.png',
      ),
    );
  }
}
