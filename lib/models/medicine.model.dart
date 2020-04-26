import 'doctor.model.dart';

class Medicine {
  Medicine({this.id, this.doctor, this.name, this.hourSpan});

  int id;
  Doctor doctor;
  String name;
  int hourSpan;

  factory Medicine.map(dynamic obj) {
    var doctor = Doctor()..id = obj["doctorid"];
    return new Medicine(
      id: obj["id"],
      doctor: doctor,
      name: obj["name"],
      hourSpan: obj["hourSpan"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = id;
    map["doctorid"] = doctor.id;
    map["name"] = name;
    map["hourSpan"] = hourSpan;

    return map;
  }

  String timespan () => "$name - $hourSpan em $hourSpan horas";
}