import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:flutter/material.dart';

class InterestsPage extends StatefulWidget {
  InterestsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
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
                addInterests()
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
      child: Text("Interests", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),
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

  Widget getInterests() {
    //ir buscar à database
    List<String> contact_list = List<String>();

    contact_list.add("Football");
    contact_list.add("Old French Movies");
    contact_list.add("Astro-Physics");

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

  Widget addInterests(){
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