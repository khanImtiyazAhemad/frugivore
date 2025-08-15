// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel(
      {this.invoiceNumber,
      this.address,
      this.orderStatus,
      this.totalPrice,
      this.paymentUrl,
      this.deliverySlot,
      this.orderId,
      this.canDownloadInvoice,
      this.orderValue,
      this.deliveryCharges,
      this.carryBagPrice,
      this.modeOfPayment,
      this.discountPromocodeAmount,
      this.wallet,
      this.pendingAmount,
      this.totalRefund,
      this.availableRefund,
      this.refundedAmount,
      this.payNow,
      this.statusOfPayment,
      this.canRepeatOrder,
      this.canRaisedComplaint,
      this.deliveryDate,
      this.orderItems,
      this.canChangeDateTime,
      this.razorpayOrderId,
      this.totalRefundedItem,
      this.refundAvailableItem,
      this.refundToBankItem,
      this.canClaimRefund,
      this.dateRange,
      this.dateRecords,
      this.cancellationRefund,
      this.helpSubtopics});

  String? invoiceNumber;
  String? address;
  String? orderStatus;
  String? totalPrice;
  dynamic paymentUrl;
  String? deliverySlot;
  String? orderId;
  bool? canDownloadInvoice;
  String? orderValue;
  String? deliveryCharges;
  String? carryBagPrice;
  String? modeOfPayment;
  String? discountPromocodeAmount;
  dynamic wallet;
  String? pendingAmount;
  String? totalRefund;
  String? availableRefund;
  dynamic refundedAmount;
  bool? payNow;
  String? statusOfPayment;
  bool? canRepeatOrder;
  bool? canRaisedComplaint;
  String? deliveryDate;
  List<OrderItem>? orderItems;
  bool? canChangeDateTime;
  String? razorpayOrderId;
  List<Item>? totalRefundedItem;
  List<Item>? refundAvailableItem;
  List<Item>? refundToBankItem;
  bool? canClaimRefund;
  String? dateRange;
  List<DateRecord>? dateRecords;
  String? cancellationRefund;
  List<HelpSubtopic>? helpSubtopics;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        invoiceNumber:
            json["invoice_number"],
        address: json["address"],
        orderStatus: json["order_status"],
        totalPrice: json["total_price"],
        paymentUrl: json["payment_url"],
        deliverySlot:
            json["delivery_slot"],
        orderId: json["order_id"],
        canDownloadInvoice: json["can_download_invoice"],
        orderValue: json["order_value"],
        deliveryCharges:
            json["delivery_charges"],
        carryBagPrice:
            json["carry_bag_price"],
        modeOfPayment:
            json["mode_of_payment"],
        discountPromocodeAmount: json["discount_promocode_amount"],
        wallet: json["wallet"],
        pendingAmount:
            json["pending_amount"],
        totalRefund: json["total_refund"],
        availableRefund:
            json["available_refund"],
        refundedAmount: json["refunded_amount"],
        payNow: json["pay_now"],
        statusOfPayment: json["status_of_payment"],
        canRepeatOrder:
            json["can_repeat_order"],
        canRaisedComplaint: json["can_raised_complaint"],
        deliveryDate:
            json["delivery_date"],
        orderItems: json["order_items"] == null
            ? null
            : List<OrderItem>.from(
                json["order_items"].map((x) => OrderItem.fromJson(x))),
        canChangeDateTime: json["can_change_date_time"],
        razorpayOrderId: json["razorpay_order_id"],
        totalRefundedItem: json["total_refunded_item"] == null
            ? null
            : List<Item>.from(
                json["total_refunded_item"].map((x) => Item.fromJson(x))),
        refundAvailableItem: json["refund_available_item"] == null
            ? null
            : List<Item>.from(
                json["refund_available_item"].map((x) => Item.fromJson(x))),
        refundToBankItem: json["refund_to_bank_item"] == null
            ? null
            : List<Item>.from(
                json["refund_to_bank_item"].map((x) => Item.fromJson(x))),
        canClaimRefund:
            json["can_claim_refund"],
        dateRange: json["date_range"],
        cancellationRefund: json["cancellation_refund"],
        dateRecords: json["date_records"] == null
            ? null
            : List<DateRecord>.from(
                json["date_records"].map((x) => DateRecord.fromJson(x))),
        helpSubtopics: List<HelpSubtopic>.from(
            json["help_subtopics"].map((x) => HelpSubtopic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "address": address,
        "order_status": orderStatus,
        "total_price": totalPrice,
        "payment_url": paymentUrl,
        "delivery_slot": deliverySlot,
        "order_id": orderId,
        "can_download_invoice":
            canDownloadInvoice,
        "order_value": orderValue,
        "delivery_charges": deliveryCharges,
        "carry_bag_price": carryBagPrice,
        "mode_of_payment": modeOfPayment,
        "discount_promocode_amount":
            discountPromocodeAmount,
        "wallet": wallet,
        "pending_amount": pendingAmount,
        "total_refund": totalRefund,
        "available_refund": availableRefund,
        "refunded_amount": refundedAmount,
        "pay_now": payNow,
        "status_of_payment": statusOfPayment,
        "can_repeat_order": canRepeatOrder,
        "can_raised_complaint":
            canRaisedComplaint,
        "delivery_date": deliveryDate,
        "order_items": orderItems == null
            ? null
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "can_change_date_time":
            canChangeDateTime,
        "razorpay_order_id": razorpayOrderId,
        "total_refunded_item": totalRefundedItem == null
            ? null
            : List<Item>.from(totalRefundedItem!.map((x) => x.toJson())),
        "refund_available_item": refundAvailableItem == null
            ? null
            : List<Item>.from(refundAvailableItem!.map((x) => x.toJson())),
        "refund_to_bank_item": refundToBankItem == null
            ? null
            : List<Item>.from(refundToBankItem!.map((x) => x)),
        "can_claim_refund": canClaimRefund,
        "date_range": dateRange,
        "cancellation_refund":
            cancellationRefund,
        "date_records": dateRecords == null
            ? null
            : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
        "help_subtopics":
            List<dynamic>.from(helpSubtopics!.map((x) => x.toJson())),
      };
}

class DateRecord {
  DateRecord({
    this.checked,
    this.valid,
    this.day,
    this.date,
    this.value,
    this.percentage,
    this.time,
  });

  bool? checked;
  bool? valid;
  String? day;
  String? date;
  String? value;
  String? percentage;
  List<Time>? time;

  factory DateRecord.fromJson(Map<String, dynamic> json) => DateRecord(
        checked: json["checked"],
        valid: json["valid"],
        day: json["day"],
        date: json["date"],
        value: json["value"],
        percentage: json["percentage"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "checked": checked,
        "valid": valid,
        "day": day,
        "date": date,
        "value": value,
        "percentage": percentage,
        "time": time == null
            ? null
            : List<dynamic>.from(time!.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    this.text,
    this.id,
    this.disable,
    this.noPrefferedSlot,
    this.value,
  });

  String? text;
  int? id;
  bool? disable;
  bool? noPrefferedSlot;
  String? value;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        text: json["text"],
        id: json["id"],
        disable: json["disable"],
        noPrefferedSlot: json["no_preffered_slot"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "id": id,
        "disable": disable,
        "no_preffered_slot": noPrefferedSlot,
        "value": value,
      };
}

class OrderItem {
  OrderItem({
    this.name,
    this.items,
  });

  String? name;
  List<Item>? items;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item(
      {this.extra,
      this.productName,
      this.quantity,
      this.individualPrice,
      this.cartPrice,
      this.offerTitle,
      this.isDeleted,
      this.refundedQuantity,
      this.image,
      this.returnDueTo,
      this.package,
      this.brand});

  bool? extra;
  String? productName;
  int? quantity;
  String? individualPrice;
  String? cartPrice;
  String? offerTitle;
  bool? isDeleted;
  int? refundedQuantity;
  String? image;
  String? returnDueTo;
  String? package;
  String? brand;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        extra: json["extra"],
        productName: json["product_name"],
        quantity: json["quantity"],
        individualPrice:
            json["individual_price"],
        cartPrice: json["cart_price"],
        offerTitle: json["offer_title"],
        isDeleted: json["is_deleted"],
        refundedQuantity: json["refunded_quantity"],
        image: json["image"],
        returnDueTo: json["returnDueTo"],
        package: json["package"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "extra": extra,
        "product_name": productName,
        "quantity": quantity,
        "individual_price": individualPrice,
        "cart_price": cartPrice,
        "offer_title": offerTitle,
        "is_deleted": isDeleted,
        "refunded_quantity": refundedQuantity,
        "image": image,
        "return_due_to": returnDueTo,
        "package": package,
        "brand": brand,
      };
}

class HelpSubtopic {
  HelpSubtopic({
    this.uuid,
    this.subTopic,
    this.content,
    this.subSubTopics
  });

  String? uuid;
  String? subTopic;
  String? content;
  bool? subSubTopics;

  factory HelpSubtopic.fromJson(Map<String, dynamic> json) => HelpSubtopic(
        uuid: json["uuid"],
        subTopic: json["sub_topic"],
        content: json["content"],
        subSubTopics: json["sub_sub_topics"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "sub_topic": subTopic,
        "content": content,
        "sub_sub_topics": subSubTopics,
      };
}
