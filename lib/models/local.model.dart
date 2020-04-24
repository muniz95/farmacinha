import 'doctor.model.dart';

class Local {
  Local({
    this.id,
    this.doctor,
    this.name,
    this.longitude,
    this.latitude
  });

  int id;
  Doctor doctor;
  String name;
  double longitude;
  double latitude;

  factory Local.map(dynamic obj) {
    return Local(
      id: obj["id"],
      doctor: obj["doctor"],
      name: obj["name"],
      longitude: obj["longitude"],
      latitude: obj["latitude"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = id;
    map["doctorid"] = doctor.id;
    map["name"] = name;
    map["longitude"] = longitude;
    map["latitude"] = latitude;

    return map;
  }
}