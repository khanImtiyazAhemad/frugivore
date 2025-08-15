// To parse this JSON data, do
//
//     final createSubscriptionPlanModel = createSubscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

CreateSubscriptionPlanModel createSubscriptionPlanModelFromJson(String str) => CreateSubscriptionPlanModel.fromJson(json.decode(str));

String createSubscriptionPlanModelToJson(CreateSubscriptionPlanModel data) => json.encode(data.toJson());

class CreateSubscriptionPlanModel {
    CreateSubscriptionPlanModel({
        this.uuid,
        this.weeks,
        this.date,
        this.slots,
        this.moneyBalance,
        this.day,
        this.deliveryAddress,
        this.currentDate,
        this.minimumWalletRequirement,
        this.dateString,
        this.information,
    });

    String? uuid;
    List<String>? weeks;
    int? date;
    List<Slot>? slots;
    String? moneyBalance;
    String? day;
    DeliveryAddress? deliveryAddress;
    DateTime? currentDate;
    String? minimumWalletRequirement;
    String? dateString;
    String? information;

    factory CreateSubscriptionPlanModel.fromJson(Map<String, dynamic> json) => CreateSubscriptionPlanModel(
        uuid: json["uuid"],
        weeks: json["weeks"] == null ? null : List<String>.from(json["weeks"].map((x) => x)),
        date: json["date"],
        slots: json["slots"] == null ? null : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        moneyBalance: json["money_balance"],
        day: json["day"],
        deliveryAddress: json["delivery_address"] == null ? null : DeliveryAddress.fromJson(json["delivery_address"]),
        currentDate: DateTime.parse(json["current_date"]) ,
        minimumWalletRequirement: json["minimum_wallet_requirement"],
        dateString: json["date_string"],
        information: json["information"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "weeks": weeks == null ? null : List<dynamic>.from(weeks!.map((x) => x)),
        "date": date,
        "slots": slots == null ? null : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "money_balance": moneyBalance,
        "day": day,
        "delivery_address": deliveryAddress?.toJson(),
        "current_date": currentDate == null ? null : "${currentDate!.year.toString().padLeft(4, '0')}-${currentDate!.month.toString().padLeft(2, '0')}-${currentDate!.day.toString().padLeft(2, '0')}",
        "minimum_wallet_requirement": minimumWalletRequirement,
        "date_string": dateString,
        "information": information,
    };
}

class DeliveryAddress {
    DeliveryAddress({
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

    factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
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

class Slot {
    Slot({
        this.id,
        this.title,
    });

    int? id;
    String? title;

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
