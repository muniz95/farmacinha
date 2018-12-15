class Medicine {
  Medicine({this.id, this.name, this.hourSpan});

  int id;
  String name;
  int hourSpan;

  factory Medicine.map(dynamic obj) {
    return new Medicine(
      id: obj["id"],
      name: obj["name"],
      hourSpan: obj["hourSpan"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["hourSpan"] = hourSpan;

    return map;
  }
}