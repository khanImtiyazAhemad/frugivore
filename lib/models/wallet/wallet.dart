// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) => WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
    WalletModel({
        this.total,
        this.money,
        this.credit,
        this.expired,
    });

    String? total;
    String? money;
    String? credit;
    List<Expired>? expired;

    factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        total: json["total"],
        money: json["money"],
        credit: json["credit"],
        expired: List<Expired>.from(json["expired"].map((x) => Expired.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "money": money,
        "credit": credit,
        "expired": List<dynamic>.from(expired!.map((x) => x.toJson())),
    };
}

class Expired {
    Expired({
        this.date,
        this.points,
    });

    String? date;
    String? points;

    factory Expired.fromJson(Map<String, dynamic> json) => Expired(
        date: json["date"],
        points: json["points"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "points": points,
    };
}
