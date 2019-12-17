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

The goal of this product is to facilitate spontaneous interaction between conference participants, by providing them with a means to find people with similar interests near them and initiate conversations. It's also important to us that the users can keep their privacy and power of choice, as we intend to improve their experience, not enforce anything on them. For this goal we plan to use a mobile app, installed on the user's phone, paired with Micro:Bit systems, implanted in the user's badge. The app will contain user profiles with tags for matching between them, while the Micro:Bit will simply detect nearby users and.

---
## Requirements

The following sections describe our users requirements (or at least what we think they need).
Our module is aimed at networking. Therefore, our main guiding lines are **privacy**, **usability** and **user interactions**. We want the user to share only what he/she wants to share, but always encouraging him/her to interact with other users by making it easy to start a conversation.

### Use case diagram 

> Create a use-case diagram in UML with all high-level use cases possibly addressed by your module.
>
> Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun. 
> 
> Briefly describe each use case mentioning the following:
> 
>* **Actor**. Name only the actor that will be initiating this use case, i.e. a person or other entity external to the software system being specified who interacts with the system and performs use cases to accomplish tasks. 
>* **Description**. Provide a brief description of the reason for and outcome of this use case, or a high-level description of the sequence of actions and the outcome of executing the use case. 
>* **Preconditions and Post conditions**. Include any activities that must take place, or any conditions that must be true, before the use case can be started (preconditions) and post conditions. Describe also the state of the system at the conclusion of the use case execution (post conditions). 
>
>* **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system. 
>* **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions. 

The following use case diagram aims to represent all high-level use cases present in our module:

![Use Case Diagram](https://i.imgur.com/ie3DPpn.jpg)

### Create Profile/Account

#### Actors 

This Use Case involves two actors:

- The **conference attendee** that interacts with our app.
- The **server** that receives and stores the user info.

#### Description 

When a user connects with another person successfully, he/she gains access to the other person's profile. For this to happen we need to store a profile for each app user.

#### Normal Flow

To create a new profile, each user has simply to go to the profile section and then just enter the information he/she wants to share with his/hers connections.
 
The steps for this use case are as follows:
- From the **home screen** the user goes to the **profile section**;
- He/She enters personal information like the user's name, nationality, occupation and company.
- The user can also add contacts so that after a session of networking with other people, he/she can easily be contacted outside of the app and the conference.

It is **important** for us that the user feels free when using our app. This way, the user is 100% free to enter only some information and leave other details out of the app. The user can even choose to not enter any kind of information, but, of course, wont get the full potential of our app.

#### Alternative Flows and Exceptions

Because our app is all about networking and facilitating the share of information between our users, any kind of information is acceptable to enter in any field as it is only going to be visualized by other users.


### User stories

The following image represents our current global user story map:
![User Story Map](https://i.imgur.com/G4R7nsJ.jpg)

The cards (starting at the row with tag 'User stories')  can be organized by row:  
1. **Profile Management** - login, register, editing profile  
Value - should have (Login and Register are not mandatory but useful)  
Estimated effort - M
3. **Interests Management** - adding and changing interests, seeing others interests  
Value - must have (Without interests the module does not make sense)  
Estimated effort - S
5. **Matching** - network with others, match by similar interests, enabling and disabling the matching system  
Value - must have  
Estimated effort - XL
7. **Friends** - make friends from previous connections, see friends profiles  
Value - could have (It is fun to see other's profiles, but it is more an extra)  
Estimated effort - XS
9. **Smart Badge** - make bluetooth connection easy, smart badge tech  
Value - must have  
Estimated effort - XL


**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in Gherkin), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.


### Domain model

>To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

---

## Architecture and Design
>The architecture of a software system encompasses the set of key decisions about its overall organization. 
>
>A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.
>
>To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 
>
>In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
>The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.
>
>It can be beneficial to present the system both in a horizontal or vertical decomposition:
>* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
>* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
>The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.
>
>It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

![Physical diagram](https://i.imgur.com/rr9Gvl4.png)

The app is divided into 3 parts:  
1. A mobile application, with which the user can interact, built in flutter.  
2. A server, which houses user information and is consulted by the mobile app.  
3. A module consisting of two Microbits bolted together, one of which connects to the mobile app via BLE and another one that trades information with nearby users' modules via radio. This module is programmed with the Microbit's own version of Javascript/Typescript. The choice to use two Microbits connected via Pins was made due to their limitation on the use of radio and BLE concurrently.  


### Prototype
>To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.
>
>In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
>During implementation, while not necessary, it 
>
>It might be also useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. 
>
>Since the code should speak by itself, try to keep this section as short and simple as possible.
>
>Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

>There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.
>
>In this section it is only expected to include the following:
>* test plan describing the list of features to be tested and the testing methods and tools;
>* test case specifications to verify the functionalities, using unit tests and acceptance tests.
> 
>A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

>Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).
>
>For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

>Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.
>
>In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.
>
>Example of tools to do this are:
>  * [Trello.com](https://trello.com)
>  * [Github Projects](https://github.com/features/project-management/com)
>  * [Pivotal Tracker](https://www.pivotaltracker.com)
>  * [Jira](https://www.atlassian.com/software/jira)
>
>We recommend to use the simplest tool that can possibly work for the team.

Links to tools that we are using to help us in **project management**:
 * [Trello](https://trello.com/invite/b/MXBGlhdc/09baa83ddec594a9bbf437bb992e25cc/esof)
 * [HackMD](https://hackmd.io/@WXva0k_6S66l9G5iSDhcIg/r1HOA0TKr)
 * [Miro](https://miro.com/welcomeonboard/srAHTyf3YwwUpZPIWkH3PWz3Z1F9Nza0EY9wDZJHeifXKBoN5CcVVDcjsXbWxWz2)
 * [Micro:bit MakeCode](https://makecode.microbit.org/76322-02853-99352-46492)
 * [GitHub](https://github.com/softeng-feup/open-cx-muppets)
