import 'local.model.dart';

class Doctor {
  Doctor({
    this.id, 
    this.crm, 
    this.name, 
    this.speciality, 
    this.lastAppointment, 
    this.locals
  });

  int id;
  int crm;
  String name;
  String speciality;
  DateTime lastAppointment;
  List<Local> locals;

  factory Doctor.map(dynamic obj) {
    return Doctor(
      id: obj["id"],
      crm: obj["crm"],
      name: obj["name"],
      speciality: obj["speciality"],
      lastAppointment: obj["lastAppointment"],
      locals: obj["locals"] == null ? [] : obj["locals"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = id;
    map["crm"] = crm;
    map["name"] = name;
    map["speciality"] = speciality;
    map["lastAppointment"] = lastAppointment;

    return map;
  }

  String toString() => "$name - Especialidade: $speciality";
}