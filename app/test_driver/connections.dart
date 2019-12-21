// project-specific imports
import 'package:app/Database/Database.dart';
import 'package:app/Pages/Homepage.dart';
// flutter-specific imports
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // This line sets the id of the current user in the database
  // Since there are 3 user mocked on the db, the 4th is the actual user
  MMDatabase().setID(4);

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(MaterialApp(home:HomePage(mockUsers: true)));
}