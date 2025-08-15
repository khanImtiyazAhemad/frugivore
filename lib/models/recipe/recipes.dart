// To parse this JSON data, do
//
//     final recipesModel = recipesModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/recipe/recipeDetail.dart';


List<RecipesModel> recipesModelFromJson(String str) => List<RecipesModel>.from(
    json.decode(str).map((x) => RecipesModel.fromJson(x)));

String recipesModelToJson(List<RecipesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipesModel {
  RecipesModel({
    this.id,
    this.uuid,
    this.name,
    this.image,
    this.cuisine,
    this.preparation,
    this.serving,
    this.recipe,
  });

  int? id;
  String? uuid;
  String? name;
  String? image;
  String? cuisine;
  int? preparation;
  int? serving;
  List<Recipe>? recipe;

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        image: json["image"],
        cuisine: json["cuisine"],
        preparation: json["preparation"],
        serving: json["serving"],
        recipe:
            List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "image": image,
        "cuisine": cuisine,
        "preparation": preparation,
        "serving": serving,
        "recipe": List<dynamic>.from(recipe!.map((x) => x.toJson())),
      };
}

