import 'dart:async';
import 'package:app/Database/Friends.dart';
import 'package:app/Database/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//Database scripts to promote encapsulation

// Singleton class to mock the database
class MMDatabase {
  static final MMDatabase _instance = MMDatabase._internal();
  String _path;
  Database _database;

  factory MMDatabase() {
    return _instance;
  }

  MMDatabase._internal() {
    _setupDb();
  }

  void _setupDb() async {
    await _loadPath();
    //await _deleteDb();
    await _initDb();
    await _populateDb();
  }

  Future<void> _loadPath() async {
    String _databasesPath = await getDatabasesPath();
    _path = join(_databasesPath, 'demo.db');
  }

  Future<void> _deleteDb() async {
    await deleteDatabase(_path);
  }

  Future<void> _initDb() async {
    _database = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the tables
      await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, nationality TEXT,occupation TEXT, company TEXT, languages TEXT, contacts TEXT, interests TEXT)');
      await db.execute(
          'CREATE TABLE friends (user_id INTEGER , friend_id Integer, PRIMARY KEY(user_id, friend_id), FOREIGN KEY (user_id) REFERENCES User(id), FOREIGN KEY (friend_id) REFERENCES User(id))');
    });
  }

  Future<void> _populateDb() async {
    List<User> users = <User>[];
    List<Friends> friends = <Friends>[];

    users.add(User(
      id: 1,
      name: 'John Doe',
      nationality: 'North American',
      occupation: 'IT consultant',
      company: 'SomeInk Software',
      languages: 'English',
      contacts: ['123', 'johnemail@smh.com'],
      interests: ['javascript', 'iot', 'software engineering'],
    ));
    users.add(User(
      id: 2,
      name: 'Ana Amarelo',
      nationality: 'Portuguese',
      occupation: 'Scientist',
      company: 'CGI Enterprise',
      languages: 'Portuguese',
      contacts: ['456', 'anaemail@smh.com'],
      interests: ['python', 'research', 'quantum computing'],
    ));
    users.add(User(
      id: 3,
      name: 'Red Resnikov',
      nationality: 'Russian',
      occupation: 'Cybersecurity Expert',
      company: 'CyberWall',
      languages: 'Russian',
      contacts: ['789', 'redemail@smh.com'],
      interests: ['javascript', 'database management', 'web development'],
    ));

    friends.add(Friends(user_id: 1, friend_id: 2));
    friends.add(Friends(user_id: 1, friend_id: 3));
    friends.add(Friends(user_id: 2, friend_id: 1));
    friends.add(Friends(user_id: 3, friend_id: 1));

    // Insert the User into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same user is inserted
    // multiple times, it replaces the previous data.
    users.forEach((user) async {
      await _database.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    friends.forEach((friend) async {
      await _database.insert(
        'friends',
        friend.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<User> getUser(int id) async {
    final List<Map<String, dynamic>> map =
        await _database.query('users', where: 'id = ?', whereArgs: [id]);
    
    var userContacts = map[0]['contacts'];
    var userInterests = map[0]['interests'];

    return User(
      id: map[0]['id'],
      name: map[0]['name'],
      nationality: map[0]['nationality'],
      occupation: map[0]['occupation'],
      company: map[0]['company'],
      languages: map[0]['languages'],
      contacts: userContacts.split(','),
      interests: userInterests.split(','),
    );
  }

  Future<List<User>> getRangeOfUsers(List<int> ids) async {
    List<User> users = <User>[];

    ids.forEach((id) async {
      var user = await getUser(id);

      users.add(user);
    });

    return users;
  }
}
