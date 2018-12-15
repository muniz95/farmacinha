import 'dart:io' as io;
import 'package:farmacinha/models/medicine_model.dart';
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

  initDb() async {
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
    print("Created tables");
  }

  Future<int> saveMedicine(Medicine medicine) async {
    var dbClient = await db;
    int res = await dbClient.insert("Medicine", medicine.toMap());
    return res;
  }

  Future<int> updateMedicine(Medicine medicine) async {
    var dbClient = await db;
    int res = await dbClient.update("Medicine", medicine.toMap(), where: 'id = ${medicine.id}');
    return res;
  }

  Future<int> deleteMedicines() async {
    var dbClient = await db;
    int res = await dbClient.delete("Medicine");
    return res;
  }

  Future<List<Medicine>> getMedicines() async {
    var dbClient = await db;
    List<Medicine> medicines = new List<Medicine>();
    List<Map> medicineRaw = await dbClient.query("Medicine");
    
    if (medicineRaw.length > 0) {
      medicineRaw.forEach((medicine) {
        medicines.add(new Medicine.map(medicine));
      });
    }

    return medicines;
  }
}