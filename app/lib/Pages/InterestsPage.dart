import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class InterestsPage extends StatefulWidget {
  InterestsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> contactList = List<String>();

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
                getTitle(),
                getInterests(),
                getInterestsButton()
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }

  Widget getTitle() {
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
      )),
      child: Text(
        "Interests",
        style: TextStyle(fontSize: 30, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getInterests() {
    //ir buscar à database
    List<Widget> rows = List<Widget>();

    for (int i = 0; i < contactList.length; i++) {
      rows.add(createContactRow(contactList[i]));
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
            color: purpleButton, borderRadius: BorderRadius.circular(25.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              contact,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  this.contactList.remove(contact);
                });
              },
            ),
          ],
        ));
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Interest:'),
            content: TextField(
              autofocus: true,
              controller: _controller,
            ),
            actions: <Widget>[
              RawMaterialButton(
                child: Text("Add"),
                onPressed: () {
                  Navigator.of(context).pop(_controller.text.toUpperCase());
                },
              )
            ],
          );
        });
  }

  Widget getInterestsButton() {
    return RawMaterialButton(
      onPressed: () {
        createAlertDialog(this.context).then((input) {
          setState(() {
            this.contactList.add(input);
          });
        });
      },
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
