import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class BlueSkyDatabase {
  
  static final BlueSkyDatabase _instance = BlueSkyDatabase._internal();

  factory BlueSkyDatabase() => _instance;

  static Database _db;
}
