import 'dart:io';

import 'package:majootestcase/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static final DbHelper instance = new DbHelper.internal();
  factory DbHelper()=> instance;

  static Database _database;
  final String userTable = "User";
  final String usernameColumn = "username";
  final String emailColumn = "email";
  final String passwordColumn = "password";

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  DbHelper.internal();

  //Init Database
  initDatabase()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "movie.db");
    var dbMovie = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbMovie;
  }

  // Create Table
  void _onCreate(Database database, int version) async{
    await database.execute(
      "CREATE TABLE User("
          "id INTEGER PRIMARY KEY, "
          "username TEXT,"
          "email TEXT,"
          "password TEXT)"
    );
    print("Table Created");
  }

  //Insert
  Future<int> insertUser(User user)async{
      var databaseClient = await database;
      print(user.userName);
      int res = await databaseClient.insert(userTable, user.toJson());
      List<Map> list = await databaseClient.rawQuery('SELECT * FROM User');
      print(list);
      return res;
  }

  //Select
  Future<User>selectUser(User user) async{
    var databaseClient = await database;
    var maps = await databaseClient.query(
      userTable,
      columns: [emailColumn, passwordColumn],
      where: "$emailColumn = ? and $passwordColumn = ?",
      whereArgs: [user.email, user.password]
    );

    print(maps);
    if(maps.length >0){
      var map = maps.toList().first;
      return User.fromJson(map);
    }else{
      return null;
    }
  }
}