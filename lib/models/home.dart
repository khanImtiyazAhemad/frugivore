// To parse this JSON data, do
//
//     final bannersModel = bannersModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/order/myOrder.dart' as order;

List<BannersModel> bannersModelFromJson(String str) => List<BannersModel>.from(
    json.decode(str).map((x) => BannersModel.fromJson(x)));

String bannersModelToJson(List<BannersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannersModel {
  BannersModel({
    this.id,
    this.product,
    this.category,
    this.subcategory,
    this.title,
    this.banner,
    this.redirection,
    this.brand,
    this.redirectionUrl,
  });

  int? id;
  Product? product;
  Category? category;
  Subcategory? subcategory;
  String? title;
  String? banner;
  String? redirection;
  dynamic brand;
  dynamic redirectionUrl;

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        title: json["title"],
        banner: json["banner"],
        redirection: json["redirection"],
        brand: json["brand"],
        redirectionUrl: json["redirection_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "title": title,
        "banner": banner,
        "redirection": redirection,
        "brand": brand,
        "redirection_url": redirectionUrl,
      };
}

class Category {
  Category({
    this.id,
    this.subcategorySlug,
    this.name,
    this.slug,
    this.image,
    this.icon,
    this.banner,
    this.redirectionUrl,
    this.isActive,
  });

  int? id;
  String? subcategorySlug;
  String? name;
  String? slug;
  String? image;
  String? icon;
  dynamic banner;
  dynamic redirectionUrl;
  bool? isActive;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        subcategorySlug:
            json["subcategory_slug"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        icon: json["icon"],
        banner: json["banner"],
        redirectionUrl: json["redirection_url"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subcategory_slug": subcategorySlug,
        "name": name,
        "slug": slug,
        "image": image,
        "icon": icon,
        "banner": banner,
        "redirection_url": redirectionUrl,
        "is_active": isActive,
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
        isPromotional:
            json["is_promotional"],
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

class Subcategory {
  Subcategory({
    this.id,
    this.categorySlug,
    this.name,
    this.slug,
    this.image,
    this.isActive,
  });

  int? id;
  String? categorySlug;
  String? name;
  String? slug;
  String? image;
  bool? isActive;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        categorySlug:
            json["category_slug"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_slug": categorySlug,
        "name": name,
        "slug": slug,
        "image": image,
        "is_active": isActive,
      };
}

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    CategoriesModel({
        this.categories,
        this.frugivoreOriginals,
        this.count,
    });

    List<CategoryList>? categories;
    bool? frugivoreOriginals;
    int? count;

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        categories: List<CategoryList>.from(json["categories"].map((x) => CategoryList.fromJson(x))),
        frugivoreOriginals: json["frugivore_originals"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "frugivore_originals": frugivoreOriginals,
        "count": count,
    };
}

class CategoryList {
    CategoryList({
        this.id,
        this.subcategorySlug,
        this.image,
        this.icon,
        this.banner,
        this.name,
        this.slug,
        this.redirectionUrl,
        this.isActive,
    });

    int? id;
    String? subcategorySlug;
    String? image;
    String? icon;
    String? banner;
    String? name;
    String? slug;
    String? redirectionUrl;
    bool? isActive;

    factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        subcategorySlug: json["subcategory_slug"],
        image: json["image"],
        icon: json["icon"],
        banner: json["banner"],
        name: json["name"],
        slug: json["slug"],
        redirectionUrl: json["redirection_url"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subcategory_slug": subcategorySlug,
        "image": image,
        "icon": icon,
        "banner": banner,
        "name": name,
        "slug": slug,
        "redirection_url": redirectionUrl,
        "is_active": isActive,
    };
}


List<SubCategoriesModel> subCategoriesModelFromJson(String str) =>
    List<SubCategoriesModel>.from(
        json.decode(str).map((x) => SubCategoriesModel.fromJson(x)));

String subCategoriesModelToJson(List<SubCategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoriesModel {
  SubCategoriesModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isActive,
    this.categorySlug,
  });

  int? id;
  String? name;
  String? slug;
  String? image;
  bool? isActive;
  String? categorySlug;

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        isActive: json["is_active"],
        categorySlug: json["category_slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "is_active": isActive,
        "category_slug": categorySlug,
      };
}

HomePageModel homePageModelFromJson(String str) =>
    HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.offers,
    this.bestdeal,
    this.products,
    this.externalProducts,
    this.suggested,
    this.exploremore,
    this.newArrivals,
    this.frugivoreOriginals,
    this.promotional,
    this.flashSaleSection,
    this.flashSales,
  });

  List<Offer>? offers;
  List<Bestdeal>? bestdeal;
  List<GlobalProductModel>? products;
  List<GlobalProductModel>? externalProducts;
  List<GlobalProductModel>? suggested;
  List<GlobalProductModel>? newArrivals;
  List<GlobalProductModel>? frugivoreOriginals;
  List<Bestdeal>? exploremore;
  List<Promotional>? promotional;
  bool? flashSaleSection;
  List<FlashSale>? flashSales;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        bestdeal: json["bestdeal"] == null ? null : List<Bestdeal>.from(json["bestdeal"].map((x) => Bestdeal.fromJson(x))),
        products: List<GlobalProductModel>.from(
            json["products"].map((x) => GlobalProductModel.fromJson(x))),
        externalProducts: List<GlobalProductModel>.from(
            json["external"].map((x) => GlobalProductModel.fromJson(x))),
        newArrivals: List<GlobalProductModel>.from(
            json["new_arrival"].map((x) => GlobalProductModel.fromJson(x))),
        frugivoreOriginals: List<GlobalProductModel>.from(
            json["frugivore_originals"].map((x) => GlobalProductModel.fromJson(x))),
        suggested: List<GlobalProductModel>.from(
            json["suggested"].map((x) => GlobalProductModel.fromJson(x))),
        exploremore: json["exploremore"] == null ? null : List<Bestdeal>.from(json["exploremore"].map((x) => Bestdeal.fromJson(x))),
        promotional: json["promotional"] == null
            ? null
            : List<Promotional>.from(
                json["promotional"].map((x) => Promotional.fromJson(x))),
        flashSaleSection: json["flash_sale_section"],
        flashSales: json["flash_sales"] == null ? [] : List<FlashSale>.from(json["flash_sales"].map((x) => FlashSale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers!.map((x) => x.toJson())),
        "bestdeal": bestdeal == null ? null : List<dynamic>.from(bestdeal!.map((x) => x.toJson())),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "external": List<dynamic>.from(externalProducts!.map((x) => x.toJson())),
        "new_arrival": List<dynamic>.from(newArrivals!.map((x) => x.toJson())),
        "frugivore_originals": List<dynamic>.from(frugivoreOriginals!.map((x) => x.toJson())),
        "suggested": List<dynamic>.from(suggested!.map((x) => x.toJson())),
        "exploremore": exploremore == null ? null : List<dynamic>.from(exploremore!.map((x) => x.toJson())),
        "promotional": promotional == null
            ? null
            : List<dynamic>.from(promotional!.map((x) => x.toJson())),
        "flash_sale_section": flashSaleSection,
        "flash_sales": flashSales == null ? [] : List<dynamic>.from(flashSales!.map((x) => x.toJson())),
      };
}

class Promotional {
  Promotional({
    this.id,
    this.counter,
    this.banner,
    this.redirectionUrl,
    this.bannerOne,
    this.redirectionUrlOne,
    this.bannerTwo,
    this.redirectionUrlTwo,
    this.bannerThree,
    this.redirectionUrlThree,
  });

  int? id;
  int? counter;
  String? banner;
  String? redirectionUrl;
  String? bannerOne;
  String? redirectionUrlOne;
  String? bannerTwo;
  String? redirectionUrlTwo;
  dynamic bannerThree;
  dynamic redirectionUrlThree;

  factory Promotional.fromJson(Map<String, dynamic> json) => Promotional(
        id: json["id"],
        counter: json["counter"],
        banner: json["banner"],
        redirectionUrl:
            json["redirection_url"],
        bannerOne: json["banner_one"],
        redirectionUrlOne: json["redirection_url_one"],
        bannerTwo: json["banner_two"],
        redirectionUrlTwo: json["redirection_url_two"],
        bannerThree: json["banner_three"],
        redirectionUrlThree: json["redirection_url_three"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "counter": counter,
        "banner": banner,
        "redirection_url": redirectionUrl,
        "banner_one": bannerOne,
        "redirection_url_one":
            redirectionUrlOne,
        "banner_two": bannerTwo,
        "redirection_url_two":
            redirectionUrlTwo,
        "banner_three": bannerThree,
        "redirection_url_three": redirectionUrlThree,
      };
}

class Bestdeal {
  Bestdeal({
    this.product,
  });

  GlobalProductModel? product;

  factory Bestdeal.fromJson(Map<String, dynamic> json) => Bestdeal(
        product: json["product"] == null
            ? null
            : GlobalProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
      };
}

class Offer {
  Offer({
    this.id,
    this.image,
    this.desktopImage,
  });

  int? id;
  String? image;
  String? desktopImage;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        image: json["image"],
        desktopImage:
            json["desktop_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "desktop_image": desktopImage,
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

List<TestimonialsModel> testimonialsModelFromJson(String str) =>
    List<TestimonialsModel>.from(
        json.decode(str).map((x) => TestimonialsModel.fromJson(x)));

String testimonialsModelToJson(List<TestimonialsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestimonialsModel {
  TestimonialsModel({
    this.id,
    this.date,
    this.avatar,
    this.name,
    this.text,
    this.banner,
    this.location,
    this.rating,
  });

  int? id;
  String? date;
  String? avatar;
  String? name;
  String? text;
  String? banner;
  String? location;
  int? rating;

  factory TestimonialsModel.fromJson(Map<String, dynamic> json) =>
      TestimonialsModel(
        id: json["id"],
        date: json["date"],
        avatar: json["avatar"],
        name: json["name"],
        text: json["text"],
        banner: json["banner"],
        location: json["location"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "avatar": avatar,
        "name": name,
        "text": text,
        "banner": banner,
        "location": location,
        "rating": rating,
      };
}

List<BlogsModel> blogsModelFromJson(String str) =>
    List<BlogsModel>.from(json.decode(str).map((x) => BlogsModel.fromJson(x)));

String blogsModelToJson(List<BlogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogsModel {
  BlogsModel({
    this.id,
    this.image,
    this.title,
    this.slug,
    this.description,
    this.createdAt,
  });

  int? id;
  String? image;
  String? title;
  String? slug;
  String? description;
  String? createdAt;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "slug": slug,
        "description": description,
        "created_at": createdAt,
      };
}

List<PurchaseHistoryModel> purchaseHistoryModelFromJson(String str) =>
    List<PurchaseHistoryModel>.from(
        json.decode(str).map((x) => PurchaseHistoryModel.fromJson(x)));

String purchaseHistoryModelToJson(List<PurchaseHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseHistoryModel {
  PurchaseHistoryModel({
    this.id,
    this.invoiceNumber,
    this.orderId,
    this.createdDate,
    this.deliveryDate,
    this.canConvertToShoppingList,
  });

  int? id;
  String? invoiceNumber;
  String? orderId;
  String? createdDate;
  String? deliveryDate;
  bool? canConvertToShoppingList;

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryModel(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        orderId: json["order_id"],
        createdDate: json["created_date"],
        deliveryDate: json["delivery_date"],
        canConvertToShoppingList: json["can_convert_to_shopping_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "order_id": orderId,
        "created_date": createdDate,
        "delivery_date": deliveryDate,
        "can_convert_to_shopping_list": canConvertToShoppingList,
      };
}

List<SeasonBestModel> seasonBestModelFromJson(String str) =>
    List<SeasonBestModel>.from(
        json.decode(str).map((x) => SeasonBestModel.fromJson(x)));

String seasonBestModelToJson(List<SeasonBestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeasonBestModel {
  SeasonBestModel({
    this.id,
    this.product,
    this.category,
    this.subCategory,
    this.image,
    this.redirection,
    this.redirectionUrl,
  });

  int? id;
  Product? product;
  CategoryList? category;
  SubCategoriesModel? subCategory;
  String? image;
  String? redirection;
  dynamic redirectionUrl;

  factory SeasonBestModel.fromJson(Map<String, dynamic> json) =>
      SeasonBestModel(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : CategoryList.fromJson(json["category"]),
        subCategory: json["sub_category"] == null
            ? null
            : SubCategoriesModel.fromJson(json["sub_category"]),
        image: json["image"],
        redirection: json["redirection"],
        redirectionUrl: json["redirection_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "category": category?.toJson(),
        "sub_category": subCategory?.toJson(),
        "image": image,
        "redirection": redirection,
        "redirection_url": redirectionUrl,
      };
}

List<MySectionModel> mySectionModelFromJson(String str) =>
    List<MySectionModel>.from(
        json.decode(str).map((x) => MySectionModel.fromJson(x)));

String mySectionModelToJson(List<MySectionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MySectionModel {
  MySectionModel({
    this.id,
    this.product,
    this.category,
    this.subCategory,
    this.title,
    this.banner,
    this.redirection,
    this.brand,
    this.redirectionUrl,
    this.isActive,
  });

  int? id;
  Product? product;
  CategoryList? category;
  SubCategoriesModel? subCategory;
  String? title;
  String? banner;
  String ?redirection;
  dynamic brand;
  dynamic redirectionUrl;
  bool? isActive;

  factory MySectionModel.fromJson(Map<String, dynamic> json) => MySectionModel(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : CategoryList.fromJson(json["category"]),
        subCategory: json["subcategory"] == null
            ? null
            : SubCategoriesModel.fromJson(json["subcategory"]),
        title: json["title"],
        banner: json["banner"],
        redirection: json["redirection"],
        brand: json["brand"],
        redirectionUrl: json["redirection_url"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "category": category,
        "subcategory": subCategory,
        "title": title,
        "banner": banner,
        "redirection": redirection,
        "brand": brand,
        "redirection_url": redirectionUrl,
        "is_active": isActive,
      };
}

RecentOrderFeedbackModel recentOrderFeedbackModelFromJson(String str) =>
    RecentOrderFeedbackModel.fromJson(json.decode(str));

String recentOrderFeedbackModelToJson(RecentOrderFeedbackModel data) =>
    json.encode(data.toJson());

class RecentOrderFeedbackModel {
  RecentOrderFeedbackModel({
    this.lastOrderUuid,
  });

  dynamic lastOrderUuid;

  factory RecentOrderFeedbackModel.fromJson(Map<String, dynamic> json) =>
      RecentOrderFeedbackModel(
        lastOrderUuid:
            json["last_order_uuid"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "last_order_uuid": lastOrderUuid ?? false,
      };
}


class FlashSale {
    FlashSale({
        this.id,
        this.product,
        this.package,
        this.title,
        this.banner,
        this.startDate,
        this.endDate,
        this.remainingTime,
    });

    int? id;
    Product? product;
    Package? package;
    String? title;
    String? banner;
    DateTime? startDate;
    DateTime? endDate;
    int? remainingTime;

    factory FlashSale.fromJson(Map<String, dynamic> json) => FlashSale(
        id: json["id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        package: json["package"] == null ? null : Package.fromJson(json["package"]),
        title: json["title"],
        banner: json["banner"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        remainingTime: json["remaining_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "package": package?.toJson(),
        "title": title,
        "banner": banner,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "remaining_time": remainingTime,
    };
}


UndeliveredOrderModel undeliveredOrderModelFromJson(String str) => UndeliveredOrderModel.fromJson(json.decode(str));

String undeliveredOrderModelToJson(UndeliveredOrderModel data) => json.encode(data.toJson());

class UndeliveredOrderModel {
    bool? exist;
    order.Result? data;

    UndeliveredOrderModel({
        this.exist,
        this.data,
    });

    factory UndeliveredOrderModel.fromJson(Map<String, dynamic> json) => UndeliveredOrderModel(
        exist: json["exist"],
        data: json["data"] == null || json['exist'] == false ? null : order.Result.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "exist": exist,
        "data": data?.toJson(),
    };
}

List<MarketingTilesModel> marketingTilesModelFromJson(String str) => List<MarketingTilesModel>.from(json.decode(str).map((x) => MarketingTilesModel.fromJson(x)));

String marketingTilesModelToJson(List<MarketingTilesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketingTilesModel {
    int? id;
    Product? product;
    Category? category;
    Subcategory? subcategory;
    String? banner;
    String? desktopBanner;
    String? redirection;
    dynamic brand;
    dynamic redirectionUrl;
    int? priority;
    bool? isActive;

    MarketingTilesModel({
        this.id,
        this.product,
        this.category,
        this.subcategory,
        this.banner,
        this.desktopBanner,
        this.redirection,
        this.brand,
        this.redirectionUrl,
        this.priority,
        this.isActive,
    });

    factory MarketingTilesModel.fromJson(Map<String, dynamic> json) => MarketingTilesModel(
        id: json["id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"],
        subcategory: json["subcategory"],
        banner: json["banner"],
        desktopBanner: json["desktop_banner"],
        redirection: json["redirection"],
        brand: json["brand"],
        redirectionUrl: json["redirection_url"],
        priority: json["priority"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "category": category,
        "subcategory": subcategory,
        "banner": banner,
        "desktop_banner": desktopBanner,
        "redirection": redirection,
        "brand": brand,
        "redirection_url": redirectionUrl,
        "priority": priority,
        "is_active": isActive,
    };
}



EarliestDeliverySlotModel earliestDeliverySlotModelFromJson(String str) => EarliestDeliverySlotModel.fromJson(json.decode(str));

String earliestDeliverySlotModelToJson(EarliestDeliverySlotModel data) => json.encode(data.toJson());

class EarliestDeliverySlotModel {
    String? cutOffTime;
    String? endTime;
    String? addressType;
    String? address;
    bool? show;

    EarliestDeliverySlotModel({
        this.cutOffTime,
        this.endTime,
        this.addressType,
        this.address,
        this.show,
    });

    factory EarliestDeliverySlotModel.fromJson(Map<String, dynamic> json) => EarliestDeliverySlotModel(
        cutOffTime: json["cut_off_time"],
        endTime: json["end_time"],
        addressType: json["address_type"],
        address: json["address"],
        show: json["show"],
    );

    Map<String, dynamic> toJson() => {
        "cut_off_time": cutOffTime,
        "end_time": endTime,
        "address_type": addressType,
        "address": address,
        "show": show,
    };
}
