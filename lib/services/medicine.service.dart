import 'package:farmacinha/config/db.dart';
import 'package:farmacinha/models/medicine.model.dart';

class MedicineService {
  final DB instance = new DB();

  MedicineService() {
    this.instance.initDb();
  }
  
  Future<List<Medicine>> getAllMedicines() async {
    final db = await instance.db;
    List<Medicine> medicines = new List<Medicine>();
    List<Map> medicineRaw = await db.query("Medicine");
    
    if (medicineRaw.length > 0) {
      medicineRaw.forEach((medicine) {
        medicines.add(new Medicine.map(medicine));
      });
    }

    return medicines;
  }
  
  Future<int> saveMedicine(Medicine medicine) async {
    final db = await instance.db;
    int res = await db.insert("Medicine", medicine.toMap());
    return res;
  }
  
  Future<int> updateMedicine(Medicine medicine) async {
    var db = await instance.db;
    int res = await db.update("Medicine", medicine.toMap(), where: 'id = ${medicine.id}');
    return res;
  }

  Future<int> deleteMedicines() async {
    var db = await instance.db;
    int res = await db.delete("Medicine");
    return res;
  }
}