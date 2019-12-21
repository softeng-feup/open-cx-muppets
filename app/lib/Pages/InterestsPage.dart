import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/material.dart';

class InterestsPage extends StatefulWidget {
  final String title;
  final MMDatabase db = MMDatabase();

  InterestsPage({Key key, this.title}) : super(key: key);

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> interestList = List<String>();

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
                PageTitle(title: 'Interests'),
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

  Widget getInterests() {
    List<Widget> rows = List<Widget>();

    for (int i = 0; i < interestList.length; i++) {
      rows.add(createInterestRow(interestList[i]));
    }

    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: rows,
      ),
    );
  }

  Widget createInterestRow(String interest) {
    return Container(
        key: Key('interest'),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.all(4.0),
        width: 300,
        decoration: BoxDecoration(
            color: purpleButton, borderRadius: BorderRadius.circular(25.0)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  interest,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              key: Key('delete'),
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  this.interestList.remove(interest);
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
              key: Key('textField'),
              autofocus: true,
              controller: _controller,
            ),
            actions: <Widget>[
              RawMaterialButton(
                key: Key('confirm'),
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
      key: Key('add'),
      onPressed: () {
        createAlertDialog(this.context).then((input) {
          if (input != null) {
            setState(() {
              this.interestList.add(input);
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
      if (user.id != -1 && user.interests[0] != '') {
        setState(() {
          this.interestList = user.interests;
        });
      }
    });
  }

  Future<void> saveInformation() async {
    User user = User(interests: interestList);

    await widget.db.updateUserInterests(user);
  }
}
