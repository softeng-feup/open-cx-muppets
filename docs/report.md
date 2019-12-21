# openCX-Muppets Development Report

Welcome to the documentation pages of **MicroMeets** from **openCX**!

You can find here details about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Feel free contact us!  
Thank you!

Carlos Jorge Direito Albuquerque (up201706735@fe.up.pt)  
Gaspar Santos Pinheiro (up201704700@fe.up.pt)  
Sofia de Araujo Lajes (up201704066@fe.up.pt)  
Vitor Emanuel Moreira Ventuzelos (up201706403@fe.up.pt)

---

## Product Vision
Our product aims to improve everyone's conference experience, by taking down social barriers and promoting a socially dynamic environment where people engage in conversations based on their interests, trade information seamlessly and interact more with each other.

---
## Elevator Pitch

The goal of this product is to facilitate spontaneous interaction between conference participants, by providing them with a means to find people with similar interests near them and initiate conversations. It's also important to us that the users can keep their privacy and power of choice, as we intend to improve their experience, not enforce anything on them. For this goal we plan to use a mobile app, installed on the user's phone, paired with Micro:Bit systems, implanted in the user's badge. The app will contain user profiles with tags for matching between them, while the Micro:Bit will simply detect nearby users.

---
## Requirements

The following sections describe our users requirements (or at least what we think they need).
Our module is aimed at networking. Therefore, our main guiding lines are **privacy**, **usability** and **user interactions**. We want the user to share only what he/she wants to share, but always encouraging him/her to interact with other users by making it easy to start a conversation.

### Use case diagram 

The following use case diagram aims to represent all high-level use cases present in our module:

![Use Case Diagram](https://i.imgur.com/ie3DPpn.jpg)

#### Create Profile/Account

##### Actors 

This Use Case involves two actors:

- The **conference attendee** that interacts with our app.
- The **server** that receives and stores the user info.

##### Description 

When a user connects with another person successfully, he/she gains access to the other person's profile. For this to happen we need to store a profile for each app user.

##### Preconditions and Post conditions

**Preconditions**:
- For this use case, the user just needs a network connection that allows the app to insert the profile data into the database.

**Post conditions**:
- The database stores the profile info that the user enters, this way, when he/she is nearby other users, these will see him/her in the connections section of their app.

##### Normal Flow

To create a new profile, each user has simply to go to the profile section and then just enter the information he/she wants to share with his/hers connections.
 
The steps for this use case are as follows:
- From the **home screen** the user goes to the **profile section**;
- He/She enters personal information like the user's name, nationality, occupation and company.
- The user can also add contacts so that after a session of networking with other people, he/she can easily be contacted outside of the app and the conference.

It is **important** for us that the user feels free when using our app. This way, the user is 100% free to enter only some information and leave other details out of the app. The user can even choose to not enter any kind of information, but, of course, wont get the full potential of our app.

##### Alternative Flows and Exceptions

Because our app is all about networking and facilitating the share of information between our users, any kind of information is acceptable to enter in any field as it is only going to be visualized by other users.

#### Connect with other conference attendees

##### Actors

This Use Case involves two actors:

- The **conference attendee** that interacts with our app and is trying to connect with another user.
- The **other user** that receives a notification for the  connection

##### Description 

The goal of our app is mainly this use case. We want users to connect with each other with only a few clicks. This use case involves the first setup with the Micro:Bit device and the those few clicks needed. 

##### Preconditions and Post conditions

**Preconditions**:
- For this use case, the user needs a network connection that allows the app to search on the database for the other users id that were received from the Micro:Bit to get the other user's interests to check if they are similar to the app user ones. 
- Also, so that the user experiences the full potential of our app, he/she should also enter a few interests in the appropriate section of the app (see next Use Case).

**Post conditions**:
- After the user has made a connection, he/she receives a notification informing that the new connections option has been disabled, and he/she can turn it on at any time. 
- Also, the other user's profile becomes visible in the friends section.


##### Normal Flow

To start connecting, the user first needs to open the connection section of the app and follow a few steps: 

- If the device's Bluetooth is not turned on, an appropriate message is displayed until it is turned on;
- The new connections option is disabled by default, so, after the Bluetooth is on, the user needs to toggle the new connections, by just 'flicking' a switch; 
-  If the Micro:Bit device was not yet connected to the app, a pop up is displayed where the user must enter the device name;
-  After that, the user just needs to tap the connect button and soon names of the nearby users are displayed on the screen with a button option that when clicked on, sends the the notification to the other user;
-  When the other user receives this notification he/she can choose to confirm or decline the request.

After the connection is established on the app, both users are free to make the connection in real life. Also, as soon as the connection is confirmed by the notification receiver, both users get to see the other user's profile in the friends section of the app. 

##### Alternative Flows and Exceptions

When the user clicks on the connect button, the app searches for nearby Bluetooth Low Energy devices with the name entered by the user. If the app is unable to find a device with that name, an error message is displayed informing the user.

#### Interests Set Up

##### Actors 

This Use Case involves two actors:

- The **conference attendee** that interacts with our app.
- The **server** that receives and stores the user interests.

##### Description 

So that the previous use case functions properly, we need to store a list of interests for each user. At any time the user can change his/hers interests. This means, inserting new ones or deleting those that were previously stored.

##### Preconditions and Post conditions

**Preconditions**: 
- For this use case, the user needs a network connection that allows the app to insert on the database the interests entered by the user.

**Post conditions**:
- The matchmaking based on interests becomes possible, and the list of nearby users is sorted based on that. This way, the user gets to experience the full networking potential of the app.

##### Normal Flow

This Use Case is very simple from the user's perspective. He/she just need to go to the interests section of the app, where there is a button that when clicked on lets the user add a new interest.

If the user had previously entered a few interests and wants to delete a few or just one, there is a cross button on each interest tile, that when clicked on deletes the user interest from database

##### Alternative Flows and Exceptions

Because this Use Case is very simple, there are no alternative flow or exceptions that can happen.

---

## User stories

The following image represents our global user story map:
![User Story Map](https://i.imgur.com/G4R7nsJ.jpg)

The cards (starting at the row with tag 'User stories')  can be organized by row:  
1. **Profile Management** - login, register, editing profile  
Value - should have (Login and Register are not mandatory but useful)  
Estimated effort - M  
2. **Interests Management** - adding and changing interests, seeing others interests  
Value - must have (Without interests the module does not make sense)  
Estimated effort - S
3. **Matching** - network with others, match by similar interests, enabling and disabling the matching system  
Value - must have  
Estimated effort - XL
4. **Friends** - make friends from previous connections, see friends profiles  
Value - could have (It is fun to see other's profiles, but it is more an extra)  
Estimated effort - XS
5. **Smart Badge** - make bluetooth connection easy, smart badge tech  
Value - must have  
Estimated effort - XL  

#### Acceptance tests
1. Acceptance tests for **Profile Management**:  
   * **Scenario**: User submits the log in form  
   **Given** I am logged out  
   **When** I submit my log in information  
   **Then** I should be logged in and access my information  
   * **Scenario**: User clicks log out button  
   **Given** I am loged in  
   **When** I click the log out button  
   **Then** I should be redirected to log in page and not have access to my information  
   * **Scenario**: User edits his/hers information on the profile page or contacts page  
   **Given** I am connected to the server  
   **When** I exit the profile page  
   **Then** my profile should be saved in the database  
   **And** other users should only see my latest informatio  

2. Acceptance tests for **Interests Management**:  
   * **Scenario**: User edits his/hers interests on the interests page  
   **Given** I am connected to the server  
   **When** I exit the interests page  
   **Then** my interests should be updated in the database  
   **And** other users should see my updated interests  
   * **Scenario**: User sees other users profile  
   **Given** I am connected to the server  
   **When** I see other users profile  
   **Then** I should be able to see their interests  
   **And** profile information  
   
3. Acceptance tests for **Matching**:  
   * **Scenario**: User wants to connect with other users  
   **Given** I am in the connections page  
   **And** I have the connections enabled  
   **When** another user is nearby  
   **Then** I should be able to see his/hers profile in the app  
   **And** click on His/hers profile to connect with him/her  
   * **Scenario**: User does not want to connect with others  
   **Given** I am in the connections page  
   **And** I have the connections enable  
   **When** I click the connections toggle  
   **Then** I should stop receiving connection requests  
   **And** I my profile should not appear on other user's app  
   * **Scenario**: User receives a connection request  
   **Given** I have the connections enabled  
   **When** other user clicks on my profile to connect with me  
   **Then** I should receive a prompt that someone wants to connect with me  
   **And** I should be able to accept it or not  
   * **Scenario**: User sends a connection request  
   **Given** I have the connections enabled  
   **And** I clicked another user's profile to connect with him/her  
   **When** he/she accepts the request  
   **Then** I should be notified if he/she accepted it or not  
   
4. Acceptance tests for **Friends**:  
   * **Scenario**: User wants to see whom it has connected with  
   **Given** I have connected with someone else  
   **When** I enter the friends page  
   **Then** I should see a list of the users I already connected with until now  
   * **Scenario**: User clicks a friend profile  
   **Given** I am in the profile page  
   **And** I am connected to the server  
   **When** I click a user's profile  
   **Then** I should be able to see all its shared information  
   
5. Acceptance tests for **Smart Badge**:  
   * **Scenario**: User enters the connection page to network with others  
   **Given** I have the bluetooth turned off  
   **When** I enter the connections page  
   **Then** I should be prompted to turn on bluetooth  
   * **Scenario**: User wants to pair with his/hers smart badge to network  
   **Given** I have bluetooth turned on  
   **And** I have the smart badge turned on  
   **When** I enable the connections  
   **Then** I should be prompted to enter the badge's name to pair with it  
   * **Scenario**: User is paired to smart badge and will start to network  
   **Given** I am paired with my smart badge  
   **When** I am in the connections page  
   **Then** I should be visible to other users  
   **And** I should be able to connect with them  

### Domain model

The software is more than a mobile application, it extends a physical connection based on person-on-person interaction, so our protaganists are people, each and every conference attendee is a fundamental piece since our module is based on Networking.
Furthermore, the model can be presented in a simpler and more abrastact way:

![Domain Model Diagram](https://i.imgur.com/s9F3QsO.png)

This means there are (at least) two intervenients, two people, having each one their own badge. One badge has two micro:bits, they communicate with each other and do so in a way they can interact with it's owner (through the application) and other micro:bits from other badges (other people).  
The user connects to his/hers own badge through their phones, and the badges will look for other ones in a near distance and trade information about each owner. The goal is to break the ice and make the approach easier.

---

## Architecture and Design 

The system is divided into 3 entities, a **server** containing user data, a **smart badge** that trades data with other badges and a **mobile app** that connects to the other two.

The **mobile app** is the central point of the system, establishing a relationship with the server when it comes to saving user data and retrieving info to make the matching of interests between users, and also it establishes a relationship with the smart badges, being the controller of the data that these devices receive and transmit. This way, the app creates an indirect connection between the server and the badges, while also being the interface between the user and the system.

One of the challenges of using Flutter was using futures and asynchronous functions. We found that using the Listener design pattern was a good way of dealing with these subject. 

The following code aims to showcase an example of how we dealt with Flutter asynchronous code:

```
  void subscribe(Function onData) {
    this.txCharacteristic.setNotifyValue(true);
    subscription = this.txCharacteristic.value.listen(onData);
  }
```

This function is responsible for setting a callback function that is called when the app receives data from the Micro:Bit via Bluetooth.


### Logical architecture

![](https://i.imgur.com/9kVnJf5.png)

The diagram above represents the logical dependencies of the system, where:
* The "Core" modules manage the corresponding package and estabilish a connection between other modules.
* The "Database" module warehouses user data.
* The "server Connection" module provides to the App a way to request and upload data from the Server's database.
* The "Bluetooth" module provides to the App and the Smart Badge a way to communicate and trade data.
* The "Radio" module provides to the Smart Badge a way to trade information with other nearby Smart Badges.
* The "Frontend" module allows the user to interact with the app in an intuitive way.


### Physical architecture

![](https://i.imgur.com/g7FU8PC.png)

Below is a more informal diagram of the application's physical aspect. 

![Physical diagram](https://i.imgur.com/rr9Gvl4.png)

The app is divided into 3 parts:  
1. A mobile application, with which the user can interact, built in Flutter.  
2. A server, which houses user information and is consulted by the mobile app, built in sqlite.  
3. A module consisting of two Microbits bolted together, one of which connects to the mobile app via BLE and another one that trades information with nearby users' modules via radio. This module is programmed with the Microbit's own version of Javascript/Typescript. The choice to use two Microbits connected via Pins was made due to their limitation on the use of radio and BLE concurrently.  


### Prototype
Our prototype was made during the first iteration of development. At the time, we were exploring Flutter and starting to understand how to code on Micro:Bits. Check out our prototype [here](https://github.com/softeng-feup/open-cx-muppets/tree/iteration1).  
This prototype is a representation of our final frontend and a bit of navigational logic between pages. Since we were not really into Flutter and Bluetooth at the time, we did not manage to prototype the bluetooth connection or advanced async code widget drawing.

---

## Implementation

During the implementation of our project, we encountered a few problems with the chosen technology, in particular with the Micro:Bit devices, so our solution may seem a bit confusing at first for those that are not familiar with these devices.

Our initial idea was for each user to have a single Micro:Bit device that would receive, through Radio, ids from Micro:Bits of the other users, and send them to the phone app via Bluetooth. However, these devices do not allow that both ways of transmitting data are used in the same program. We tried many approaches, and finally we came up with a workaround that consisted on using two Micro:Bit devices per person, functioning as one. One is responsible for communication with the app, and the other is responsible for the communication with the other users' devices and both communicate to each other through pins.

If you want to learn more about our approach to this problem you should consult the following code files:

- [Micro:Bit program that makes the device communicate with app through Bluetooth and with the other Micro:bit device via pins](../Microbit/bluetooth_microbit.js);

- [Micro:Bit program that makes the device transmit an id that was received through pins to other Micro:Bit devices via radio](../Microbit/radio_microbit.js);

- [Dart files used in the app program to connect and communicate with a Micro:Bit device via Bluetooth using the framework FlutterBlue](../app/lib/MicroBit.dart).

---
## Test

Thanks to Flutter Hot Reload feature, our tests were mostly manual. In addition, there is no good way to automate tests on Micro:Bit's, therefore we decided to focus on manually testing while iterating through development.
We tested the following features thoroughly:
1. MicroBit to MicroBit communication through the analogical pins;
2. MicroBit to MicroBit communication through radio broadcasting;
3. MicroBit to App communication through BLE technology;
4. App's navigation between pages (going from page to page and backwards to unsure pages are inserted correctly in the navigation stack);
5. Database access and retrieval of id's and information;
6. In the connections page, when the bluetooth is turned off the connections should be disabled;
7. When the bluetooth is off, the connections page should have a special page to ask the user to turn on bluetooth;
8. When the user activates the connections toggle, the user should be prompted to pair with the MicroBit;
9. When the MicroBit sends an id throudh bluetooth, the corresponding user profile should appear in the connections page list of people;
10. When the user clicks on a Pair button in the connections page, the person whom the user paired with should be added to the user's friend list;
11. Friends page should load all the user's friends until the moment;
12. From the Friends page the user should be able to check the friend's profile and delete it has a friend if the user chooses to do so;
13. On Profile, Contacts and Interests page the data should be persistent, which means that every changed should be saved on page exiting.

These are the main features of our app. All of these features were tested and approved.
For app features we developed some widget and integration tests using Flutter Test and Flutter Driver API's.

---
## Configuration and change management

App is being developed on the branch AppDevelopment, while the smart badge related features are being pushed to MicrobitDevelopment. When a feature is ready and fully working and tested on any of these branches, please open a pull request to master so that we can easily track where things came from.  
The network graph will look something like this:
![](https://i.imgur.com/prNQsW0.png)

---

## Project management
Links to tools that we are using to help us in **project management**:
 * [Trello](https://trello.com/invite/b/MXBGlhdc/09baa83ddec594a9bbf437bb992e25cc/esof)
 * [HackMD](https://hackmd.io/@WXva0k_6S66l9G5iSDhcIg/r1HOA0TKr)
 * [Miro](https://miro.com/welcomeonboard/srAHTyf3YwwUpZPIWkH3PWz3Z1F9Nza0EY9wDZJHeifXKBoN5CcVVDcjsXbWxWz2)

Feel free to checkout how we are planning everything :)
