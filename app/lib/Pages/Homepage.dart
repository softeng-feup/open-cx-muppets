import 'package:app/Pages/Profilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            getButton("Profile"),
            getButton("Friends"),
            getButton("Interests"),
          ],
        ),
      ),
      bottomNavigationBar: getFooter(),
    );
  }

  getButton(String option) {
    return Container(
      padding: EdgeInsets.only(top:20),
      width: 250,
      child: RaisedButton(
        onPressed: () {},
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
          color: teal
      ),
      child: Center(
        child: Text("©OpenCX-Muppets 2019", style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
