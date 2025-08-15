// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';


TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
    TransactionHistoryModel({
        this.totalAmount,
        this.moneyAmount,
        this.creditAmount,
        this.walletHistory,
        this.expired,
        this.data1,
        this.data2,
        this.chart1Title,
        this.chart2Title,
    });

    String? totalAmount;
    String? moneyAmount;
    String? creditAmount;
    List<WalletHistory>? walletHistory;
    List<Expired>? expired;
    List<Data>? data1;
    List<Data>? data2;
    String? chart1Title;
    String? chart2Title;

    factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
        totalAmount: json["total_amount"],
        moneyAmount: json["money_amount"],
        creditAmount: json["credit_amount"],
        walletHistory: json["wallet_history"] == null ? null : List<WalletHistory>.from(json["wallet_history"].map((x) => WalletHistory.fromJson(x))),
        expired: json["expired"] == null ? null : List<Expired>.from(json["expired"].map((x) => Expired.fromJson(x))),
        data1: json["data1"] == null ? null : List<Data>.from(json["data1"].map((x) => Data.fromJson(x))),
        data2: json["data2"] == null ? null : List<Data>.from(json["data2"].map((x) => Data.fromJson(x))),
        chart1Title: json["chart_1_title"],
        chart2Title: json["chart_2_title"],
    );

    Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "money_amount": moneyAmount,
        "credit_amount": creditAmount,
        "wallet_history": walletHistory == null ? null : List<dynamic>.from(walletHistory!.map((x) => x.toJson())),
        "expired": expired == null ? null : List<dynamic>.from(expired!.map((x) => x.toJson())),
        "data1": data1 == null ? null : List<dynamic>.from(data1!.map((x) => x.toJson())),
        "data2": data2 == null ? null : List<dynamic>.from(data2!.map((x) => x.toJson())),
        "chart_1_title": chart1Title,
        "chart_2_title": chart2Title,
    };
}

class Data {
    Data({
        this.type,
        this.points,
        this.color,
        this.qsp
    });

    String? type;
    String? points;
    dynamic color;
    String? qsp;


    factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        points: json["points"],
        color: json["points"] == null ? null : json["color"],
        qsp: json["qsp"],


    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "points": points,
        "color": points == null ? null : color,
        "qsp": points == null ? null : qsp,
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

class WalletHistory {
    WalletHistory({
        this.invoiceNumber,
        this.transactionId,
        this.points,
        this.expireAt,
        this.typeOfPoints,
        this.typeOfMoney,
        this.createdAt,
    });

    String? invoiceNumber;
    String? transactionId;
    String? points;
    String? expireAt;
    String? typeOfPoints;
    String? typeOfMoney;
    String? createdAt;

    factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        invoiceNumber: json["invoice_number"],
        transactionId: json["transaction_id"],
        points: json["points"],
        expireAt: json["expire_at"],
        typeOfPoints: json["type_of_points"],
        typeOfMoney: json["type_of_money"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "transaction_id": transactionId,
        "points": points,
        "expire_at": expireAt,
        "type_of_points": typeOfPoints,
        "type_of_money": typeOfMoney,
        "created_at": createdAt,
    };
}
