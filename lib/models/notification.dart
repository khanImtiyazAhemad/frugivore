// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    NotificationModel({
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

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
        this.id,
        this.createdAt,
        this.image,
        this.title,
        this.message,
        this.redirect,
        this.isSeen,
        this.isRead,
        this.notificationType,
    });

    int? id;
    String? createdAt;
    dynamic image;
    String? title;
    String? message;
    String? redirect;
    bool? isSeen;
    bool? isRead;
    String? notificationType;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: json["created_at"],
        image: json["image"],
        title: json["title"],
        message: json["message"],
        redirect: json["redirect"],
        isSeen: json["is_seen"],
        isRead: json["is_read"],
        notificationType: json["notification_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "image": image,
        "title": title,
        "message": message,
        "redirect": redirect,
        "is_seen": isSeen,
        "is_read": isRead,
        "notification_type": notificationType,
    };
}
