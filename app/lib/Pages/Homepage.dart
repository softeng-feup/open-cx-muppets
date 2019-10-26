import 'package:app/Pages/Profilepage.dart';
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
            getLogo(),
            getButton("Profile", context, ProfilePage()),
            getButton("Friends", context, null),
            getButton("Interests", context, null),
          ],
        ),
      ),
      bottomNavigationBar: getFooter(),
    );
  }

  getButton(String option, BuildContext context, Widget destinationPage) {
    return Container(
      padding: EdgeInsets.only(top:20),
      width: 250,
      child: RaisedButton(
        //If destinationPage is null it does nothing; otherwise it transitions to the page
        onPressed: destinationPage == null? (){} : () {
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
        child: Text("$option", style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget getIcon() {
    return Container(
      width: 250,
      child: Image.asset('assets/images/IconOriginal.png',
      ),
    );
  }

  Widget getLogo() {
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      width: 150,
      child: Image.asset('assets/images/NameLogo.png',
      ),
    );
  }

  Widget getFooter(){
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: teal,
          // gradient: new LinearGradient(
          //   colors: [purpleButton, teal],
          //   stops: [0.0, 1.0],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight
          // ),
      ),
      child: Center(
        child: Text("©OpenCX-Muppets 2019", style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}