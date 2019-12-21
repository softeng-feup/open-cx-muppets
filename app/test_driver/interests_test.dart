// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//To run the following tests run the following command in the terminal:
// flutter drive --target=test_driver\interests.dart
void main() {
  FlutterDriver driver;
  
  // Delay method used to insert some delay between UI interactions
  Future<void> delay([int milliseconds = 250]) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
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

  test('check flutter driver health', () async {
    final health = await driver.checkHealth();
    expect(health.status, HealthStatus.ok);
  });

  test('go to interests page, add interest', () async {
    await delay(5500);

    // First, the driver skips the Get Started page to reach the HomePage
    final skipButton = find.text('Skip');
    await driver.waitFor(skipButton);
    await delay();
    await driver.tap(skipButton);

    // Then it clicks the Interests button to travel to the InterestsPage
    final interestsButton = find.text('Interests');
    await driver.waitFor(interestsButton);
    await delay();
    await driver.tap(interestsButton);

    // In the interests page it clicks the add interest button
    final addInterestButton = find.byValueKey('add');
    await driver.waitFor(addInterestButton);
    await delay();
    await driver.tap(addInterestButton);

    // Afterwards inserts some text in the dialog and confirms the entry
    final textField = find.byValueKey('textField');
    final confirmButton = find.byValueKey('confirm');
    await driver.waitFor(textField);
    await delay();
    await driver.enterText('Testing');
    await driver.waitFor(confirmButton);
    await delay();
    await driver.tap(confirmButton);
  });

  test('remove interest, go back to homepage', () async {
    // Starts of by removing the interest recently added
    final deleteInterest = find.byValueKey('delete');
    await driver.waitFor(deleteInterest);
    await delay();
    await driver.tap(deleteInterest);

    // Finally it goes back to the homepage
    final backButton = find.byValueKey('pageBack');
    await driver.waitFor(backButton);
    await delay();
    await driver.tap(backButton);

    // Checking if the driver stopped at the homepage
    final interestsButton = find.text('Interests');
    await driver.waitFor(interestsButton, timeout: Duration(seconds: 1));
  });
}
