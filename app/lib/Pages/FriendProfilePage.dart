import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/FriendTitle.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class FriendProfilePage extends StatelessWidget {
  final MMDatabase _db = MMDatabase();
  final User user;

  FriendProfilePage({@required this.user});

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
                FriendTitle(name: user.name, color: bluePage),
                getProfilePicture(),
                Row(
                  children: <Widget>[getInfo(), getContacts()],
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: bluePage),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _db.removeFriend(user.id);
          Navigator.of(context).pop(true);
        },
        backgroundColor: teal,
        child: Icon(Icons.delete),
      ),
    );
  }

  getProfilePicture() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 150,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: bluePage,
      ),
      child: WhiteIconLogo(),
    );
  }

  Widget getInfo() {
    List<Widget> result = List<Widget>();

    result.add(Text(user.occupation, style: TextStyle(color: Colors.white)));
    result.add(Text(
      user.company,
      style: TextStyle(color: Colors.white),
    ));
    result.add(Container(
        margin: EdgeInsets.only(top: 12.0),
        child: Text(
          "Interests",
          style: TextStyle(fontSize: 10.0, color: Colors.white),
        )));

    for (int i = 0; i < user.interests.length; i++) {
      String interest = user.interests[i];

      result.add(Container(
          margin: EdgeInsets.all(4.0),
          child: Text(
            "$interest",
            style: TextStyle(color: Colors.white),
          )));
    }

    return Expanded(
        child: Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 12.0, right: 6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0), color: purpleButton),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 250),
              child: Column(children: result),
            )));
  }

  Widget getContacts() {
    List<Widget> result = List<Widget>();

    result.add(Text(
      "Contacts",
      style: TextStyle(fontSize: 10.0, color: Colors.white),
    ));

    for (int i = 0; i < user.contacts.length; i++) {
      String contact = user.contacts[i];

      result.add(Container(
          margin: EdgeInsets.all(4.0),
          child: Text(
            "$contact",
            style: TextStyle(color: Colors.white),
          )));
    }

    return Expanded(
        child: Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 6.0, right: 12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0), color: teal),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 250),
              child: Column(children: result),
            )));
  }
}
