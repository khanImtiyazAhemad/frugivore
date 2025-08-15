// To parse this JSON data, do
//
//     final mySubscriptionModel = mySubscriptionModelFromJson(jsonString);

import 'dart:convert';

MySubscriptionModel mySubscriptionModelFromJson(String str) => MySubscriptionModel.fromJson(json.decode(str));

String mySubscriptionModelToJson(MySubscriptionModel data) => json.encode(data.toJson());

class MySubscriptionModel {
    MySubscriptionModel({
        this.page,
        this.maxPage,
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? page;
    int? maxPage;
    int? count;
    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory MySubscriptionModel.fromJson(Map<String, dynamic> json) => MySubscriptionModel(
        page: json["page"],
        maxPage: json["max_page"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.uuid,
        this.shoppinglistUuid,
        this.shoppinglistName,
        this.totalItems,
        this.isActive,
        this.startsOn,
        this.occurance,
        this.message,
        this.endsOn,
        this.createdAt,
        this.updatedAt,
        this.deliveryAddress,
    });

    String? uuid;
    String? shoppinglistUuid;
    String? shoppinglistName;
    int? totalItems;
    bool? isActive;
    String? startsOn;
    String? occurance;
    String? message;
    String? endsOn;
    String? createdAt;
    String? updatedAt;
    int? deliveryAddress;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uuid: json["uuid"],
        shoppinglistUuid: json["shoppinglist_uuid"],
        shoppinglistName: json["shoppinglist_name"],
        totalItems: json["total_items"],
        isActive: json["is_active"],
        startsOn: json["starts_on"],
        occurance: json["occurance"],
        message: json["message"],
        endsOn: json["ends_on"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deliveryAddress: json["delivery_address"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "shoppinglist_uuid": shoppinglistUuid,
        "shoppinglist_name": shoppinglistName,
        "total_items": totalItems,
        "is_active": isActive,
        "starts_on": startsOn,
        "occurance": occurance,
        "message": message,
        "ends_on": endsOn,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "delivery_address": deliveryAddress,
    };
}
