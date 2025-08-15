// To parse this JSON data, do
//
//     final preOrderCartModel = preOrderCartModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';


PreOrderCartModel preOrderCartModelFromJson(String str) => PreOrderCartModel.fromJson(json.decode(str));

String preOrderCartModelToJson(PreOrderCartModel data) => json.encode(data.toJson());

class PreOrderCartModel {
    PreOrderCartModel({
        this.address,
        this.data,
        this.deliveryFee,
        this.subTotal,
        this.saved,
        this.total,
        this.message,
    });

    Address? address;
    List<Datum>? data;
    int? deliveryFee;
    int? subTotal;
    int? saved;
    int? total;
    String? message;

    factory PreOrderCartModel.fromJson(Map<String, dynamic> json) => PreOrderCartModel(
        address: Address.fromJson(json["address"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) ,
        deliveryFee: json["delivery_fee"],
        subTotal: json["sub_total"],
        saved: json["saved"],
        total: json["total"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "delivery_fee": deliveryFee,
        "sub_total": subTotal,
        "saved": saved,
        "total": total,
        "message": message,
    };
}

class Address {
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
        this.isDefault,
        this.deliverHere,
    });

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
    bool? isDefault;
    bool? deliverHere;

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
        isDefault: json["is_default"],
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
        "is_default": isDefault,
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
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

