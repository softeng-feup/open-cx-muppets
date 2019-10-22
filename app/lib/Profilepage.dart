import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    );
  }

  getButton(String option) {
    return Container(
      padding: EdgeInsets.only(top:20),
      width: 250,
      child: RaisedButton(
        padding: EdgeInsets.all(12),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            side: BorderSide(color: Color.fromARGB(255, 49, 0, 106))
        ),
        onPressed: () {},
        color: Color.fromARGB(255, 49, 0, 100),
        textColor: Colors.white,
        child: Text("$option",
            style: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
      ),
    );
  }

  Widget getIcon() {
    return Container(
      width: 250,
      child: Image.asset('icons/IconOriginal.png',
      ),
    );
  }

  Widget getLogo() {
    return Container(
      width: 100,
      child: Image.asset('icons/NameLogo.png',
      ),
    );
  }
}