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

}
