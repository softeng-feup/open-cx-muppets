import 'package:app/Pages/FriendsPage.dart';
import 'package:app/Pages/GetStartedPages.dart';
import 'package:app/Pages/InterestsPage.dart';
import 'package:app/Pages/ProfilePage.dart';
import 'package:app/Pages/ConnectPage.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Animations/FadeRoute.dart';
import '../Theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getIcon(),
            BlackLogo(
              padding: EdgeInsets.only(bottom: 32.0),
              width: 150,
            ),
            getButton("Connect", context, ConnectionsPage()),
            getButton("Profile", context, ProfilePage()),
            getButton("Friends", context, FriendsPage()),
            getButton("Interests", context, InterestsPage()),
            getButton("Get Started", context, GetStartedPage()),
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: teal),
    );
  }

  Widget getButton(String option, BuildContext context, Widget destinationPage) {
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
}
