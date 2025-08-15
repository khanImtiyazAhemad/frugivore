// To parse this JSON data, do
//
//     final preOrderModel = preOrderModelFromJson(jsonString);

import 'dart:convert';

PreOrderModel preOrderModelFromJson(String str) => PreOrderModel.fromJson(json.decode(str));

String preOrderModelToJson(PreOrderModel data) => json.encode(data.toJson());

class PreOrderModel {
    PreOrderModel({
        this.dateRange,
        this.preOrderItemsCount,
        this.preOrderAmount,
        this.remaingingItemsCount,
        this.remainingOrderAmount,
    });

    String? dateRange;
    int? preOrderItemsCount;
    String? preOrderAmount;
    int? remaingingItemsCount;
    String? remainingOrderAmount;

    factory PreOrderModel.fromJson(Map<String, dynamic> json) => PreOrderModel(
        dateRange: json["date_range"],
        preOrderItemsCount: json["pre_order_items_count"],
        preOrderAmount: json["pre_order_amount"],
        remaingingItemsCount: json["remainging_items_count"],
        remainingOrderAmount: json["remaining_order_amount"],
    );

    Map<String, dynamic> toJson() => {
        "date_range": dateRange,
        "pre_order_items_count": preOrderItemsCount,
        "pre_order_amount": preOrderAmount,
        "remainging_items_count": remaingingItemsCount,
        "remaining_order_amount": remainingOrderAmount,
    };
}
