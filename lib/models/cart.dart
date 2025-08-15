// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:frugivore/models/utils.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.address,
    this.data,
    this.deliveryFee,
    this.subTotal,
    this.saved,
    this.total,
    this.message,
    this.cashbackMessage,
    this.cashbackSubmessage,
    this.endorse,
    this.child,
    this.order,
    this.offers,
    this.discountapplied,
    this.count,
    this.vendor,
    this.recommended,
    this.crossSellingsProducts,
  });

  dynamic address;
  List<Datum>? data;
  int? deliveryFee;
  int? subTotal;
  int? saved;
  int? total;
  String? message;
  String? cashbackMessage;
  String? cashbackSubmessage;
  Endorse? endorse;
  bool? child;
  Order? order;
  List<String>? offers;
  List<GlobalProductModel>? recommended;
  List<GlobalProductModel>? crossSellingsProducts;
  String? discountapplied;
  int? count;
  bool? vendor;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        address: json["address"] != null
            ? Address.fromJson(json["address"])
            : json["address"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        deliveryFee: json["delivery_fee"],
        subTotal: json["sub_total"],
        saved: json["saved"],
        total: json["total"],
        message: json["message"],
        cashbackMessage: json["cashback_message"],
        cashbackSubmessage: json["cashback_submessage"],
        child: json["child"],
        endorse:
            json["endorse"] == null ? null : Endorse.fromJson(json["endorse"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        offers: json["offers"] == null
            ? null
            : List<String>.from(json["offers"].map((x) => x)),
        discountapplied:
            json["discountapplied"],
        count: json["count"],
        vendor: json["vendor"],
        recommended: List<GlobalProductModel>.from(
            json["recommended"].map((x) => GlobalProductModel.fromJson(x))),
        crossSellingsProducts: List<GlobalProductModel>.from(
            json["cross_sellings_products"]
                .map((x) => GlobalProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "delivery_fee": deliveryFee,
        "sub_total": subTotal,
        "saved": saved,
        "total": total,
        "message": message,
        "cashback_message": cashbackMessage,
        "cashback_submessage": cashbackSubmessage,
        "child": 'child',
        "endorse": endorse!.toJson(),
        "order": order?.toJson(),
        "offers":
            offers == null ? null : List<dynamic>.from(offers!.map((x) => x)),
        "discountapplied": discountapplied,
        "count": count,
        "vendor": vendor,
        "recommended": recommended == null
            ? null
            : List<GlobalProductModel>.from(recommended!.map((x) => x.toJson())),
        "cross_sellings_products": crossSellingsProducts == null
            ? null
            : List<GlobalProductModel>.from(
                crossSellingsProducts!.map((x) => x)),
      };
}

class Address {
  Address({
    this.id,
    this.uuid,
    this.email,
    this.name,
    this.phone,
    this.alternatePhone,
    this.address,
    this.city,
    this.area,
    this.landmark,
    this.pinCode,
    this.addressType,
    this.lat,
    this.lng,
    this.deliverHere,
  });

  int? id;
  String? uuid;
  String? email;
  String? name;
  String? phone;
  dynamic alternatePhone;
  String? address;
  String? city;
  String? area;
  dynamic landmark;
  String? pinCode;
  String? addressType;
  dynamic lat;
  dynamic lng;
  bool? deliverHere;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        uuid: json["uuid"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        address: json["address"],
        city: json["city"],
        area: json["area"],
        landmark: json["landmark"],
        pinCode: json["pin_code"],
        addressType: json["address_type"],
        lat: json["lat"],
        lng: json["lng"],
        deliverHere: json["deliver_here"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "email": email,
        "name": name,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "address": address,
        "city": city,
        "area": area,
        "landmark": landmark,
        "pin_code": pinCode,
        "address_type": addressType,
        "lat": lat,
        "lng": lng,
        "deliver_here": deliverHere,
      };
}

class Datum {
  Datum({
     this.name,
     this.items,
  });

  String? name;
  List<Item>? items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Endorse {
  Endorse({
    this.id,
    this.product,
    this.package,
    this.title,
    this.image,
    this.appliedOn,
    this.minAmount,
    this.maxAmount,
    this.priority,
    this.isActive,
  });

  int? id;
  Product? product;
  Package? package;
  String? title;
  String? image;
  String? appliedOn;
  dynamic minAmount;
  dynamic maxAmount;
  int? priority;
  bool? isActive;

  factory Endorse.fromJson(Map<String, dynamic> json) => Endorse(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        package: Package.fromJson(json["package"]),
        title: json["title"],
        image: json["image"],
        appliedOn: json["applied_on"],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
        priority: json["priority"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product!.toJson(),
        "package": package!.toJson(),
        "title": title,
        "image": image,
        "applied_on": appliedOn,
        "min_amount": minAmount,
        "max_amount": maxAmount,
        "priority": priority,
        "is_active": isActive,
      };
}

class Order {
  Order({
    this.invoiceNumber,
    this.deliverySlot,
    this.orderId,
    this.deliveryDate,
  });

  String? invoiceNumber;
  String? deliverySlot;
  String? orderId;
  String? deliveryDate;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        invoiceNumber:
            json["invoice_number"],
        deliverySlot:
            json["delivery_slot"],
        orderId: json["order_id"],
        deliveryDate:
            json["delivery_date"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "delivery_slot":  deliverySlot,
        "order_id":  orderId,
        "delivery_date":  deliveryDate,
      };
}


List<DeliveryInstructionModel> deliveryInstructionModelFromJson(String str) =>
    List<DeliveryInstructionModel>.from(
        json.decode(str).map((x) => DeliveryInstructionModel.fromJson(x)));

String deliveryInstructionModelToJson(List<DeliveryInstructionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryInstructionModel {
  DeliveryInstructionModel({
    this.id,
    this.title,
    this.icon,
    this.priority,
    this.isActive,
  });

  int? id;
  String? title;
  String? icon;
  int? priority;
  bool? isActive;

  factory DeliveryInstructionModel.fromJson(Map<String, dynamic> json) =>
      DeliveryInstructionModel(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        priority: json["priority"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "priority": priority,
        "is_active": isActive,
      };
}
