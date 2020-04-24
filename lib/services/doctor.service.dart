import 'package:farmacinha/config/db.dart';
import 'package:farmacinha/models/doctor.model.dart';
import 'package:farmacinha/services/local.service.dart';

class DoctorService {
  final DB instance = DB();
  final LocalService localService = LocalService();

  DoctorService() {
    this.instance.initDb();
  }
  
  Future<List<Doctor>> getAllDoctors() async {
    final db = await instance.db;
    List<Doctor> doctors = List<Doctor>();
    List<Map> doctorRaw = await db.query("Doctor");
    
    if (doctorRaw.length > 0) {
      doctorRaw.forEach((doctor) {
        doctors.add(Doctor.map(doctor));
      });
    }

    return doctors;
  }
  
  Future<int> saveDoctor(Doctor doctor) async {
    final db = await instance.db;
    int res = await db.insert("Doctor", doctor.toMap());
    if (res != null) {
      await localService.saveLocals(doctor.locals);
      return res;
    }
    else {
      return 0;
    }
  }
  
  Future<int> updateDoctor(Doctor doctor) async {
    var db = await instance.db;
    int res = await db.update("Doctor", doctor.toMap(), where: 'id = ${doctor.id}');
    return res;
  }

  Future<int> deleteDoctors() async {
    var db = await instance.db;
    int res = await db.delete("Doctor");
    return res;
  }
}