// To parse this JSON data, do
//
//     final shoppingListDetailModel = shoppingListDetailModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

ShoppingListDetailModel shoppingListDetailModelFromJson(String str) => ShoppingListDetailModel.fromJson(json.decode(str));

String shoppingListDetailModelToJson(ShoppingListDetailModel data) => json.encode(data.toJson());

class ShoppingListDetailModel {
    ShoppingListDetailModel({
        this.uuid,
        this.name,
        this.description,
        this.totalItems,
        this.canSubscribe,
        this.shoppingListItems,
    });

    String? uuid;
    String? name;
    String? description;
    int? totalItems;
    bool? canSubscribe;
    List<ShoppingListItem>? shoppingListItems;

    factory ShoppingListDetailModel.fromJson(Map<String, dynamic> json) => ShoppingListDetailModel(
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        totalItems: json["total_items"],
        canSubscribe: json["can_subscribe"],
        shoppingListItems: List<ShoppingListItem>.from(json["shopping_list_items"].map((x) => ShoppingListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "description": description,
        "total_items": totalItems,
        "can_subscribe": canSubscribe,
        "shopping_list_items": List<dynamic>.from(shoppingListItems!.map((x) => x.toJson())),
    };
}

class ShoppingListItem {
    ShoppingListItem({
        this.name,
        this.items,
    });

    String? name;
    List<Item>? items;

    factory ShoppingListItem.fromJson(Map<String, dynamic> json) => ShoppingListItem(
        name: json["name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.id,
        this.uuid,
        this.brand,
        this.name,
        this.package,
        this.quantity,
        this.image,
        this.productId,
        this.packageId,

    });

    int? id;
    String? uuid;
    String? brand;
    String? name;
    String? package;
    int? quantity;
    String? image;
    String? productId;
    String? packageId;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        uuid: json["uuid"],
        brand: json["brand"],
        name: json["name"],
        package: json["package"],
        quantity: json["quantity"],
        image: json["image"],
        productId: json["product_id"],
        packageId: json["package_id"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "brand": brand,
        "name": name,
        "package": package,
        "quantity": quantity,
        "image": image,
        "product_id": productId,
        "package_id": packageId
    };
}


List<ShoppingListAutocompleteModel> shoppingListAutocompleteModelFromJson(String str) => List<ShoppingListAutocompleteModel>.from(json.decode(str).map((x) => ShoppingListAutocompleteModel.fromJson(x)));

String shoppingListAutocompleteModelToJson(List<ShoppingListAutocompleteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingListAutocompleteModel {
    ShoppingListAutocompleteModel({
        this.id,
        this.veg,
        this.brand,
        this.name,
        this.slug,
        this.isPromotional,
        this.deliveryType,
        this.package,
    });

    int? id;
    bool? veg;
    String? brand;
    String? name;
    String? slug;
    bool? isPromotional;
    String? deliveryType;
    Package? package;

    factory ShoppingListAutocompleteModel.fromJson(Map<String, dynamic> json) => ShoppingListAutocompleteModel(
        id: json["id"],
        veg: json["veg"],
        brand: json["brand"],
        name: json["name"],
        slug: json["slug"],
        isPromotional: json["is_promotional"],
        deliveryType: json["delivery_type"],
        package: json["package"] == null ? null : Package.fromJson(json["package"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "veg": veg,
        "brand": brand,
        "name": name,
        "slug": slug,
        "is_promotional": isPromotional,
        "delivery_type": deliveryType,
        "package": package?.toJson(),
    };
}