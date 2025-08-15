// To parse this JSON data, do
//
//     final editAddressDetailModel = editAddressDetailModelFromJson(jsonString);

import 'dart:convert';

EditAddressDetailModel editAddressDetailModelFromJson(String str) => EditAddressDetailModel.fromJson(json.decode(str));

String editAddressDetailModelToJson(EditAddressDetailModel data) => json.encode(data.toJson());

class EditAddressDetailModel {
    EditAddressDetailModel({
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
        this.isDefault,
        this.deliverHere,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    int? id;
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
    DateTime? createdAt;
    DateTime? updatedAt;
    int? user;

    factory EditAddressDetailModel.fromJson(Map<String, dynamic> json) => EditAddressDetailModel(
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
        isDefault: json["is_default"],
        deliverHere: json["deliver_here"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
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
        "is_default": isDefault,
        "deliver_here": deliverHere,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user,
    };
}
