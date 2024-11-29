class CityModel {
  final int id;
  final String name;
  final int stateId;
  final String isActive;

  CityModel({required this.id, required this.name, required this.stateId, required this.isActive});


  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    isActive: json["isActive"]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "isActive": isActive,
  };

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //
  //   return other is CityModel &&
  //       other.id == id &&
  //       other.name == name &&
  //       other.stateId == stateId &&
  //       other.isActive == isActive;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^ name.hashCode ^ stateId.hashCode ^ isActive.hashCode;
  // }

  @override
  String toString() {
    return name;
  }

}
