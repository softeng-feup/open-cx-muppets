import 'package:app/Widgets/Footer.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/FriendTitle.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class FriendProfilePage extends StatelessWidget {
  FriendProfilePage({
    @required this.name
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FriendTitle(name: name.toString(), color: bluePage),
                getProfilePicture(),
                Row(children: <Widget>[
                  getInfo(),
                  getContacts()
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: bluePage),
    );
  }

  getProfilePicture() {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(8.0),
      height: 150,
      width: 150,
      decoration: new BoxDecoration(
        color: bluePage,
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: WhiteIconLogo(),
    );
  }

  Widget getInfo() {
    List<Widget> result = List<Widget>();

    //get friend's job
    String job = "Scientist";
    result.add(Text("$job", style: TextStyle(color: Colors.white)));
    
    //get friend's enterprise
    String enterprise = "CGI Enterprise";
    result.add(Text("$enterprise", style: TextStyle(color: Colors.white),));

    result.add(Container(
        margin: EdgeInsets.only(top: 12.0),
        child: Text("Interests", style: TextStyle(fontSize: 10.0, color: Colors.white),)
      )
    );

    List<String> interests = new List<String>();

    interests.add("Computer Science");
    interests.add("CGI");
    interests.add("Aliens");

    for(int i = 0; i < interests.length; i++){
      String interest = interests[i];

      result.add(
          Container(
              margin: EdgeInsets.all(4.0),
              child:Text("$interest", style: TextStyle(color: Colors.white),)
          )
      );
    }

    return Expanded(
        child:Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(top:12.0, bottom: 12.0, left: 12.0, right: 6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: purpleButton
            ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 250
            ),
            child: Column(
                children: result
            ),
          )
        )
    );
  }

  Widget getContacts() {
    List<Widget> result = List<Widget>();

    //get friend's contacts
    List<String> contacts = new List<String>();

    result.add(Text("Contacts", style: TextStyle(fontSize: 10.0, color: Colors.white),));

    contacts.add("163478234");
    contacts.add("Asdfsdgffdsf@gmainf.com");
    contacts.add("1934727388127");

    for(int i = 0; i < contacts.length; i++){
      String contact = contacts[i];

      result.add(
          Container(
              margin: EdgeInsets.all(4.0),
              child:Text("$contact", style: TextStyle(color: Colors.white),)
          )
      );
    }

    return Expanded(
      child:Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top:12.0, bottom: 12.0, left: 6.0, right: 12.0),
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: teal
          ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 250
          ),
          child: Column(
              children: result
          ),
        )
      )
    );
  }
}