// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

MyOrderModel myOrderModelFromJson(String str) =>
    MyOrderModel.fromJson(json.decode(str));

String myOrderModelToJson(MyOrderModel data) => json.encode(data.toJson());

class MyOrderModel {
  MyOrderModel({
    this.page,
    this.maxPage,
    this.count,
    this.next,
    this.previous,
    this.results,
    this.invoices,
  });
  int? page;
  int? maxPage;
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;
  List<String>? invoices;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        page: json["page"],
        maxPage: json['max_page'],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        invoices: json["invoices"] == null
            ? null
            : List<String>.from(json["invoices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "invoices": invoices == null
            ? null
            : List<dynamic>.from(invoices!.map((x) => x)),
      };
}

class Result {
  Result({
    this.totalItems,
    this.orderType,
    this.invoiceNumber,
    this.orderStatus,
    this.totalPrice,
    this.deliverySlot,
    this.rating,
    this.comment,
    this.orderId,
    this.orderplaced,
    this.orderprocessed,
    this.outfordelivery,
    this.delivered,
    this.cancelled,
    this.canCancel,
    this.canRepeatOrder,
    this.canRaisedComplaint,
    this.canGiveFeedback,
    this.claimRefund,
    this.deliveryBoy,
    this.deliveryBoyNumber
  });

  int? totalItems;
  String? orderType;
  String? invoiceNumber;
  String? orderStatus;
  String? totalPrice;
  String? deliverySlot;
  int? rating;
  dynamic comment;
  String? orderId;
  OrderTime? orderplaced;
  OrderTime? orderprocessed;
  OrderTime? outfordelivery;
  OrderTime? delivered;
  OrderTime? cancelled;
  bool? canCancel;
  bool? canRepeatOrder;
  bool? canRaisedComplaint;
  bool? canGiveFeedback;
  bool? claimRefund;
  String? deliveryBoy;
  String? deliveryBoyNumber;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        totalItems: json["total_items"],
        orderType: json["order_type"],
        invoiceNumber: json["invoice_number"],
        orderStatus: json["order_status"],
        totalPrice: json["total_price"],
        deliverySlot: json["delivery_slot"],
        rating: json["rating"],
        comment: json["comment"],
        orderId: json["order_id"],
        orderplaced: OrderTime.fromJson(json["orderplaced"]),
        orderprocessed: OrderTime.fromJson(json["orderprocessed"]),
        outfordelivery: OrderTime.fromJson(json["outfordelivery"]),
        delivered: OrderTime.fromJson(json["delivered"]),
        cancelled: OrderTime.fromJson(json["cancelled"]),
        canCancel: json["can_cancel"],
        canRepeatOrder: json["can_repeat_order"],
        canRaisedComplaint: json["can_raised_complaint"],
        canGiveFeedback: json["can_give_feedback"],
        claimRefund: json['claim_refund'],
        deliveryBoy: json['delivery_boy'] == null ? null : json["delivery_boy"],
        deliveryBoyNumber: json['delivery_boy_number'] == null ? null : json["delivery_boy_number"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "order_type": orderType,
        "invoice_number": invoiceNumber,
        "order_status": orderStatus,
        "total_price": totalPrice,
        "delivery_slot": deliverySlot,
        "rating": rating,
        "comment": comment,
        "order_id": orderId,
        "orderplaced": orderplaced!.toJson(),
        "orderprocessed": orderprocessed!.toJson(),
        "outfordelivery": outfordelivery!.toJson(),
        "delivered": delivered!.toJson(),
        "cancelled": cancelled!.toJson(),
        "can_cancel": canCancel,
        "can_repeat_order": canRepeatOrder,
        "can_raised_complaint": canRaisedComplaint,
        "can_give_feedback": canGiveFeedback,
        "claim_refund": claimRefund,
        "delivery_boy": deliveryBoy,
        "delivery_boy_number": deliveryBoyNumber
      };
}

class OrderTime {
  OrderTime({
    this.text,
    this.time,
    this.date,
  });

  String? text;
  String? time;
  String? date;

  factory OrderTime.fromJson(Map<String, dynamic> json) => OrderTime(
        text: json["text"],
        time: json["time"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "time": time,
        "date": date,
      };
}
