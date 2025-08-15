// To parse this JSON data, do
//
//     final shoppingListDetailModel = shoppingListDetailModelFromJson(jsonString);

import 'dart:convert';

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
    });

    int? id;
    String? uuid;
    String? brand;
    String? name;
    String? package;
    int? quantity;
    String? image;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        uuid: json["uuid"],
        brand: json["brand"],
        name: json["name"],
        package: json["package"],
        quantity: json["quantity"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "brand": brand,
        "name": name,
        "package": package,
        "quantity": quantity,
        "image": image,
    };
}
