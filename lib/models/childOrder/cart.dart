// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:frugivore/models/utils.dart';


ChildCartModel childCartModelFromJson(String str) => ChildCartModel.fromJson(json.decode(str));

String childCartModelToJson(ChildCartModel data) => json.encode(data.toJson());

class ChildCartModel {
    Address? address;
    List<Datum>? data;
    dynamic order;
    bool? child;
    int? deliveryFee;
    int? subTotal;
    int? saved;
    int? total;
    String? message;
    int? count;
    bool? vendor;
    String? deliveryDate;
    String? deliverySlotTitle;
    int? deliverySlotId;

    ChildCartModel({
        this.address,
        this.data,
        this.order,
        this.child,
        this.deliveryFee,
        this.subTotal,
        this.saved,
        this.total,
        this.message,
        this.count,
        this.vendor,
        this.deliveryDate,
        this.deliverySlotTitle,
        this.deliverySlotId
    });

    factory ChildCartModel.fromJson(Map<String, dynamic> json) => ChildCartModel(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        order: json["order"],
        child: json["child"],
        deliveryFee: json["delivery_fee"],
        subTotal: json["sub_total"],
        saved: json["saved"],
        total: json["total"],
        message: json["message"],
        count: json["count"],
        vendor: json["vendor"],
        deliveryDate: json["delivery_date"],
        deliverySlotTitle: json["delivery_slot_title"],
        deliverySlotId: json["delivery_slot_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "order": order,
        "child": child,
        "delivery_fee": deliveryFee,
        "sub_total": subTotal,
        "saved": saved,
        "total": total,
        "message": message,
        "count": count,
        "vendor": vendor,
        "delivery_date": deliveryDate,
        "delivery_slot_title": deliverySlotTitle,
        "delivery_slot_id": deliverySlotId
    };
}

class Address {
    int? id;
    String? completeAddress;
    String? uuid;
    String? email;
    String? name;
    String? phone;
    String? alternatePhone;
    String? address;
    String? city;
    String? area;
    String? landmark;
    String? pinCode;
    String? addressType;
    dynamic lat;
    dynamic lng;
    bool? deliverHere;

    Address({
        this.id,
        this.completeAddress,
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

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        completeAddress: json["complete_address"],
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
        "complete_address": completeAddress,
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
    String? name;
    List<Item>? items;

    Datum({
        this.name,
        this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

