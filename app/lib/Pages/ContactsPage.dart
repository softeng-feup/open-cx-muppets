import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/Profilepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(destinationPage: ProfilePage()),
      backgroundColor: bluePage,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                getTitle(),
                getContacts(),
                addContact()
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
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
      child: Text("Contacts", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),
    );
  }

  Widget getContacts() {
    //ir buscar à database
    List<String> contact_list = List<String>();

    contact_list.add("351 82937 9123");
    contact_list.add("mock_email@gmail.com");
    contact_list.add("verylongemail123456789@gmail.com");

    List<Widget> rows = List<Widget>();

    for(int i = 0; i < contact_list.length; i++){
      rows.add(createContactRow(contact_list[i]));
    }

    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: rows,
      ),
    );
  }

  Widget createContactRow(String contact) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(12.0),
      width: 300,
      decoration: BoxDecoration(
        color: purpleButton,
          borderRadius: BorderRadius.circular(25.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(contact, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
          Icon(Icons.clear, color: Colors.white,),
        ],
      )
    );
  }

  Widget addContact(){
    return RawMaterialButton(
      onPressed: () {},
      child: new Icon(
        Icons.add,
        color: teal,
        size: 35.0,
      ),
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(15.0),
    );
  }
}