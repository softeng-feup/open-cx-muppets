import 'package:app/Animations/FadeRoute.dart';
import 'package:app/Database/Database.dart';
import 'package:app/Database/User.dart';
import 'package:app/Pages/ContactsPage.dart';
import 'package:app/Theme.dart';
import 'package:app/Widgets/FieldBox.dart';
import 'package:app/Widgets/Footer.dart';
import 'package:app/Widgets/PageHeader.dart';
import 'package:app/Widgets/PageTitle.dart';
import 'package:flutter/material.dart';
import 'package:app/Widgets/Logos.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;
  final MMDatabase db = MMDatabase();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    loadInformation();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();

    await saveInformation();
    nameController.dispose();
    nationalityController.dispose();
    occupationController.dispose();
    companyController.dispose();
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
                PageTitle(title: 'Profile'),
                getProfilePicture(),
                FieldBox(
                  fieldName: 'name',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                  controller: nameController,
                ),
                FieldBox(
                  fieldName: 'nationality',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                  controller: nationalityController,
                ),
                FieldBox(
                  fieldName: 'occupation',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                  controller: occupationController,
                ),
                FieldBox(
                  fieldName: 'company',
                  textColor: Colors.white,
                  labelTextColor: Colors.white,
                  enabledBorderColor: purpleButton,
                  focusedBorderColor: Colors.white,
                  controller: companyController,
                ),
                contactsButton(ContactsPage())
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: purpleButton),
    );
  }

  void loadInformation() {
    Future<User> userFuture = widget.db.getThisUser();

    userFuture.then((user) {  
      print('Future returned');
      if (user.id != -1) {
        setState(() {
          nameController = TextEditingController(text: user.name);
          nationalityController = TextEditingController(text: user.nationality);
          occupationController = TextEditingController(text: user.occupation);
          companyController = TextEditingController(text: user.company);
        });
      }
    });
  }

  Future<void> saveInformation() async {
    User user = User(
      name: nameController.text,
      nationality: nationalityController.text,
      occupation: occupationController.text,
      company: companyController.text,
    );

    await widget.db.updateUserProfile(user);
  }

  getProfilePicture() {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(8.0),
      height: 150,
      width: 150,
      decoration: new BoxDecoration(
        color: purpleButton,
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: Center(child: WhiteIconLogo()),
    );
  }

  Widget contactsButton(destinationPage) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: 300,
      child: RaisedButton(
        padding: EdgeInsets.all(12),
        color: purpleButton,
        child: Text("Contacts",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: destinationPage),
          );
        },
      ),
    );
  }
}
