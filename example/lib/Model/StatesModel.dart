class StatesModel {
  int id;
  String name;
  int code;
  int countryId;

  StatesModel({
    required this.id,
    required this.name,
    required this.code,
    required this.countryId,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "country_id": countryId,
  };


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatesModel &&
        other.id == id &&
        other.name == name &&
        other.countryId == countryId &&
        other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ code.hashCode;
  }

  @override
  String toString() {
    return name;
  }

}
