// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//To run the following tests run the following command in the terminal:
// flutter drive --target=test_driver\connections.dart
void main() {
  FlutterDriver driver;

  // Delay method used to insert some delay between UI interactions
  Future<void> delay([int milliseconds = 250]) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  // Credits to Darshan for the following method. Taken from his answer on StackOverflow:
  // https://stackoverflow.com/questions/56602769/how-to-check-if-widget-is-visible-using-flutterdriver
  isPresent(SerializableFinder byValueKey, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('enter connect page, turn on bluetooth, activate connections', () async {
    // Enter connect page and simulate a bluetooth turning on
    final connectButton = find.text('Connect');
    await driver.waitFor(connectButton);
    await delay();
    await driver.tap(connectButton);

    // Well,since bluetooth has to be turned on outside the app YOU HAVE TO DO THIS YOURSELF DURING THE TEST
    await delay(5000);

    // Toggle the connections switch
    final toggleConnections = find.byType('Switch');
    await driver.waitFor(toggleConnections);
    await delay();
    await driver.tap(toggleConnections);

    // Confirming the dialog with an empty text
    final confirmButton = find.text('Connect');
    await driver.waitFor(confirmButton);
    await delay();
    await driver.tap(confirmButton);

    await delay(1000);
  });

  test(
      'pair with someone, go back to homepage, check if there is a friend, enter friends profile',
      () async {
    // Open the users expansion tile
    final userTile = find.byType('ExpansionTile');
    await driver.waitFor(userTile);
    await delay();
    await driver.tap(userTile);

    // Pair with the user
    final pairButton = find.text('PAIR');
    await driver.waitFor(pairButton);
    await delay();
    await driver.tap(pairButton);

    // Go back to homepage
    final backButton = find.pageBack();
    await driver.waitFor(backButton);
    await delay();
    await driver.tap(backButton);

    // Go to friends page
    final friendsButton = find.text('Friends');
    await driver.waitFor(friendsButton);
    await delay();
    await driver.tap(friendsButton);

    // Check if there is a friend
    final friendTile = find.byValueKey('friend');
    await driver.waitFor(friendTile);
    await delay();
    await driver.tap(friendTile);
  });

  test(
      'remove friend, go to connections page, refresh page and disable connections',
      () async {
    // Open the users expansion tile
    final deleteButton = find.byValueKey('delete');
    await driver.waitFor(deleteButton);
    await delay();
    await driver.tap(deleteButton);

    // Check if the user is no longer on the list
    final friendTile = find.byValueKey('friend');
    final friendExists = await isPresent(friendTile, driver);
    if(friendExists){
      fail('Friend was not deleted!');
    }

    // Go back to homepage
    final backButton = find.byValueKey('pageBack');
    await driver.waitFor(backButton);
    await delay();
    await driver.tap(backButton);

    // Go to connections page
    final connectButton = find.text('Connect');
    await driver.waitFor(connectButton);
    await delay();
    await driver.tap(connectButton);

    // Check if there is a friend
    final refreshButton = find.byValueKey('refresh');
    await driver.waitFor(refreshButton);
    await delay();
    await driver.tap(refreshButton);

    // Check there are no users listed
    final userTile = find.byType('ExpansionTile');
    final userExists = await isPresent(userTile, driver);
    if(userExists) {
      fail('Refreshing connections page did not clear the users on screen');
    }

    // Disable connections
    final toggleConnections = find.byType('Switch');
    await driver.waitFor(toggleConnections);
    await delay();
    await driver.tap(toggleConnections);

    await delay(2000);
  });
}
