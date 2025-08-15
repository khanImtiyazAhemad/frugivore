// To parse this JSON data, do
//
//     final recipesTagModel = recipesTagModelFromJson(jsonString);

import 'dart:convert';

List<RecipesTagModel> recipesTagModelFromJson(String str) => List<RecipesTagModel>.from(json.decode(str).map((x) => RecipesTagModel.fromJson(x)));

String recipesTagModelToJson(List<RecipesTagModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipesTagModel {
    RecipesTagModel({
        this.id,
        this.name,
        this.image,
    });

    int? id;
    String? name;
    String? image;

    factory RecipesTagModel.fromJson(Map<String, dynamic> json) => RecipesTagModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
