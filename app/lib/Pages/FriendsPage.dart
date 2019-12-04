import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/FriendProfilePage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/Logos.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
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
                PageTitle(title: 'Friends'),
                getFriends(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }

  Widget getFriends() {
    //ir buscar à database
    List<String> friendList = List<String>();

    friendList.add("Ana Amarelo");
    friendList.add("Red Resnikov");
    friendList.add("Mr Very very Serious");

    List<Widget> rows = List<Widget>();

    for(int i = 0; i < friendList.length; i++){
      rows.add(createFriendRow(friendList[i], FriendProfilePage(name: friendList[i])));
    }

    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: rows,
      ),
    );
  }

  Widget createFriendRow(String contact, destinationPage) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.all(12.0),
        width: 400,
        height: 100,
        decoration: BoxDecoration(
            color: purpleButton,
            borderRadius: BorderRadius.circular(18.0)
        ),
        child: RaisedButton(
          elevation: 0,
          color: purpleButton,
          child: Row(
            children: <Widget>[
              getPicture(),
              Expanded(
                child: Text(contact, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17.0),),
              ),
            ],
          ),
          onPressed: destinationPage == null? (){} : () {
            Navigator.push(
              context,
              FadeRoute(page: destinationPage),
            );
          },
        )
    );
  }

  getPicture() {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: WhiteIconLogo()
    );
  }
}