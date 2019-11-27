import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';
import 'Footer.dart';
import 'PageHeader.dart';

class ConnectMicrobitTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(),
      body: Container(
        child: Column(
          children: <Widget>[
            PageTitle(title: 'Follow these steps to connect to your Micro:bit device', color: bluePage, fontSize: 20,),
            Expanded(
              child: SizedBox.expand(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  shrinkWrap: true,
                  children: <Widget>[
                    BuildEnterPairingModeTile(),
                    BuildGetMicrobitNameTile(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }
}

class BuildEnterPairingModeTile extends StatefulWidget {
  @override
  State createState() => _buildEnterPairingModeTile();
}

class _buildEnterPairingModeTile extends State<BuildEnterPairingModeTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '1. Enter Pairing Mode on your Micro:bit device',
        style: TextStyle(fontSize: 18.0, color: isExpanded ? teal : bluePage,),
      ),
      onExpansionChanged: (bool expanding) =>
          setState(() => this.isExpanded = expanding),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Text(
            'Hold down A and B buttons',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: bluePage),
          ),
          subtitle: Image.asset(
            'assets/images/microbit-A&B-buttons.png', width: 300, height: 150,),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Text(
              'While holding A and B, press the RESET button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: bluePage)
          ),
          subtitle: Image.asset(
            'assets/images/microbit-reset-button.png', width: 300,
            height: 150,),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Text(
              'While still holding A and B, wait until the screen is filled',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: bluePage)
          ),
          subtitle: Image.asset(
            'assets/images/microbit-filled-screen.png', width: 300,
            height: 150,),
        ),
      ],
    );
  }
}


class BuildGetMicrobitNameTile extends StatefulWidget {
  @override
  State createState() => _buildGetMicrobitNameTile();
}

class _buildGetMicrobitNameTile extends State<BuildGetMicrobitNameTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '2. Get your Micro:bit name',
        style: TextStyle(fontSize: 18.0, color: isExpanded ? teal : bluePage,),
      ),
      onExpansionChanged: (bool expanding) =>
          setState(() => this.isExpanded = expanding),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Text(
              'Your companion device has a name!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: bluePage)
          ),
          subtitle: Image.asset(
            'assets/images/microbit-device-name.png', width: 300, height: 500,),
        )
      ],
    );
  }
}
