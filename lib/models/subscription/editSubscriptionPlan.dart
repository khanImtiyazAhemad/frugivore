// To parse this JSON data, do
//
//     final editSubscriptionPlanModel = editSubscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

EditSubscriptionPlanModel editSubscriptionPlanModelFromJson(String str) => EditSubscriptionPlanModel.fromJson(json.decode(str));

String editSubscriptionPlanModelToJson(EditSubscriptionPlanModel data) => json.encode(data.toJson());

class EditSubscriptionPlanModel {
    EditSubscriptionPlanModel({
        this.weeks,
        this.slots,
        this.subscription,
        this.day,
        this.moneyBalance,
        this.dateString,
        this.minimumWalletRequirement,
        this.error,
    });

    List<String>? weeks;
    List<Slot>? slots;
    Subscription? subscription;
    String? day;
    String? moneyBalance;
    String? dateString;
    String? minimumWalletRequirement;
    String? error;


    factory EditSubscriptionPlanModel.fromJson(Map<String, dynamic> json) => EditSubscriptionPlanModel(
        weeks: json["weeks"] == null ? null : List<String>.from(json["weeks"].map((x) => x)),
        slots: json["slots"] == null ? null : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
        day: json["day"],
        moneyBalance: json["money_balance"],
        dateString: json["date_string"],
        minimumWalletRequirement: json["minimum_wallet_requirement"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "weeks": weeks == null ? null : List<dynamic>.from(weeks!.map((x) => x)),
        "slots": slots == null ? null : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "subscription": subscription?.toJson(),
        "day": day,
        "money_balance": moneyBalance,
        "date_string": dateString,
        "minimum_wallet_requirement": minimumWalletRequirement,
        "error": error,
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

class Subscription {
    Subscription({
        this.uuid,
        this.shoppinglistName,
        this.totalItems,
        this.isActive,
        this.deliveryAddress,
        this.startsOn,
        this.occurance,
        this.endsOn,
        this.repeatsCount,
        this.repeatsEvery,
        this.weeklyRepeatsOn,
        this.monthlyRepeatsOn,
        this.endsOnDate,
        this.endsOnCount,
        this.deliverySlotId,
        this.completeAddress,
    });

    String? uuid;
    String? shoppinglistName;
    int? totalItems;
    bool? isActive;
    dynamic deliveryAddress;
    DateTime? startsOn;
    String? occurance;
    String? endsOn;
    int? repeatsCount;
    String? repeatsEvery;
    List<String>? weeklyRepeatsOn;
    List<dynamic>? monthlyRepeatsOn;
    DateTime? endsOnDate;
    int? endsOnCount;
    int? deliverySlotId;
    String? completeAddress;

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        uuid: json["uuid"],
        shoppinglistName: json["shoppinglist_name"],
        totalItems: json["total_items"],
        isActive: json["is_active"],
        deliveryAddress: json["delivery_address"],
        startsOn: json["starts_on"] == null ? null : DateTime.parse(json["starts_on"]),
        occurance: json["occurance"],
        endsOn: json["ends_on"],
        repeatsCount: json["repeats_count"],
        repeatsEvery: json["repeats_every"],
        weeklyRepeatsOn: json["weekly_repeats_on"] == null ? null : List<String>.from(json["weekly_repeats_on"].map((x) => x)),
        monthlyRepeatsOn: json["monthly_repeats_on"] == null ? null : List<dynamic>.from(json["monthly_repeats_on"].map((x) => x)),
        endsOnDate: json["ends_on_date"] == null ? null : DateTime.parse(json["ends_on_date"]),
        endsOnCount: json["ends_on_count"],
        deliverySlotId: json["delivery_slot_id"],
        completeAddress: json["complete_address"],

    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "shoppinglist_name": shoppinglistName,
        "total_items": totalItems,
        "is_active": isActive,
        "delivery_address": deliveryAddress,
        "starts_on": startsOn == null ? null : "${startsOn!.year.toString().padLeft(4, '0')}-${startsOn!.month.toString().padLeft(2, '0')}-${startsOn!.day.toString().padLeft(2, '0')}",
        "occurance": occurance,
        "ends_on": endsOn,
        "repeats_count": repeatsCount,
        "repeats_every": repeatsEvery,
        "weekly_repeats_on": weeklyRepeatsOn == null ? null : List<dynamic>.from(weeklyRepeatsOn!.map((x) => x)),
        "monthly_repeats_on": monthlyRepeatsOn == null ? null : List<dynamic>.from(monthlyRepeatsOn!.map((x) => x)),
        "ends_on_date": endsOnDate == null ? null : "${endsOnDate!.year.toString().padLeft(4, '0')}-${endsOnDate!.month.toString().padLeft(2, '0')}-${endsOnDate!.day.toString().padLeft(2, '0')}",
        "ends_on_count": endsOnCount,
        "delivery_slot_id": deliverySlotId,
        "complete_address": completeAddress,

    };
}
