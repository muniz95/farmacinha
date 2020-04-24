import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB _instance = new DB.internal();
  factory DB() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DB.internal();

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("""
      CREATE TABLE Medicine(
        id INTEGER PRIMARY KEY,
        name TEXT,
        hourSpan INTEGER
      )
    """);
    await db.execute("""
      CREATE TABLE Doctor(
        id INTEGER PRIMARY KEY,
        crm INTEGER,
        name TEXT,
        speciality TEXT,
        lastAppointment DATETIME
      )
    """);
    await db.execute("""
      CREATE TABLE Local(
        id INTEGER PRIMARY KEY,
        doctorid INTEGER,
        name TEXT,
        longitude REAL,
        latitude REAL
      )
    """);
    print("Created tables");
  }
}