// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    PaymentModel({
        this.name,
        this.email,
        this.phone,
        this.cod,
        this.discount,
        this.cashback,
        this.discountAmount,
        this.cashbackAmount,
        this.subTotal,
        this.cashbackcode,
        this.discountcode,
        this.razorpaymoney,
        this.amountPayable,
        this.remainingTime,
        this.paymentWalletCalculation,
        this.deliveryAddress,
        this.deliveryDate
    });

    String? name;
    String? email;
    String? phone;
    bool? cod;
    Cashback? discount;
    Cashback? cashback;
    String? discountAmount;
    String? cashbackAmount;
    String? subTotal;
    List<Cashback>? cashbackcode;
    List<Cashback>? discountcode;
    String? razorpaymoney;
    String? amountPayable;
    int? remainingTime;
    String? paymentWalletCalculation;
    String? deliveryAddress;
    String? deliveryDate;

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        cod: json["cod"],
        discount: json["discount"] == null ? null : Cashback.fromJson(json["discount"]),
        cashback: json["cashback"] == null ? null : Cashback.fromJson(json["cashback"]),
        discountAmount: json["discount_amount"],
        cashbackAmount: json["cashback_amount"],
        subTotal: json["sub_total"],
        cashbackcode: json["cashbackcode"] == null ? null : List<Cashback>.from(json["cashbackcode"].map((x) => Cashback.fromJson(x))),
        discountcode: json["discountcode"] == null ? null : List<Cashback>.from(json["discountcode"].map((x) => Cashback.fromJson(x))),
        razorpaymoney: json["razorpaymoney"],
        amountPayable: json["amount_payable"],
        remainingTime: json["remaining_time"],
        paymentWalletCalculation: json["payment_wallet_calculation"],
        deliveryAddress: json["delivery_address"],
        deliveryDate: json["delivery_date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "cod": cod,
        "discount": discount?.toJson(),
        "cashback": cashback?.toJson(),
        "discount_amount": discountAmount,
        "cashback_amount": cashbackAmount,
        "sub_total": subTotal,
        "cashbackcode": cashbackcode == null ? null : List<dynamic>.from(cashbackcode!.map((x) => x.toJson())),
        "discountcode": discountcode == null ? null : List<dynamic>.from(discountcode!.map((x) => x.toJson())),
        "razorpaymoney": razorpaymoney,
        "amount_payable": amountPayable,
        "remaining_time": remainingTime,
        "payment_wallet_calculation": paymentWalletCalculation,
        "delivery_address": deliveryAddress,
        "delivery_date": deliveryDate,
    };
}

class Cashback {
    Cashback({
        this.id,
        this.code,
        this.banner,
        this.description,
        this.termsAndCondition,
    });

    int? id;
    String? code;
    String? banner;
    String? description;
    String? termsAndCondition;

    factory Cashback.fromJson(Map<String, dynamic> json) => Cashback(
        id: json["id"],
        code: json["code"],
        banner: json["banner"],
        description: json["description"],
        termsAndCondition: json["terms_and_condition"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "banner": banner,
        "description": description,
        "terms_and_condition": termsAndCondition,
    };
}
