// To parse this JSON data, do
//
//     final childOrderReviewModel = childOrderReviewModelFromJson(jsonString);

import 'dart:convert';

ChildOrderReviewModel childOrderReviewModelFromJson(String str) => ChildOrderReviewModel.fromJson(json.decode(str));

String childOrderReviewModelToJson(ChildOrderReviewModel data) => json.encode(data.toJson());

class ChildOrderReviewModel {
    String? uuid;
    List<Bag>? bags;
    Address? address;
    List<DateRecord>? dateRecords;
    String? subTotal;
    String? deliveryFee;
    String? amountPayable;
    String? totalQuantity;
    String? discountSubTotal;

    ChildOrderReviewModel({
        this.uuid,
        this.bags,
        this.address,
        this.dateRecords,
        this.subTotal,
        this.deliveryFee,
        this.amountPayable,
        this.totalQuantity,
        this.discountSubTotal,
    });

    factory ChildOrderReviewModel.fromJson(Map<String, dynamic> json) => ChildOrderReviewModel(
        uuid: json["uuid"],
        bags: json["bags"] == null ? [] : List<Bag>.from(json["bags"]!.map((x) => Bag.fromJson(x))),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        dateRecords: json["date_records"] == null ? [] : List<DateRecord>.from(json["date_records"]!.map((x) => DateRecord.fromJson(x))),
        subTotal: json["sub_total"],
        deliveryFee: json["delivery_fee"],
        amountPayable: json["amount_payable"],
        totalQuantity: json["total_quantity"],
        discountSubTotal: json["discount_sub_total"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "bags": bags == null ? [] : List<dynamic>.from(bags!.map((x) => x.toJson())),
        "address": address?.toJson(),
        "date_records": dateRecords == null ? [] : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
        "sub_total": subTotal,
        "delivery_fee": deliveryFee,
        "amount_payable": amountPayable,
        "total_quantity": totalQuantity,
        "discount_sub_total": discountSubTotal,
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

class Bag {
    int? id;
    String? price;
    String? image;
    String? name;
    String? description;
    bool? bagDefault;

    Bag({
        this.id,
        this.price,
        this.image,
        this.name,
        this.description,
        this.bagDefault,
    });

    factory Bag.fromJson(Map<String, dynamic> json) => Bag(
        id: json["id"],
        price: json["price"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        bagDefault: json["default"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "image": image,
        "name": name,
        "description": description,
        "default": bagDefault,
    };
}

class DateRecord {
    bool? valid;
    bool? checked;
    String? day;
    String? date;
    String? value;
    String? percentage;
    List<Time>? time;

    DateRecord({
        this.valid,
        this.checked,
        this.day,
        this.date,
        this.value,
        this.percentage,
        this.time,
    });

    factory DateRecord.fromJson(Map<String, dynamic> json) => DateRecord(
        valid: json["valid"],
        checked: json["checked"],
        day: json["day"],
        date: json["date"],
        value: json["value"],
        percentage: json["percentage"],
        time: json["time"] == null ? [] : List<Time>.from(json["time"]!.map((x) => Time.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "valid": valid,
        "checked": checked,
        "day": day,
        "date": date,
        "value": value,
        "percentage": percentage,
        "time": time == null ? [] : List<dynamic>.from(time!.map((x) => x.toJson())),
    };
}

class Time {
    int? id;
    String? value;
    bool? disable;
    String? text;

    Time({
        this.id,
        this.value,
        this.disable,
        this.text,
    });

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




