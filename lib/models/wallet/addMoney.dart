// To parse this JSON data, do
//
//     final addMoneyModel = addMoneyModelFromJson(jsonString);

import 'dart:convert';

AddMoneyModel addMoneyModelFromJson(String str) => AddMoneyModel.fromJson(json.decode(str));

String addMoneyModelToJson(AddMoneyModel data) => json.encode(data.toJson());

class AddMoneyModel {
    AddMoneyModel({
        this.totalAmount,
    });

    String? totalAmount;

    factory AddMoneyModel.fromJson(Map<String, dynamic> json) => AddMoneyModel(
        totalAmount: json["total_amount"],
    );

    Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
    };
}


List<WalletOffersModel> walletOffersModelFromJson(String str) => List<WalletOffersModel>.from(json.decode(str).map((x) => WalletOffersModel.fromJson(x)));

String walletOffersModelToJson(List<WalletOffersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletOffersModel {
    int? id;
    String? uuid;
    String? banner;
    String? code;
    String? description;
    int? amount;
    int? benefit;
    int? additionalBenefit;
    bool recommended;
    int? priority;
    bool? isActive;

    WalletOffersModel({
        this.id,
        this.uuid,
        this.banner,
        this.code,
        this.description,
        this.amount,
        this.benefit,
        this.additionalBenefit,
        required this.recommended,
        this.priority,
        this.isActive,
    });

    factory WalletOffersModel.fromJson(Map<String, dynamic> json) => WalletOffersModel(
        id: json["id"],
        uuid: json["uuid"],
        banner: json["banner"],
        code: json["code"],
        description: json["description"],
        amount: json["amount"],
        benefit: json["benefit"],
        additionalBenefit: json["additional_benefit"],
        recommended: json["recommended"],
        priority: json["priority"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "banner": banner,
        "code": code,
        "description": description,
        "amount": amount,
        "benefit": benefit,
        "additional_benefit": additionalBenefit,
        "recommended": recommended,
        "priority": priority,
        "is_active": isActive,
    };
}
