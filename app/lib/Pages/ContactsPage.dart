import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.title}) : super(key: key);
  final String title;
  final MMDatabase db = MMDatabase();

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> contactList = List<String>();

  @override
  void initState() {
    loadInformation();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();

    await saveInformation();
  }

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
                PageTitle(title: 'Contacts'),
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

  Widget getContacts() {
    List<Widget> rows = List<Widget>();

    for (int i = 0; i < this.contactList.length; i++) {
      rows.add(createContactRow(this.contactList[i]));
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
            Flexible(
              child: Text(
                contact,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
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
            title: Text('Add contact:'),
            content: TextField(
              autofocus: true,
              controller: _controller,
            ),
            actions: <Widget>[
              RawMaterialButton(
                child: Text("Add"),
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
              )
            ],
          );
        });
  }

  Widget addContact() {
    return RawMaterialButton(
      onPressed: () {
        createAlertDialog(this.context).then((input) {
          if (input != null) {
            setState(() {
              this.contactList.add(input);
            });
          }
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

  void loadInformation() {
    Future<User> userFuture = widget.db.getThisUser();

    userFuture.then((user) {
      if (user.id != -1 && user.contacts[0] != '') {
        setState(() {
          this.contactList = user.contacts;
        });
      }
    });
  }

  Future<void> saveInformation() async {
    User user = User(contacts: contactList);

    await widget.db.updateUserContacts(user);
  }
}
