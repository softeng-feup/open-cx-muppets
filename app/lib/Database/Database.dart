import 'dart:async';
import 'package:app/Database/Friends.dart';
import 'package:app/Database/User.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
//Database scripts to promote encapsulation

// Singleton class to mock the database
class MMDatabase {
  static final MMDatabase _instance = MMDatabase._internal();
  int _id;
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
    await _deleteDb();
    await _initDb();
    await _populateDb();
  }

  void setID(int id) {
    this._id = id;
  }

  int getID() {
    return this._id;
  }

  void _saveID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', this._id);
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
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, nationality TEXT,occupation TEXT, company TEXT, contacts TEXT, interests TEXT)');
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
      contacts: ['123', 'johnemail@smh.com'],
      interests: ['javascript', 'iot', 'software engineering'],
    ));
    users.add(User(
      id: 2,
      name: 'Ana Amarelo',
      nationality: 'Portuguese',
      occupation: 'Scientist',
      company: 'CGI Enterprise',
      contacts: ['456', 'anaemail@smh.com'],
      interests: ['python', 'research', 'quantum computing'],
    ));
    users.add(User(
      id: 3,
      name: 'Red Resnikov',
      nationality: 'Russian',
      occupation: 'Cybersecurity Expert',
      company: 'CyberWall',
      contacts: ['789', 'redemail@smh.com'],
      interests: ['javascript', 'database management', 'web development'],
    ));

    friends.add(Friends(userID: 1, frindID: 2));
    friends.add(Friends(userID: 1, frindID: 3));
    friends.add(Friends(userID: 2, frindID: 1));
    friends.add(Friends(userID: 3, frindID: 1));

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

    if(map.isEmpty) {
      return User(id: -1);
    }

    var userContacts = map[0]['contacts'];
    var userInterests = map[0]['interests'];

    return User(
      id: map[0]['id'],
      name: map[0]['name'],
      nationality: map[0]['nationality'],
      occupation: map[0]['occupation'],
      company: map[0]['company'],
      contacts: userContacts.split(','),
      interests: userInterests.split(','),
    );
  }

  Future<User> getThisUser() async {
    final List<Map<String, dynamic>> map =
        await _database.query('users', where: 'id = ?', whereArgs: [this._id]);

    if(map.isEmpty) {
      return User(id: -1);
    }

    var userContacts = map[0]['contacts'];
    var userInterests = map[0]['interests'];

    return User(
      id: map[0]['id'],
      name: map[0]['name'],
      nationality: map[0]['nationality'],
      occupation: map[0]['occupation'],
      company: map[0]['company'],
      contacts: userContacts.split(','),
      interests: userInterests.split(','),
    );
  }

  Future<void> updateUserInterests(User user) async {
    if (this._id == -1) {
      insertUser(user);
      return;
    }

    await _database.update('users', user.getInterests(), where: 'id = ?', whereArgs: [this._id]);
  }

  Future<void> updateUserContacts(User user) async {
    if (this._id == -1) {
      insertUser(user);
      return;
    }

    await _database.update('users', user.getContacts(), where: 'id = ?', whereArgs: [this._id]);
  }

  Future<void> updateUserProfile(User user) async {
    if (this._id == -1) {
      insertUser(user);
      return;
    }

    await _database.update('users', user.getProfile(), where: 'id = ?', whereArgs: [this._id]);
  }

  Future<void> insertUser(User user) async {
    await _database.insert('users', user.toMap(noID: true), conflictAlgorithm: ConflictAlgorithm.replace);

    var map = await _database.query('users', columns: ['id'], orderBy: 'id DESC');
    this._id = map[0]['id'];

    _saveID();

    print(' Inserted id = ' + this._id.toString());
  }

  Future<List<User>> getRangeOfUsers(List<int> ids) async {
    List<User> users = <User>[];

    ids.forEach((id) async {
      var user = await getUser(id);

      users.add(user);
    });
    print('Length: ${users.length}');
    return users;
  }
}
