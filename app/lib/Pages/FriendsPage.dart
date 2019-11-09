import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/FriendProfilePage.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/PageHeader.dart';
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
      appBar: PageHeader(destinationPage: HomePage()),
      backgroundColor: bluePage,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                getTitle(),
                getFriends(),
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
      child: Text("Friends", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),
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

  Widget getFriends() {
    //ir buscar à database
    List<String> friend_list = List<String>();

    friend_list.add("Ana Amarelo");
    friend_list.add("Red Resnikov");
    friend_list.add("Mr Very very Serious");

    List<Widget> rows = List<Widget>();

    for(int i = 0; i < friend_list.length; i++){
      rows.add(createFriendRow(friend_list[i], FriendProfilePage(name: friend_list[i])));
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
      child: Center(
        child: Image.asset('assets/images/IconWhite.png',
        ),
      ),
    );
  }
}