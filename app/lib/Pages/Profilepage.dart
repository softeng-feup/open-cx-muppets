import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/ContactsPage.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/FieldBox.dart';
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
      appBar: PageHeader(),
      backgroundColor: bluePage,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                PageTitle(title: 'Profile'),
                getProfilePicture(),
                FieldBox(
                  fieldName: 'name',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                ),
                FieldBox(
                  fieldName: 'nationality',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                ),
                FieldBox(
                  fieldName: 'occupation',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                ),
                FieldBox(
                  fieldName: 'company',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                ),
                FieldBox(
                  fieldName: 'languages',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                ),
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
        child: Image.asset(
          'assets/images/IconWhite.png',
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
        child: Text("Contacts",
            style: TextStyle(fontSize: 20, color: Colors.white)),
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
