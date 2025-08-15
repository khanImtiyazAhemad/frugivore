import 'dart:convert';

//-------------------- Global Cart Items ------------------//

class Item {
  Item({
    this.id,
    this.product,
    this.package,
    this.freeDescription,
    this.quantity,
    this.actualPrice,
    this.discountedPrice,
    this.taxPrice,
    this.cartPrice,
    this.extra,
    this.flashSale,
    this.offer,
  });

  int? id;
  Product? product;
  Package? package;
  String? freeDescription;
  int? quantity;
  String? actualPrice;
  String? discountedPrice;
  String? taxPrice;
  String? cartPrice;
  bool? extra;
  bool? flashSale;
  int? offer;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        package: Package.fromJson(json["package"]),
        freeDescription:
            json["free_description"],
        quantity: json["quantity"],
        actualPrice: json["actual_price"],
        discountedPrice: json["discounted_price"],
        taxPrice: json["tax_price"],
        cartPrice: json["cart_price"],
        extra: json["extra"],
        flashSale: json["flash_sale"],
        offer: json["offer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product!.toJson(),
        "package": package!.toJson(),
        "free_description": freeDescription,
        "quantity": quantity,
        "actual_price": actualPrice,
        "discounted_price": discountedPrice,
        "tax_price": taxPrice,
        "cart_price": cartPrice,
        "extra": extra,
        "flash_sale": flashSale,
        "offer": offer,
      };
}

//-------------------- Global Package ------------------//

class Package {
  Package(
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
      this.flashSalePrice,
      this.displayDiscount,
      this.userQuantity,
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
  String? flashSalePrice;
  String? displayDiscount;
  int? userQuantity;
  int? stock;
  int? maxQty;
  bool? notified;

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
        flashSalePrice: json["flash_sale_price"],
        displayDiscount:
            json["display_discount"],
        userQuantity: json["user_quantity"],
        stock: json["stock"],
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
        "flash_sale_price": flashSalePrice,
        "display_discount": displayDiscount,
        "user_quantity": userQuantity,
        "stock": stock,
        "max_qty": maxQty,
        "notified": notified
      };
}

//-------------------- Global Cart Product ------------------//

class Product {
  Product({
    this.id,
    this.veg,
    this.brand,
    this.name,
    this.slug,
    this.isPromotional,
  });

  int? id;
  bool? veg;
  String? brand;
  String? name;
  String? slug;
  bool? isPromotional;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        veg: json["veg"],
        brand: json["brand"],
        name: json["name"],
        slug: json["slug"],
        isPromotional: json["is_promotional"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "veg": veg,
        "brand": brand,
        "name": name,
        "slug": slug,
        "is_promotional": isPromotional,
      };
}

//-------------------- Global Product ------------------//

class GlobalProductModel {
  GlobalProductModel({
    this.id,
    this.veg,
    this.brand,
    this.name,
    this.slug,
    this.isPromotional,
    this.productIcons,
    this.productPackage,
    this.deliveryType,
    this.recentPurchase,
  });

  int? id;
  bool? veg;
  String? brand;
  String? name;
  String? slug;
  bool? isPromotional;
  String? deliveryType;
  List<Package>? productPackage;
  List<GlobalProductIcons>? productIcons;
  RecentPurchase? recentPurchase;

  factory GlobalProductModel.fromJson(Map<String, dynamic> json) =>
      GlobalProductModel(
        id: json["id"],
        veg: json["veg"],
        brand: json["brand"],
        name: json["name"],
        slug: json["slug"],
        isPromotional: json["is_promotional"],
        deliveryType: json["delivery_type"],
        productPackage: List<Package>.from(
            json["product_package"].map((x) => Package.fromJson(x))),
        productIcons: json["product_icons"] == null
            ? []
            : List<GlobalProductIcons>.from(json["product_icons"]!
                .map((x) => GlobalProductIcons.fromJson(x))),
        recentPurchase: json["recent_purchase"] == null
            ? null
            : RecentPurchase.fromJson(json["recent_purchase"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "veg": veg,
        "brand": brand,
        "name": name,
        "slug": slug,
        "is_promotional": isPromotional,
        "delivery_type": deliveryType,
        "product_package":
            List<dynamic>.from(productPackage!.map((x) => x.toJson())),
        "product_icons": productIcons == null
            ? []
            : List<dynamic>.from(productIcons!.map((x) => x.toJson())),
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

class GlobalProductIcons {
  int? id;
  String? name;
  String? image;

  GlobalProductIcons({
    this.id,
    this.name,
    this.image,
  });

  factory GlobalProductIcons.fromJson(Map<String, dynamic> json) =>
      GlobalProductIcons(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel(
      {this.uuid,
      this.email,
      this.phone,
      this.avatar,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.alternatePhone,
      this.token,
      this.address});

  String? uuid;
  String? email;
  String? phone;
  String? avatar;
  String? name;
  String? gender;
  DateTime? dateOfBirth;
  String? alternatePhone;
  String? token;
  String? address;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      uuid: json["uuid"],
      email: json["email"],
      phone: json["phone"],
      avatar: json["avatar"],
      name: json["name"],
      gender: json["gender"],
      dateOfBirth: json["date_of_birth"] == null
          ? null
          : DateTime.parse(json["date_of_birth"]),
      alternatePhone: json["alternate_phone"],
      token: json["token"],
      address: json['address']);

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "name": name,
        "gender": gender,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "alternate_phone": alternatePhone,
        "token": token,
        "address": address
      };
}

class Address {
  Address({
    this.id,
    this.uuid,
    this.email,
    this.name,
    this.phone,
    this.alternatePhone,
    this.address,
    this.city,
    this.area,
    this.landmark,
    this.pinCode,
    this.addressType,
    this.lat,
    this.lng,
    this.isDefault,
    this.deliverHere,
  });

  int? id;
  String? uuid;
  String? email;
  String? name;
  String? phone;
  dynamic alternatePhone;
  String? address;
  String? city;
  String? area;
  dynamic landmark;
  String? pinCode;
  String? addressType;
  dynamic lat;
  dynamic lng;
  bool? isDefault;
  bool? deliverHere;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        uuid: json["uuid"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        address: json["address"],
        city: json["city"],
        area: json["area"],
        landmark: json["landmark"],
        pinCode: json["pin_code"],
        addressType: json["address_type"],
        lat: json["lat"],
        lng: json["lng"],
        isDefault: json["is_default"],
        deliverHere: json["deliver_here"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "email": email,
        "name": name,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "address": address,
        "city": city,
        "area": area,
        "landmark": landmark,
        "pin_code": pinCode,
        "address_type": addressType,
        "lat": lat,
        "lng": lng,
        "is_default": isDefault,
        "deliver_here": deliverHere,
      };
}

StaticManagementModel staticManagementModelFromJson(String str) =>
    StaticManagementModel.fromJson(json.decode(str));

String staticManagementModelToJson(StaticManagementModel data) =>
    json.encode(data.toJson());

class StaticManagementModel {
  StaticManagementModel({
    this.data,
    this.title,
  });

  Data? data;
  String? title;

  factory StaticManagementModel.fromJson(Map<String, dynamic> json) =>
      StaticManagementModel(
        data: Data.fromJson(json["data"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "title": title,
      };
}

class Data {
  Data({
    this.id,
    this.content,
  });

  int? id;
  String? content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
      };
}

List<DynamicOfferModel> dynamicOfferModelFromJson(String str) =>
    List<DynamicOfferModel>.from(
        json.decode(str).map((x) => DynamicOfferModel.fromJson(x)));

String dynamicOfferModelToJson(List<DynamicOfferModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicOfferModel {
  DynamicOfferModel({
    this.id,
    this.code,
    this.banner,
    this.description,
    this.termsAndCondition,
  });

  int? id;
  String? code;
  dynamic banner;
  String? description;
  String? termsAndCondition;

  factory DynamicOfferModel.fromJson(Map<String, dynamic> json) =>
      DynamicOfferModel(
        id: json["id"],
        code: json["code"],
        banner: json["banner"],
        description: json["description"],
        termsAndCondition: json["terms_and_condition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "banner": banner,
        "description": description,
        "terms_and_condition":
            termsAndCondition,
      };
}

class Result {
  Result({
    this.id,
    this.code,
    this.banner,
    this.description,
    this.termsAndCondition,
  });

  int? id;
  String? code;
  String? banner;
  String? description;
  String? termsAndCondition;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        code: json["code"],
        banner: json["banner"],
        description: json["description"],
        termsAndCondition: json["terms_and_condition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "banner": banner,
        "description": description,
        "terms_and_condition": termsAndCondition,
      };
}
