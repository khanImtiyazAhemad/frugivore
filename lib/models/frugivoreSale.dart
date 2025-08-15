// To parse this JSON data, do
//
//     final frugivoreSaleModel = frugivoreSaleModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

FrugivoreSaleModel frugivoreSaleModelFromJson(String str) =>
    FrugivoreSaleModel.fromJson(json.decode(str));

String frugivoreSaleModelToJson(FrugivoreSaleModel data) =>
    json.encode(data.toJson());

class FrugivoreSaleModel {
  String? title;
  List<Title>? titles;
  List<String>? banners;
  FrugivoreSaleItem? data;

  FrugivoreSaleModel({
    this.title,
    this.titles,
    this.banners,
    this.data,
  });

  factory FrugivoreSaleModel.fromJson(Map<String, dynamic> json) =>
      FrugivoreSaleModel(
        title: json['title'],
        titles: json["titles"] == null
            ? []
            : List<Title>.from(json["titles"]!.map((x) => Title.fromJson(x))),
        banners: json["banners"] == null
            ? []
            : List<String>.from(json["banners"]!.map((x) => x)),
        data: json["data"] == null
            ? null
            : FrugivoreSaleItem.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "titles": titles == null
            ? []
            : List<dynamic>.from(titles!.map((x) => x.toJson())),
        "banners":
            banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
        "data": data?.toJson(),
      };
}

class Title {
  String? title;
  String? slug;

  Title({
    this.title,
    this.slug,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        title: json["title"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
      };
}

class FrugivoreSaleItem {
  int? id;
  List<GlobalProductModel>? products;
  String? categoryName;
  String? title;
  String? slug;
  String? banner;
  String? desktopBanner;
  int? priority;
  bool? isActive;
  int? category;

  FrugivoreSaleItem({
    this.id,
    this.products,
    this.categoryName,
    this.title,
    this.slug,
    this.banner,
    this.desktopBanner,
    this.priority,
    this.isActive,
    this.category,
  });

  factory FrugivoreSaleItem.fromJson(Map<String, dynamic> json) =>
      FrugivoreSaleItem(
        id: json["id"],
        products: json["products"] == null
            ? []
            : List<GlobalProductModel>.from(
                json["products"]!.map((x) => GlobalProductModel.fromJson(x))),
        categoryName: json["category_name"],
        title: json["title"],
        slug: json["slug"],
        banner: json["banner"],
        desktopBanner: json["desktop_banner"],
        priority: json["priority"],
        isActive: json["is_active"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "category_name": categoryName,
        "title": title,
        "slug": slug,
        "banner": banner,
        "desktop_banner": desktopBanner,
        "priority": priority,
        "is_active": isActive,
        "category": category,
      };
}
