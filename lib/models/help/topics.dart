// To parse this JSON data, do
//
//     final helpTopicsModel = helpTopicsModelFromJson(jsonString);

import 'package:frugivore/models/order/myOrder.dart';

import 'dart:convert';

HelpTopicsModel helpTopicsModelFromJson(String str) =>
    HelpTopicsModel.fromJson(json.decode(str));

String helpTopicsModelToJson(HelpTopicsModel data) =>
    json.encode(data.toJson());

class HelpTopicsModel {
  HelpTopicsModel({
    this.data,
    this.lastOrder,
  });

  List<Datum>? data;
  Result? lastOrder;

  factory HelpTopicsModel.fromJson(Map<String, dynamic> json) =>
      HelpTopicsModel(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        lastOrder: json["last_order"] == null
            ? null
            : Result.fromJson(json["last_order"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_order": lastOrder?.toJson(),
      };
}

class Datum {
  Datum({required this.uuid, required this.topic, required this.icon, required this.redirection});

  String uuid;
  String topic;
  String icon;
  String redirection;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        topic: json["topic"],
        icon: json["icon"],
        redirection: json["redirection"],
      );

  Map<String, dynamic> toJson() => {
        "uuid":  uuid,
        "topic":  topic,
        "icon":  icon,
        "redirection": redirection,
      };
}
