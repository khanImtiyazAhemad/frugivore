// To parse this JSON data, do
//
//     final shopByCategoriesModel = shopByCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<ShopByCategoriesModel> shopByCategoriesModelFromJson(String str) => List<ShopByCategoriesModel>.from(json.decode(str).map((x) => ShopByCategoriesModel.fromJson(x)));

String shopByCategoriesModelToJson(List<ShopByCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopByCategoriesModel {
    ShopByCategoriesModel({
        this.id,
        this.name,
        this.icon,
        this.image,
        this.category,
    });

    int? id;
    String? name;
    String? icon;
    String? image;
    List<Category>? category;

    factory ShopByCategoriesModel.fromJson(Map<String, dynamic> json) => ShopByCategoriesModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        image: json["image"],
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "image": image,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        required this.id,
        required this.categorySlug,
        required this.name,
        required this.slug,
        required this.image,
        required this.isActive,
    });

    int id;
    String categorySlug;
    String name;
    String slug;
    String image;
    bool isActive;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categorySlug: json["category_slug"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_slug": categorySlug,
        "name": name,
        "slug": slug,
        "image": image,
        "is_active": isActive,
    };
}
