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
    this.usedWallet,
    this.multipleOrder,
    this.option1,
    this.option2,
    this.option3,
    this.sameDay,
    this.dateRecords,
    this.deliveryDate,
    this.deliverySlot,
    this.orderType,
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
  int? usedWallet;
  bool? multipleOrder;
  Option1? option1;
  Option? option2;
  Option? option3;
  bool? sameDay;
  List<DateRecord>? dateRecords;
  String? deliveryDate;
  CartModelDeliverySlot? deliverySlot;
  String? orderType;

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
    endorse: json["endorse"] == null ? null : Endorse.fromJson(json["endorse"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    offers: json["offers"] == null
        ? null
        : List<String>.from(json["offers"].map((x) => x)),
    discountapplied: json["discountapplied"],
    count: json["count"],
    vendor: json["vendor"],
    recommended: List<GlobalProductModel>.from(
      json["recommended"].map((x) => GlobalProductModel.fromJson(x)),
    ),
    crossSellingsProducts: List<GlobalProductModel>.from(
      json["cross_sellings_products"].map(
        (x) => GlobalProductModel.fromJson(x),
      ),
    ),
    usedWallet: json["used_wallet"],
    multipleOrder: json["multiple_order"],
    option1: json["option_1"] == null
        ? null
        : Option1.fromJson(json["option_1"]),
    option2: json["option_2"] == null
        ? null
        : Option.fromJson(json["option_2"]),
    option3: json["option_3"] == null
        ? null
        : Option.fromJson(json["option_3"]),
    sameDay: json["same_day"],
    dateRecords: json["date_records"] == null
        ? null
        : List<DateRecord>.from(
            json["date_records"].map((x) => DateRecord.fromJson(x)),
          ),
    deliveryDate: json["delivery_date"] == null
        ? null
        :  json['delivery_date'],
    deliverySlot: json["delivery_slot"] == null
        ? null
        :  CartModelDeliverySlot.fromJson(json["delivery_slot"]),
    orderType: json["order_type"] == null
        ? null
        :  json['order_type']
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
    "endorse": endorse?.toJson(),
    "order": order?.toJson(),
    "offers": offers == null ? null : List<dynamic>.from(offers!.map((x) => x)),
    "discountapplied": discountapplied,
    "count": count,
    "vendor": vendor,
    "recommended": recommended == null
        ? null
        : List<GlobalProductModel>.from(recommended!.map((x) => x.toJson())),
    "cross_sellings_products": crossSellingsProducts == null
        ? null
        : List<GlobalProductModel>.from(crossSellingsProducts!.map((x) => x)),
    "used_wallet": usedWallet,
    "multiple_order": multipleOrder,
    "option_1": option1?.toJson(),
    "option_2": option2?.toJson(),
    "option_3": option3?.toJson(),
    "same_day": sameDay,
    "date_records": dateRecords == null
        ? null
        : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
    "delivery_date": deliveryDate,
    "delivery_slot": deliverySlot?.toJson(),
    "order_type": orderType
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
  Datum({this.name, this.items});

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
    invoiceNumber: json["invoice_number"],
    deliverySlot: json["delivery_slot"],
    orderId: json["order_id"],
    deliveryDate: json["delivery_date"],
  );

  Map<String, dynamic> toJson() => {
    "invoice_number": invoiceNumber,
    "delivery_slot": deliverySlot,
    "order_id": orderId,
    "delivery_date": deliveryDate,
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
    this.orderType,
  });

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
  Time({this.text, this.id, this.disable, this.noPrefferedSlot, this.value});

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
            json["delivery_slot"].map((x) => DateRecord.fromJson(x)),
          ),
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
            json["delivery_slot"].map((x) => DateRecord.fromJson(x)),
          ),
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
  Shipment? shipment2;
  Shipment? shipment3;

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
        : Shipment.fromJson(json["shipment_2"]),
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

class CartModelDeliverySlot {
  final int? id;
  final String? title;

  CartModelDeliverySlot({this.id, this.title});
  factory CartModelDeliverySlot.fromJson(Map<String, dynamic> json) =>
      CartModelDeliverySlot(id: json["id"], title: json["title"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title};
}


List<DeliveryInstructionModel> deliveryInstructionModelFromJson(String str) =>
    List<DeliveryInstructionModel>.from(
      json.decode(str).map((x) => DeliveryInstructionModel.fromJson(x)),
    );

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

