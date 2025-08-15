// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.page,
    this.maxPage,
    this.count,
    this.next,
    this.previous,
    this.results,
    this.title,
    this.categorytitle,
    this.banner,
    this.subcategorylist,
    this.categories,
    this.subCategories,
    this.brands,
    this.redirection,
    this.promotional,
  });

  int? page;
  int? maxPage;
  int? count;
  dynamic next;
  dynamic previous;
  List<GlobalProductModel>? results;
  String? title;
  String? categorytitle;
  dynamic banner;
  List<Subcategorylist>? subcategorylist;
  List<String>? categories;
  List<String>? subCategories;
  List<String>? brands;
  List<Promotional>? promotional;
  String? redirection;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        page: json["page"],
        maxPage: json["max_page"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<GlobalProductModel>.from(
                json["results"].map((x) => GlobalProductModel.fromJson(x))),
        title: json["title"],
        categorytitle: json["categorytitle"],
        redirection: json["redirection"],
        banner: json["banner"],
        subcategorylist: json["subcategorylist"] == null
            ? null
            : List<Subcategorylist>.from(json["subcategorylist"]
                .map((x) => Subcategorylist.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
        subCategories: json["subcategories"] == null
            ? null
            : List<String>.from(json["subcategories"].map((x) => x)),
        brands: json["brands"] == null
            ? null
            : List<String>.from(json["brands"].map((x) => x)),
        promotional: json["promotional"] == null
            ? null
            : List<Promotional>.from(
                json["promotional"].map((x) => Promotional.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "title": title,
        "categorytitle": title == null ? null : categorytitle,
        "redirection": redirection,
        "banner": banner,
        "subcategorylist": subcategorylist == null
            ? null
            : List<dynamic>.from(subcategorylist!.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x)),
        "subcategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x)),
        "brands":
            brands == null ? null : List<dynamic>.from(brands!.map((x) => x)),
        "promotional": promotional == null
            ? null
            : List<dynamic>.from(promotional!.map((x) => x.toJson())),
      };
}

class Promotional {
  Promotional({
    this.banner,
    this.redirectionUrl,
  });

  String? banner;
  String? redirectionUrl;

  factory Promotional.fromJson(Map<String, dynamic> json) => Promotional(
        banner: json["banner"],
        redirectionUrl:
            json["redirection_url"],
      );

  Map<String, dynamic> toJson() => {
        "banner": banner,
        "redirection_url": redirectionUrl,
      };
}

class Subcategorylist {
  Subcategorylist({
    this.id,
    this.name,
    this.slug,
    this.categorySlug,
  });

  int? id;
  String? name;
  String? slug;
  String? categorySlug;

  factory Subcategorylist.fromJson(Map<String, dynamic> json) =>
      Subcategorylist(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        categorySlug:
            json["category__slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "category__slug": categorySlug,
      };
}
