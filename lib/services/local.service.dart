import 'package:farmacinha/config/db.dart';
import 'package:farmacinha/models/local.model.dart';

class LocalService {
  final DB instance = new DB();

  LocalService() {
    this.instance.initDb();
  }
  
  Future<List<Local>> getAllLocals() async {
    final db = await instance.db;
    List<Local> doctors = new List<Local>();
    List<Map> doctorRaw = await db.query("Local");
    
    if (doctorRaw.length > 0) {
      doctorRaw.forEach((local) {
        doctors.add(new Local.map(local));
      });
    }

    return doctors;
  }
  
  Future<List<int>> saveLocals(List<Local> locals) async {
    List<int> results;
    for (var local in locals) {
      results.add(await saveLocal(local));
    }
    return results;
  }
  
  Future<int> saveLocal(Local local) async {
    final db = await instance.db;
    int res = await db.insert("Local", local.toMap());
    return res;
  }
  
  Future<int> updateLocal(Local local) async {
    var db = await instance.db;
    int res = await db.update("Local", local.toMap(), where: 'id = ${local.id}');
    return res;
  }

  Future<int> deleteLocals() async {
    var db = await instance.db;
    int res = await db.delete("Local");
    return res;
  }
}