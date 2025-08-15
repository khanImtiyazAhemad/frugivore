// To parse this JSON data, do
//
//     final orderReviewModel = orderReviewModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

OrderReviewModel orderReviewModelFromJson(String str) =>
    OrderReviewModel.fromJson(json.decode(str));

String orderReviewModelToJson(OrderReviewModel data) =>
    json.encode(data.toJson());

class OrderReviewModel {
  OrderReviewModel({
    this.bags,
    this.address,
    this.discount,
    this.cashback,
    this.subTotal,
    this.deliveryFee,
    this.amountPayable,
    this.totalQuantity,
    this.discountSubTotal,
    this.multipleOrder,
    this.option1,
    this.option2,
    this.option3,
    this.sameDay,
    this.dateRecords,
  });

  List<Bag>? bags;
  List<Address>? address;
  Discount? discount;
  dynamic cashback;
  String? subTotal;
  String? deliveryFee;
  String? amountPayable;
  String? totalQuantity;
  String? discountSubTotal;
  bool? multipleOrder;
  Option1? option1;
  Option? option2;
  Option? option3;
  bool? sameDay;
  List<DateRecord>? dateRecords;

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) =>
      OrderReviewModel(
        bags: json["bags"] == null
            ? null
            : List<Bag>.from(json["bags"].map((x) => Bag.fromJson(x))),
        address: json["address"] == null
            ? null
            : List<Address>.from(
                json["address"].map((x) => Address.fromJson(x))),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        cashback: json["cashback"],
        subTotal: json["sub_total"],
        deliveryFee: json["delivery_fee"],
        amountPayable:
            json["amount_payable"],
        totalQuantity:
            json["total_quantity"],
        discountSubTotal: json["discount_sub_total"],
        multipleOrder:
            json["multiple_order"],
        option1: json["option_1"] == null
            ? null
            : Option1.fromJson(json["option_1"]),
        option2:
            json["option_2"] == null ? null : Option.fromJson(json["option_2"]),
        option3:
            json["option_3"] == null ? null : Option.fromJson(json["option_3"]),
        sameDay: json["same_day"],
        dateRecords: json["date_records"] == null
            ? null
            : List<DateRecord>.from(
                json["date_records"].map((x) => DateRecord.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bags": bags == null
            ? null
            : List<dynamic>.from(bags!.map((x) => x.toJson())),
        "address": address == null
            ? null
            : List<dynamic>.from(address!.map((x) => x.toJson())),
        "discount": discount?.toJson(),
        "cashback": cashback,
        "sub_total": subTotal,
        "delivery_fee": deliveryFee,
        "amount_payable": amountPayable,
        "total_quantity": totalQuantity,
        "discount_sub_total":
            discountSubTotal,
        "multiple_order": multipleOrder,
        "option_1": option1?.toJson(),
        "option_2": option2?.toJson(),
        "option_3": option3?.toJson(),
        "same_day": sameDay,
        "date_records": dateRecords == null
            ? null
            : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
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
        completeAddress:
            json["complete_address"],
        uuid: json["uuid"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        alternatePhone:
            json["alternate_phone"],
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
  DateRecord(
      {this.checked,
      this.valid,
      this.day,
      this.date,
      this.value,
      this.percentage,
      this.time,
      this.orderType});

  bool? checked;
  bool? valid;
  String? day;
  String? date;
  String? value;
  String? percentage;
  String? orderType;
  List<Time>? time;

  factory DateRecord.fromJson(Map<String, dynamic> json) => DateRecord(
        orderType: json["order_type"],
        checked: json["checked"],
        valid: json["valid"],
        day: json["day"],
        date: json["date"],
        value: json["value"],
        percentage: json["percentage"],
        time: json["time"] == null
            ? null
            : List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_type": orderType,
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

class Discount {
  Discount({
    this.id,
    this.code,
    this.productId,
    this.packageId,
    this.brand,
    this.appliedOn,
    this.promocode,
    this.total,
  });

  int? id;
  String? code;
  dynamic productId;
  dynamic packageId;
  dynamic brand;
  String? appliedOn;
  int? promocode;
  int? total;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        code: json["code"],
        productId: json["product_id"],
        packageId: json["package_id"],
        brand: json["brand"],
        appliedOn: json["applied_on"],
        promocode: json["promocode"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "product_id": productId,
        "package_id": packageId,
        "brand": brand,
        "applied_on": appliedOn,
        "promocode": promocode,
        "total": total,
      };
}

class Option1 {
  Option1({
    this.active,
    this.id,
    this.title,
    this.subtitle,
    this.deliveryFee,
    this.items,
    this.cart,
    this.deliverySlot,
    this.orderType,
    this.popupTitle,
  });

  bool? active;
  String? id;
  String? title;
  String? subtitle;
  String? deliveryFee;
  List<Item>? items;
  List<int>? cart;
  List<DateRecord>? deliverySlot;
  String? orderType;
  String? popupTitle;

  factory Option1.fromJson(Map<String, dynamic> json) => Option1(
        active: json["active"],
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        deliveryFee: json["delivery_fee"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        cart: json["cart"] == null
            ? null
            : List<int>.from(json["cart"].map((x) => x)),
        deliverySlot: json["delivery_slot"] == null
            ? null
            : List<DateRecord>.from(
                json["delivery_slot"].map((x) => DateRecord.fromJson(x))),
        orderType: json["order_type"],
        popupTitle: json["popup_title"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "delivery_fee": deliveryFee,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "cart": cart == null ? null : List<dynamic>.from(cart!.map((x) => x)),
        "delivery_slot": deliverySlot == null
            ? null
            : List<dynamic>.from(deliverySlot!.map((x) => x.toJson())),
        "order_type": orderType,
        "popup_title": popupTitle,
      };
}

class Item {
  Item({
    this.id,
    this.product,
    this.package,
    this.freeDescription,
    this.quantity,
    this.actualPrice,
    this.discountedPrice,
    this.taxPrice,
    this.cartPrice,
    this.extra,
    this.offer,
  });

  int? id;
  Product? product;
  Package? package;
  String? freeDescription;
  int? quantity;
  dynamic actualPrice;
  String? discountedPrice;
  dynamic taxPrice;
  String? cartPrice;
  bool? extra;
  int? offer;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
        freeDescription:
            json["free_description"],
        quantity: json["quantity"],
        actualPrice: json["actual_price"],
        discountedPrice:
            json["discounted_price"],
        taxPrice: json["tax_price"],
        cartPrice: json["cart_price"],
        extra: json["extra"],
        offer: json["offer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "package": package?.toJson(),
        "free_description": freeDescription,
        "quantity": quantity,
        "actual_price": actualPrice,
        "discounted_price": discountedPrice,
        "tax_price": taxPrice,
        "cart_price": cartPrice,
        "extra": extra,
        "offer": offer,
      };
}

class Option {
  Option({
    this.active,
    this.id,
    this.title,
    this.subtitle,
    this.deliveryFee,
    this.shipment1,
    this.shipment2,
    this.shipment3,
  });

  bool? active;
  String? id;
  String? title;
  String? subtitle;
  String? deliveryFee;
  Shipment? shipment1;
  Option1? shipment2;
  dynamic shipment3;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        active: json["active"],
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        deliveryFee: json["delivery_fee"],
        shipment1: json["shipment_1"] == null
            ? null
            : Shipment.fromJson(json["shipment_1"]),
        shipment2: json["shipment_2"] == null
            ? null
            : Option1.fromJson(json["shipment_2"]),
        shipment3: json["shipment_3"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "delivery_fee": deliveryFee,
        "shipment_1": shipment1?.toJson(),
        "shipment_2": shipment2?.toJson(),
        "shipment_3": shipment3,
      };
}

class Shipment {
  Shipment({
    this.id,
    this.title,
    this.deliveryFee,
    this.items,
    this.cart,
    this.deliverySlot,
    this.orderType,
    this.popupTitle,
  });

  String? id;
  String? title;
  String? deliveryFee;
  List<Item>? items;
  List<int>? cart;
  List<DateRecord>? deliverySlot;
  String? orderType;
  String? popupTitle;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        title: json["title"],
        deliveryFee: json["delivery_fee"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        cart: json["cart"] == null
            ? null
            : List<int>.from(json["cart"].map((x) => x)),
        deliverySlot: json["delivery_slot"] == null
            ? null
            : List<DateRecord>.from(
                json["delivery_slot"].map((x) => DateRecord.fromJson(x))),
        orderType: json["order_type"],
        popupTitle: json["popup_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "delivery_fee": deliveryFee,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "cart": cart == null ? null : List<dynamic>.from(cart!.map((x) => x)),
        "delivery_slot": deliverySlot == null
            ? null
            : List<dynamic>.from(deliverySlot!.map((x) => x.toJson())),
        "order_type": orderType,
        "popup_title": popupTitle,
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
