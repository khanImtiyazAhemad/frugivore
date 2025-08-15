// To parse this JSON data, do
//
//     final subscriptionDetailModel = subscriptionDetailModelFromJson(jsonString);

import 'dart:convert';

SubscriptionDetailModel subscriptionDetailModelFromJson(String str) => SubscriptionDetailModel.fromJson(json.decode(str));

String subscriptionDetailModelToJson(SubscriptionDetailModel data) => json.encode(data.toJson());

class SubscriptionDetailModel {
    SubscriptionDetailModel({
        this.uuid,
        this.upcomingOccurance,
        this.previousOccurance,
    });

    String? uuid;
    List<UpcomingOccurance>? upcomingOccurance;
    List<PreviousOccurance>? previousOccurance;

    factory SubscriptionDetailModel.fromJson(Map<String, dynamic> json) => SubscriptionDetailModel(
        uuid: json["uuid"],
        upcomingOccurance: json["upcoming_occurance"] == null ? null : List<UpcomingOccurance>.from(json["upcoming_occurance"].map((x) => UpcomingOccurance.fromJson(x))),
        previousOccurance: json["previous_occurance"] == null ? null : List<PreviousOccurance>.from(json["previous_occurance"].map((x) => PreviousOccurance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "upcoming_occurance": upcomingOccurance == null ? null : List<dynamic>.from(upcomingOccurance!.map((x) => x.toJson())),
        "previous_occurance": previousOccurance == null ? null : List<dynamic>.from(previousOccurance!.map((x) => x.toJson())),
    };
}

class PreviousOccurance {
    PreviousOccurance({
        this.date,
        this.process,
        this.placed,
        this.order,
    });

    String? date;
    String? process;
    bool? placed;
    Order? order;

    factory PreviousOccurance.fromJson(Map<String, dynamic> json) => PreviousOccurance(
        date: json["date"],
        process: json["process"],
        placed: json["placed"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "process": process,
        "placed": placed,
        "order": order?.toJson(),
    };
}

class Order {
    Order({
        this.id,
        this.invoiceNumber,
        this.orderId,
        this.orderValue,
        this.deliveryCharges,
        this.wallet,
        this.pendingAmount,
        this.currentMoneyBalance,
    });

    int? id;
    String? invoiceNumber;
    String? orderId;
    String? orderValue;
    String? deliveryCharges;
    String? wallet;
    String? pendingAmount;
    String? currentMoneyBalance;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        orderId: json["order_id"],
        orderValue: json["order_value"],
        deliveryCharges: json["delivery_charges"],
        wallet: json["wallet"],
        pendingAmount: json["pending_amount"],
        currentMoneyBalance: json["current_money_balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "order_id": orderId,
        "order_value": orderValue,
        "delivery_charges": deliveryCharges,
        "wallet": wallet,
        "pending_amount": pendingAmount,
        "current_money_balance": currentMoneyBalance,
    };
}

class UpcomingOccurance {
    UpcomingOccurance({
        this.skip,
        this.skipMessage,
        this.skipDateStatus,
        this.skipDate,
        this.date,
        this.process,
    });

    bool? skip;
    String? skipMessage;
    bool? skipDateStatus;
    String? skipDate;
    String? date;
    String? process;

    factory UpcomingOccurance.fromJson(Map<String, dynamic> json) => UpcomingOccurance(
        skip: json["skip"],
        skipMessage: json["skip_message"],
        skipDateStatus: json["skip_date_status"],
        skipDate: json["skip_date"],
        date: json["date"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "skip": skip,
        "skip_message": skipMessage,
        "skip_date_status": skipDateStatus,
        "skip_date": skipDate,
        "date": date,
        "process": process,
    };
}
