// To parse this JSON data, do
//
//     final recipeShoppingModel = recipeShoppingModelFromJson(jsonString);

import 'dart:convert';

RecipeShoppingModel recipeShoppingModelFromJson(String str) => RecipeShoppingModel.fromJson(json.decode(str));

String recipeShoppingModelToJson(RecipeShoppingModel data) => json.encode(data.toJson());

class RecipeShoppingModel {
    RecipeShoppingModel({
        this.name,
        this.recipe,
    });

    String? name;
    List<Recipe>? recipe;

    factory RecipeShoppingModel.fromJson(Map<String, dynamic> json) => RecipeShoppingModel(
        name: json["name"],
        recipe: json["recipe"] == null ? null : List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "recipe": recipe == null ? null : List<dynamic>.from(recipe!.map((x) => x.toJson())),
    };
}

class Recipe {
    Recipe({
        this.id,
        this.product,
        this.package,
        this.checkboxValue,
        this.quantity,
    });

    int? id;
    Product? product;
    Package? package;
    bool? checkboxValue;
    int? quantity;

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        package: json["package"] == null ? null : Package.fromJson(json["package"]),
        checkboxValue: json["checkbox_value"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "package": package?.toJson(),
        "checkbox_value": checkboxValue,
        "quantity": quantity,
    };
}

class Package {
    Package({
        this.id,
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
        this.stock,
        this.maxQty,
    });

    int? id;
    String? name;
    String? price;
    String? discountType;
    String? discount;
    dynamic note;
    String? imgOne;
    dynamic offerTitle;
    dynamic offerDescription;
    String? displayPrice;
    String? displayDiscount;
    int? userQuantity;
    int? stock;
    int? maxQty;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
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
        displayDiscount: json["display_discount"],
        userQuantity: json["user_quantity"],
        stock: json["stock"],
        maxQty: json["max_qty"],
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
        "stock": stock,
        "max_qty": maxQty,
    };
}

class Product {
    Product({
        this.id,
        this.veg,
        this.brand,
        this.name,
        this.slug,
        this.isPromotional,
        this.deliveryType,
    });

    int? id;
    bool? veg;
    String? brand;
    String? name;
    String? slug;
    bool? isPromotional;
    String? deliveryType;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        veg: json["veg"],
        brand: json["brand"],
        name: json["name"],
        slug: json["slug"],
        isPromotional: json["is_promotional"],
        deliveryType: json["delivery_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "veg": veg,
        "brand": brand,
        "name": name,
        "slug": slug,
        "is_promotional": isPromotional,
        "delivery_type": deliveryType,
    };
}
