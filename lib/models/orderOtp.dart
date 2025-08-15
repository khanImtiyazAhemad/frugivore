// To parse this JSON data, do
//
//     final orderOtpModel = orderOtpModelFromJson(jsonString);

import 'dart:convert';

OrderOtpModel orderOtpModelFromJson(String str) => OrderOtpModel.fromJson(json.decode(str));

String orderOtpModelToJson(OrderOtpModel data) => json.encode(data.toJson());

class OrderOtpModel {
    OrderOtpModel({
        this.remainingTime,
    });

    int? remainingTime;

    factory OrderOtpModel.fromJson(Map<String, dynamic> json) => OrderOtpModel(
        remainingTime: json["remaining_time"],
    );

    Map<String, dynamic> toJson() => {
        "remaining_time": remainingTime,
    };
}
