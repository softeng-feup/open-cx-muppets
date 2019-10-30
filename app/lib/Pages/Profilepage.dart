import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/PageHeader.dart';
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
                getTitle(),
                getProfilePicture(),
                fieldBox("name"),
                fieldBox("nacionality"),
                fieldBox("job"),
                fieldBox("enterprise"),
                fieldBox("languages"),
                contactsButton(null)
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: getFooter(),
    );
  }

  Container getTitle() {
    return Container(
      width: 200,
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        )
      ),
      child: Text("Profile", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),
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

  Widget getFooter(){
    return Container(
      height: 40,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: purpleButton
      ),
      child: Center(
        child: Text("©OpenCX-Muppets 2019", style: TextStyle(fontSize: 14, color: Colors.white)),
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
          onPressed: destinationPage == null? (){} : () {
            Navigator.push(
              context,
              FadeRoute(page: destinationPage),
            );
          },
        ),
    );
  }
}