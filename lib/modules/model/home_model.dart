// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
  Data? data;

  HomeModel({this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      HomeModel(data: Data.fromJson(json["data"]));
}

class Data {
  List<Late>? popular;
  List<Late>? lates;

  Data({this.popular, this.lates});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    popular: List<Late>.from(json["Popular"].map((x) => Late.fromJson(x))),
    lates: List<Late>.from(json["Lates"].map((x) => Late.fromJson(x))),
  );
}

class Late {
  String? name;
  String? images;
  String? description;

  Late({this.name, this.images, this.description});

  factory Late.fromJson(Map<String, dynamic> json) => Late(
    name: json["name"],
    images: json["images"],
    description: json["description"],
  );
}
