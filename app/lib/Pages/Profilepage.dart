import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/ContactsPage.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
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
      appBar: PageHeader(destinationPage: HomePage()),
      backgroundColor: bluePage,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                PageTitle(title: 'Profile'),
                getProfilePicture(),
                fieldBox("name"),
                fieldBox("nationality"),
                fieldBox("occupation"),
                fieldBox("company"),
                fieldBox("languages"),
                contactsButton(ContactsPage())
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }

  getProfilePicture() {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(8.0),
      height: 150,
      width: 150,
      decoration: new BoxDecoration(
        color: purpleButton,
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: Center(
        child: Image.asset('assets/images/IconWhite.png',
        ),
      ),
    );
  }

  Widget fieldBox(field) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 5),
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: field,
          labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: purpleButton),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget contactsButton(destinationPage) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: 300,
        child: RaisedButton(
          padding: EdgeInsets.all(12),
          color: purpleButton,
          child: Text("Contacts", style: TextStyle(fontSize: 20, color: Colors.white)),
          onPressed: () {
            Navigator.push(
              context,
              FadeRoute(page: destinationPage),
            );
          },
        ),
    );
  }
}