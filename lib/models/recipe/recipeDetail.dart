// To parse this JSON data, do
//
//     final recipeDetailModel = recipeDetailModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

RecipeDetailModel recipeDetailModelFromJson(String str) => RecipeDetailModel.fromJson(json.decode(str));

String recipeDetailModelToJson(RecipeDetailModel data) => json.encode(data.toJson());

class RecipeDetailModel {
    RecipeDetailModel({
        this.id,
        this.recipe,
        this.uuid,
        this.name,
        this.image,
        this.chef,
        this.description,
        this.steps,
        this.serving,
        this.preparation,
        this.cooking,
        this.course,
        this.cuisine,
    });

    int? id;
    List<Recipe>? recipe;
    String? uuid;
    String? name;
    String? image;
    String? chef;
    String? description;
    String? steps;
    int? serving;
    int? preparation;
    int? cooking;
    String? course;
    String? cuisine;

    factory RecipeDetailModel.fromJson(Map<String, dynamic> json) => RecipeDetailModel(
        id: json["id"],
        recipe: List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
        uuid: json["uuid"],
        name: json["name"],
        image: json["image"],
        chef: json["chef"],
        description: json["description"],
        steps: json["steps"],
        serving: json["serving"],
        preparation: json["preparation"],
        cooking: json["cooking"],
        course: json["course"],
        cuisine: json["cuisine"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "recipe": List<dynamic>.from(recipe!.map((x) => x.toJson())),
        "uuid": uuid,
        "name": name,
        "image": image,
        "chef": chef,
        "description": description,
        "steps": steps,
        "serving": serving,
        "preparation": preparation,
        "cooking": cooking,
        "course": course,
        "cuisine": cuisine,
    };
}

class Recipe {
    Recipe({
        this.id,
        this.product,
        this.package,
        this.quantity,
        this.checkboxValue
    });

    int? id;
    Product? product;
    Package? package;
    int? quantity;
    bool? checkboxValue;

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        package: Package.fromJson(json["package"]),
        quantity: json["quantity"],
        checkboxValue: json["checkbox_value"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product!.toJson(),
        "package": package!.toJson(),
        "quantity": quantity,
        "checkbox_value":checkboxValue
    };
}

