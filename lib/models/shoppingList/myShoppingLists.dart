// To parse this JSON data, do
//
//     final myShoppingList = myShoppingListFromJson(jsonString);

import 'dart:convert';

MyShoppingListModel myShoppingListFromJson(String str) => MyShoppingListModel.fromJson(json.decode(str));

String myShoppingListToJson(MyShoppingListModel data) => json.encode(data.toJson());

class MyShoppingListModel {
    MyShoppingListModel({
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

    factory MyShoppingListModel.fromJson(Map<String, dynamic> json) => MyShoppingListModel(
      page: json["page"],
        maxPage: json['max_page'],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
      "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.uuid,
        this.name,
        this.description,
        this.totalItems,
        this.createdAt,
        this.canSubscribe,
    });

    String? uuid;
    String? name;
    String? description;
    int? totalItems;
    String? createdAt;
    bool? canSubscribe;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        totalItems: json["total_items"],
        createdAt: json["created_at"],
        canSubscribe: json["can_subscribe"]
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "description": description,
        "total_items": totalItems,
        "created_at": createdAt,
        "can_subscribe": canSubscribe
    };
}
