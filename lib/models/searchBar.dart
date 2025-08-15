// To parse this JSON data, do
//
//     final productAutocompleteModel = productAutocompleteModelFromJson(jsonString);

import 'dart:convert';

List<ProductAutocompleteModel> productAutocompleteModelFromJson(String str) => List<ProductAutocompleteModel>.from(json.decode(str).map((x) => ProductAutocompleteModel.fromJson(x)));

String productAutocompleteModelToJson(List<ProductAutocompleteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductAutocompleteModel {
    ProductAutocompleteModel({
        this.name,
        this.slug,
        this.recentPurchase,
    });

    String? name;
    String? slug;
    RecentPurchase? recentPurchase;

    factory ProductAutocompleteModel.fromJson(Map<String, dynamic> json) => ProductAutocompleteModel(
        name: json["name"],
        slug: json["slug"],
        recentPurchase: json["recent_purchase"] == null
            ? null
            : RecentPurchase.fromJson(json["recent_purchase"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "recent_purchase": recentPurchase?.toJson(),
    };
}


class RecentPurchase {
  String? imageUrl;
  String? purchased;
  String? orderId;
  String? packageName;
  int? quantity;
  int? totalItems;
  bool? canGiveFeedback;
  bool? productReview;

  RecentPurchase({
    this.imageUrl,
    this.purchased,
    this.orderId,
    this.packageName,
    this.quantity,
    this.totalItems,
    this.canGiveFeedback,
    this.productReview,
  });

  factory RecentPurchase.fromJson(Map<String, dynamic> json) => RecentPurchase(
        imageUrl: json["image_url"],
        purchased: json["purchased"],
        orderId: json["order_id"],
        packageName: json["package_name"],
        quantity: json["quantity"],
        totalItems: json["total_items"],
        canGiveFeedback: json["can_give_feedback"],
        productReview: json["product_review"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "purchased": purchased,
        "order_id": orderId,
        "package_name": packageName,
        "quantity": quantity,
        "total_items": totalItems,
        "can_give_feedback": canGiveFeedback,
        "product_review": productReview,
      };
}
