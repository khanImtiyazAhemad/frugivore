// To parse this JSON data, do
//
//     final dealsModel = dealsModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

List<DealsModel> dealsModelFromJson(String str) =>
    List<DealsModel>.from(json.decode(str).map((x) => DealsModel.fromJson(x)));

String dealsModelToJson(List<DealsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealsModel {
  DealsModel({
    this.id,
    this.title,
    this.image,
    this.products,
  });

  int? id;
  String? title;
  String? image;
  List<GlobalProductModel>? products;

  factory DealsModel.fromJson(Map<String, dynamic> json) => DealsModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        products: json["products"] == null ? null : List<GlobalProductModel>.from(json["products"].map((x) => GlobalProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
