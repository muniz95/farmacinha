import 'package:farmacinha/config/db.dart';
import 'package:farmacinha/models/medicine_model.dart';

class MedicineService {
  final DB db = new DB();

  MedicineService() {
    this.db.initDb();
  }
  
  Future<List<Medicine>> getAllMedicines() async {
    return await this.db.getMedicines();
  }
  
  Future<int> saveMedicine(Medicine task) async {
    return await this.db.saveMedicine(task);
  }
  
  Future<int> updateMedicine(Medicine task) async {
    return await this.db.updateMedicine(task);
  }
}