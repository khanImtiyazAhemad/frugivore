// To parse this JSON data, do
//
//     final productSearchModel = productSearchModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

ProductSearchModel productSearchModelFromJson(String str) =>
    ProductSearchModel.fromJson(json.decode(str));

String productSearchModelToJson(ProductSearchModel data) =>
    json.encode(data.toJson());

class ProductSearchModel {
  ProductSearchModel({
    this.page,
    this.maxPage,
    this.count,
    this.next,
    this.previous,
    this.results,
    this.categories,
    this.subCategories,
    this.brands,
  });
  int? page;
  int? maxPage;
  int? count;
  String? next;
  dynamic previous;
  List<GlobalProductModel>? results;
  List<String>? categories;
  List<String>? subCategories;
  List<String>? brands;

  factory ProductSearchModel.fromJson(Map<String, dynamic> json) =>
      ProductSearchModel(
        page: json["page"],
        maxPage: json['max_page'],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<GlobalProductModel>.from(
                json["results"].map((x) => GlobalProductModel.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
        subCategories: json["subcategories"] == null
            ? null
            : List<String>.from(json["subcategories"].map((x) => x)),
        brands: json["brands"] == null
            ? null
            : List<String>.from(json["brands"].map((x) => x)),
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
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x)),
        "subcategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x)),
        "brands":
            brands == null ? null : List<dynamic>.from(brands!.map((x) => x)),
      };
}
