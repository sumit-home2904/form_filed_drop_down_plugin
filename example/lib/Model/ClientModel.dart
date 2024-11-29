import 'dart:convert';


ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  int id;
  int? roleId;
  String name;
  String mobile;
  String email;
  String? address;
  String? companyName;
  String? companyWebsite;
  String? username;
  String? password;
  int? image;
  String? gstNo;
  bool? isActive;
  bool? isEmailSend;
  String? zipCode;
  String? alternateMobile;
  Role? city;
  Role? state;
  Role? countryinfo;
  Images? images;
  DateTime? dob;

  ClientModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    this.roleId,
    this.address,
    this.companyName,
    this.companyWebsite,
    this.username,
    this.password,
    this.image,
    this.gstNo,
    this.isActive,
    this.isEmailSend,
    this.alternateMobile,
    this.zipCode,
    this.city,
    this.state,
    this.countryinfo,
    this.images,
    this.dob,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json["id"],
    roleId: json["roleId"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    companyName: json["company_name"],
    companyWebsite: json["company_website"],
    username: json["username"]??"--",
    password: json["password"]==null?"":json["password"],
    image: json["image"]??0,
    gstNo: json["gst_no"],
    isActive: json["is_Active"],
    isEmailSend: json["is_email_send"],
    alternateMobile: json["alternate_mobile"],
    zipCode: json["zip_code"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    city: json["city"] == null ? null : Role.fromJson(json["city"]),
    state: json["state"] == null ? null : Role.fromJson(json["state"]),
    countryinfo: json["countryinfo"] == null ? null : Role.fromJson(json["countryinfo"]),
    images:  json["images"] == null ? null : Images.fromJson(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleId":roleId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "company_name": companyName,
    "company_website": companyWebsite,
    "username":username,
    "password":password,
    "image": image,
    "gst_no": gstNo,
    "is_Active": isActive,
    "is_email_send": isEmailSend,
    "zip_code": zipCode,
    "city": city?.toJson(),
    "state": state?.toJson(),
    "countryinfo": countryinfo?.toJson(),
    "images": images!.toJson()
  };
}

class Role {
  int? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


class City {
  int id;
  String name;
  StateName? state;

  City({
    required this.id,
    required this.name,
    required this.state,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    state: json["state"]==null?null:StateName.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state": state!.toJson(),
  };
}

class StateName {
  int id;
  String name;
  int? code;
  Country? country;

  StateName({
    required this.id,
    required this.name,
    required this.code,
    this.country,
  });

  factory StateName.fromJson(Map<String, dynamic> json) => StateName(
    id: json["id"],
    name: json["name"],
    code: json["code"]==null?null:json["code"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "country": country,
  };
}


class Country {
  int id;
  String name;
  String? code;

  Country({
    required this.id,
    required this.name,
     this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    code: json["code"]==null?null:json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

class Images {
  String path;
  int id;
  String filename;

  Images({
    required this.path,
    required this.id,
    required this.filename,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    path: json["path"],
    id: json["id"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "id": id,
    "filename": filename,
  };
}