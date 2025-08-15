// To parse this JSON data, do
//
//     final welcomeModel = welcomeModelFromJson(jsonString);

import 'dart:convert';

WelcomeModel welcomeModelFromJson(String str) =>
    WelcomeModel.fromJson(json.decode(str));

String welcomeModelToJson(WelcomeModel data) => json.encode(data.toJson());

class WelcomeModel {
  WelcomeModel({this.message, this.type});

  String? message;
  String? type;

  factory WelcomeModel.fromJson(Map<String, dynamic> json) => WelcomeModel(
        message: json["message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "type": type,
      };
}
