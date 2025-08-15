// To parse this JSON data, do
//
//     final discountModel = discountModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

DiscountModel discountModelFromJson(String str) =>
    DiscountModel.fromJson(json.decode(str));

String discountModelToJson(DiscountModel data) => json.encode(data.toJson());

class DiscountModel {
  DiscountModel({
    this.page,
    this.maxPage,
    this.count,
    this.next,
    this.previous,
    this.results,
    this.brands,
    this.categories,
    this.subCategories,
  });
  int? page;
  int? maxPage;
  int? count;
  String? next;
  dynamic previous;
  List<GlobalProductModel>? results;
  List<String>? brands;
  List<String>? categories;
  List<String>? subCategories;

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        page: json["page"],
        maxPage: json['max_page'],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<GlobalProductModel>.from(
            json["results"].map((x) => GlobalProductModel.fromJson(x))),
        brands: List<String>.from(json["brands"].map((x) => x)),
        categories: List<String>.from(json["categories"].map((x) => x)),
        subCategories: List<String>.from(json["subcategories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "brands": List<dynamic>.from(brands!.map((x) => x)),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "subcategories": List<dynamic>.from(subCategories!.map((x) => x)),
      };
}
