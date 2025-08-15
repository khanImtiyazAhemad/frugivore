// To parse this JSON data, do
//
//     final preOrderReviewModel = preOrderReviewModelFromJson(jsonString);

import 'dart:convert';

PreOrderReviewModel preOrderReviewModelFromJson(String str) => PreOrderReviewModel.fromJson(json.decode(str));

String preOrderReviewModelToJson(PreOrderReviewModel data) => json.encode(data.toJson());

class PreOrderReviewModel {
    PreOrderReviewModel({
        this.bags,
        this.address,
        this.dateRecords,
        this.subTotal,
        this.deliveryFee,
        this.amountPayable,
        this.totalQuantity,
        this.discountSubTotal,
        this.discount,
        this.cashback,
    });

    List<Bag>? bags;
    List<Address>? address;
    List<DateRecord>? dateRecords;
    String? subTotal;
    String? deliveryFee;
    String? amountPayable;
    String? totalQuantity;
    String? discountSubTotal;
    String? discount;
    String? cashback;

    factory PreOrderReviewModel.fromJson(Map<String, dynamic> json) => PreOrderReviewModel(
        bags: json["bags"] == null ? null : List<Bag>.from(json["bags"].map((x) => Bag.fromJson(x))),
        address: json["address"] == null ? null : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        dateRecords: json["date_records"] == null ? null : List<DateRecord>.from(json["date_records"].map((x) => DateRecord.fromJson(x))),
        subTotal: json["sub_total"],
        deliveryFee: json["delivery_fee"],
        amountPayable: json["amount_payable"],
        totalQuantity: json["total_quantity"],
        discountSubTotal: json["discount_sub_total"],
        discount: json["discount"],
        cashback: json["cashback"],
    );

    Map<String, dynamic> toJson() => {
        "bags": bags == null ? null : List<dynamic>.from(bags!.map((x) => x.toJson())),
        "address": address == null ? null : List<dynamic>.from(address!.map((x) => x.toJson())),
        "date_records": dateRecords == null ? null : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
        "sub_total": subTotal,
        "delivery_fee": deliveryFee,
        "amount_payable": amountPayable,
        "total_quantity": totalQuantity,
        "discount_sub_total": discountSubTotal,
        "discount": discount,
        "cashback": cashback,
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

class Bag {
    Bag({
        this.id,
        this.price,
        this.name,
        this.image,
        this.description,
        this.bagDefault,
    });

    int? id;
    String? price;
    String? name;
    String? image;
    String? description;
    bool? bagDefault;

    factory Bag.fromJson(Map<String, dynamic> json) => Bag(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        bagDefault: json["default"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "image": image,
        "description": description,
        "default": bagDefault,
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
        time: json["time"] == null ? null : List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "checked": checked,
        "valid": valid,
        "day": day,
        "date": date,
        "value": value,
        "percentage": percentage,
        "time": time == null ? null : List<dynamic>.from(time!.map((x) => x.toJson())),
    };
}

class Time {
    Time({
        this.id,
        this.value,
        this.disable,
        this.text,
    });

    int? id;
    String? value;
    bool? disable;
    String? text;

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        value: json["value"],
        disable: json["disable"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "disable": disable,
        "text": text,
    };
}

