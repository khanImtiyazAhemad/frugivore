// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.product,
    this.productIcons,
    this.boughtTogtherItems,
    this.similarItems,
    this.recentPurchase,
  });

  Product? product;
  List<ProductIcon>? productIcons;
  List<GlobalProductModel>? boughtTogtherItems;
  List<GlobalProductModel>? similarItems;
  RecentPurchase? recentPurchase;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        product: Product.fromJson(json["product"]),
        productIcons: json["product_icons"] == null
            ? []
            : List<ProductIcon>.from(
                json["product_icons"]!.map((x) => ProductIcon.fromJson(x))),
        boughtTogtherItems: List<GlobalProductModel>.from(
            json["bought_togther_items"]
                .map((x) => GlobalProductModel.fromJson(x))),
        similarItems: List<GlobalProductModel>.from(
            json["similar_items"].map((x) => GlobalProductModel.fromJson(x))),
        recentPurchase: json["recent_purchase"] == null
            ? null
            : RecentPurchase.fromJson(json["recent_purchase"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product!.toJson(),
        "product_icons": productIcons == null
            ? []
            : List<dynamic>.from(productIcons!.map((x) => x.toJson())),
        "bought_togther_items":
            List<dynamic>.from(boughtTogtherItems!.map((x) => x.toJson())),
        "similar_items":
            List<dynamic>.from(similarItems!.map((x) => x.toJson())),
        "recent_purchase": recentPurchase?.toJson(),
      };
}

class ProductPackage {
  ProductPackage(
      {this.id,
      this.name,
      this.price,
      this.discountType,
      this.discount,
      this.note,
      this.imgOne,
      this.offerTitle,
      this.offerDescription,
      this.displayPrice,
      this.displayDiscount,
      this.userQuantity,
      this.images,
      this.stock,
      this.maxQty,
      this.notified});

  int? id;
  String? name;

  String? price;
  String? discountType;
  String? discount;
  String? note;
  String? imgOne;
  dynamic offerTitle;
  dynamic offerDescription;
  String? displayPrice;
  String? displayDiscount;
  int? userQuantity;
  List<String>? images;
  int? stock;
  int? maxQty;
  bool? notified;

  factory ProductPackage.fromJson(Map<String, dynamic> json) => ProductPackage(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        discountType: json["discount_type"],
        discount: json["discount"],
        note: json["note"],
        imgOne: json["img_one"],
        offerTitle: json["offer_title"],
        offerDescription: json["offer_description"],
        displayPrice: json["display_price"],
        displayDiscount:
            json["display_discount"],
        userQuantity: json["user_quantity"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        stock: json['stock'],
        maxQty: json["max_qty"],
        notified: json["notified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discount_type": discountType,
        "discount": discount,
        "note": note,
        "img_one": imgOne,
        "offer_title": offerTitle,
        "offer_description": offerDescription,
        "display_price": displayPrice,
        "display_discount": displayDiscount,
        "user_quantity": userQuantity,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "stock": stock,
        "max_qty": maxQty,
        "notified": notified
      };
}

class Product {
  Product(
      {this.id,
      this.veg,
      this.brand,
      this.name,
      this.category,
      this.subcategory,
      this.slug,
      this.facts,
      this.description,
      this.benefits,
      this.flag,
      this.ingredients,
      this.isPromotional,
      this.productPackage,
      this.deliveryType});

  int? id;
  bool? veg;
  String? brand;
  String? name;
  String? category;
  String? subcategory;
  String? slug;
  String? facts;
  String? flag;
  String? description;
  String? benefits;
  String? ingredients;
  bool? isPromotional;
  List<ProductPackage>? productPackage;
  String? deliveryType;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        veg: json["veg"],
        brand: json["brand"],
        name: json["name"],
        category: json["category"],
        subcategory: json["subcategory"],
        slug: json["slug"],
        facts: json["facts"],
        flag: json["flag"],
        description: json["description"],
        benefits: json["benefits"],
        ingredients: json["ingredients"],
        isPromotional: json["is_promotional"],
        deliveryType: json["delivery_type"],
        productPackage: List<ProductPackage>.from(
            json["product_package"].map((x) => ProductPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "veg": veg,
        "brand": brand,
        "name": name,
        "category": category,
        "subcategory": subcategory,
        "slug": slug,
        "facts": facts,
        "description": description,
        "benefits": benefits,
        "flag": flag,
        "ingredients": ingredients,
        "is_promotional": isPromotional,
        "delivery_type": deliveryType,
        "product_package":
            List<dynamic>.from(productPackage!.map((x) => x.toJson())),
      };
}

class ProductIcon {
  int? id;
  String? name;
  String? image;

  ProductIcon({
    this.id,
    this.name,
    this.image,
  });

  factory ProductIcon.fromJson(Map<String, dynamic> json) => ProductIcon(
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
