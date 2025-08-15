// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({this.mobile, this.uuid, this.image});

  String? mobile;
  String? uuid;
  String? image;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
      mobile: json["mobile"], uuid: json['uuid'], image: json['image']);

  Map<String, dynamic> toJson() =>
      {"mobile": mobile, "uuid": uuid, "image": image};
}

class LoginBannerModel {
  LoginBannerModel({this.image});

  String? image;

  factory LoginBannerModel.fromJson(Map<String, dynamic> json) =>
      LoginBannerModel(image: json['image']);

  Map<String, dynamic> toJson() => {"image": image};
}
