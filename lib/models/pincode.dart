// To parse this JSON data, do
//
//     final pinCodeSearchModel = pinCodeSearchModelFromJson(jsonString);

import 'dart:convert';

List<PinCodeSearchModel> pinCodeSearchModelFromJson(String str) =>
    List<PinCodeSearchModel>.from(
        json.decode(str).map((x) => PinCodeSearchModel.fromJson(x)));

String pinCodeSearchModelToJson(List<PinCodeSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PinCodeSearchModel {
  PinCodeSearchModel({
    this.pincode,
    this.city,
    this.express,
  });

  String? pincode;
  String? city;
  bool? express;

  factory PinCodeSearchModel.fromJson(Map<String, dynamic> json) =>
      PinCodeSearchModel(
        pincode: json["pincode"],
        city: json["city"],
        express: json["express"],
      );

  Map<String, dynamic> toJson() => {
        "pincode": pincode,
        "city": city,
        "express": express,
      };
}
