import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class BlueSkyDatabase {
  static final BlueSkyDatabase _instance = BlueSkyDatabase._internal();

  factory BlueSkyDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  BlueSkyDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE Location (id INTEGER PRIMARY KEY, latitude INTEGER, longitude INTEGER, city TEXT, suburb TEXT)"
      );

    await db.execute(
      "CREATE TABLE CurrentForecast (id INTEGER PRIMARY KEY, latitude INTEGER, longitude INTEGER, city TEXT, suburb TEXT)"
      );

    print("Database was Created!");
  }
}
