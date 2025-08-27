import 'dart:convert';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/widgets/informative.dart';

import 'package:frugivore/models/home.dart';
import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/productDetail.dart';
import 'package:frugivore/models/subcategory.dart' as model;

import 'auth.dart';

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

Future<Map<String, String>> getHeaders() async {
  final token = await AuthServices.getToken();
  Map<String, String>? headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  if (token != null) {
    headers["Authorization"] = 'JWT $token';
  }
  return headers;
}

Future<Map<String, String>> postHeaders() async {
  final token = await AuthServices.getToken();
  Map<String, String> headers = {};
  if (token != null) {
    headers["Authorization"] = 'JWT $token';
  }
  return headers;
}

Future<Map<String, String>> multipartPostHeaders() async {
  final token = await AuthServices.getToken();
  Map<String, String>? headers = {"Content-Type": "multipart/form-data"};
  if (token != null) {
    headers["Authorization"] = 'JWT $token';
  }
  return headers;
}

Widget hasInformationData() {
  final GetStorage box = GetStorage();
  if (box.hasData('information') && box.read('information') != "") {
    String message = box.read('information');
    return InformativeStrip(message: message.toString());
  } else {
    return SizedBox();
  }
}

Image notificationLogo(type) {
  if (type == "Wallet Debit") {
    return Image.asset('assets/images/walletCredit.png');
  } else if (type == "Wallet Credit") {
    return Image.asset('assets/images/walletDebit.png');
  } else if (type == "Complaints") {
    return Image.asset('assets/images/complaints.png');
  } else if (type == "Order Placed") {
    return Image.asset('assets/images/placed.png');
  } else if (type == "Order Processed") {
    return Image.asset('assets/images/processed.png');
  } else if (type == "Order Modified & Processed") {
    return Image.asset('assets/images/modified.png');
  } else if (type == "Out for Delivery") {
    return Image.asset('assets/images/outOfDelivery.png');
  } else if (type == "Delivered") {
    return Image.asset('assets/images/delivered.png');
  } else if (type == "Rejected") {
    return Image.asset('assets/images/rejected.png');
  } else if (type == "Cancelled") {
    return Image.asset('assets/images/cancelled.png');
  } else {
    return Image.asset('assets/images/logo.png', height: 60);
  }
}

class AppInitialization {
  final GetStorage box = GetStorage();

  Future<void> fetchMainCategories() async {
    var response = await UtilsServices.fetchCategories();
    response!.categories!.map((item) {
      return globals.drawerdata[0]['child'].add({
        "title": item.name,
        "leading": CachedNetworkImage(imageUrl: item.icon!, width: 40),
        "action": "/subcategory",
        "categorySlug": item.slug,
        "subCategorySlug": item.subcategorySlug,
      });
    }).toList();
  }

  Future<void> setInitialData() async {
    if (globals.drawerdata[0]['child'].length <= 0) await fetchMainCategories();
    var footerContent = await UtilsServices.footerContent();
    if (footerContent != null) {
      globals.payload['cart'] = footerContent['count'].toString();
      globals.payload['final_cart_amount'] = footerContent['total'].toString();
      globals.payload['total_discounted_price'] = footerContent['saved']
          .toString();
      globals.payload['cart_message'] = footerContent['cart_message']
          .toString();
      globals.payload.refresh();
    }
    var informationResponse = await UtilsServices.fetchInformativeData();
    if (informationResponse != null) {
      await box.write("information", informationResponse['message']);
    }
    if (box.hasData('token')) {
      await UtilsServices.fetchProfile();
      var offerContent = await UtilsServices.offerContent();
      if (offerContent != null) {
        globals.payload['sticky_offer_content'] = offerContent['content']
            .toString();
        globals.payload.refresh();
      }
    }
    var festiveResponse = await UtilsServices.fetchFestiveData();
    if (festiveResponse != null) {
      await box.write("festival", festiveResponse['status']);
      await box.write("festivalIcon", festiveResponse['icon']);
    }
    var defaultFrugivoreSaleResponse =
        await UtilsServices.fetchDefaultFrugivoreSale();
    if (defaultFrugivoreSaleResponse != null) {
      await box.write("slug", defaultFrugivoreSaleResponse['slug']);
      await box.write(
        "saleStatus",
        defaultFrugivoreSaleResponse['frugivore_sales_exists'],
      );
      if (defaultFrugivoreSaleResponse['frugivore_sales_exists']) {
        globals.drawerdata[2]['title'] = defaultFrugivoreSaleResponse['title'];
      } else if (!defaultFrugivoreSaleResponse['frugivore_sales_exists']) {
        if (globals.drawerdata[2]['title'] == "Summer Mania Sale") {
          globals.drawerdata.removeAt(2);
        }
      }
    } else if (globals.drawerdata[2]['title'] == "Summer Mania Sale") {
      globals.drawerdata.removeAt(2);
    }
  }

  Future<void> intializeDatabase() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'cart.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart(id INTEGER PRIMARY KEY, package TEXT, product TEXT, quantity TEXT)",
        );
      },
      version: 1,
    );
    if (!box.hasData('token')) {
      List<Map> list = await database.rawQuery('SELECT * FROM cart');
      globals.payload['cart'] = list.length.toString();
      globals.payload.refresh();
    }
  }

  Future<void> removeInformationData() async {
    await box.remove('information');
  }
}

class HomePromotion {
  final List<Promotional> items;
  HomePromotion({required this.items});

  Object validation(index) {
    int currentIndex = index + 1;
    if (items.isEmpty) {
      return 0;
    } else if (currentIndex % 4 == 0) {
      int bannerIndex = (currentIndex ~/ 4) - 1;
      if (items.length > bannerIndex) {
        return items[bannerIndex];
      }
      return 0;
    }
    return 0;
  }

  List<Promotional> promotionalSubList(start, end) {
    if (items.isEmpty) {
      start = 0;
      end = 0;
    } else {
      if (items.length < start) {
        start = items.length - 1;
      }
      if (items.length < end) {
        end = items.length;
      }
    }
    return items.sublist(start, end);
  }
}

class SubCategoryPromotion {
  final List<model.Promotional> items;
  SubCategoryPromotion({required this.items});

  Object validation(index) {
    int currentIndex = index + 1;
    if (items.isEmpty) {
      return 0;
    } else if (currentIndex % 4 == 0) {
      int bannerIndex = (currentIndex ~/ 4) - 1;
      if (items.length > bannerIndex) {
        return items[bannerIndex];
      }
      return 0;
    }
    return 0;
  }

  List<model.Promotional> promotionalSubList(start, end) {
    if (items.isEmpty) {
      start = 0;
      end = 0;
    } else {
      if (items.length < start) {
        start = items.length - 1;
      }
      if (items.length < end) {
        end = items.length;
      }
    }
    return items.sublist(start, end);
  }
}

class BannerRouting {
  final BannersModel item;
  final dynamic callback;
  BannerRouting({required this.item, this.callback});

  // function
  Future<void> routing() async {
    if (item.redirection == "PRODUCT") {
      Navigator.pushNamed(
        Get.context!,
        "/product-details/${item.product!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "SUBCATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.subcategory!.categorySlug}/${item.subcategory!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "CATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.category!.slug}/${item.category!.subcategorySlug}",
      ).then((value) => callback());
    } else if (item.redirection == "BRANDS") {
      Navigator.pushNamed(
        Get.context!,
        "/search?qf=${item.brand}",
      ).then((value) => callback());
    } else if (item.redirection == "URL") {
      String route = item.redirectionUrl.replaceAll(globals.webUri, '/');
      if (route.contains("banners-shopping-list")) {
        route = route.substring(1, route.length - 1);
        var response = await UtilsServices.bannerShoppingList(route);
        if (response != null) {
          Navigator.pushNamed(
            Get.context!,
            "/edit-shopping-list/${response['uuid']}",
          ).then((value) => callback());
        }
      } else {
        Navigator.pushNamed(Get.context!, route).then((value) => callback());
      }
    }
  }
}

class TileRouting {
  final MarketingTilesModel item;
  final dynamic callback;
  TileRouting({required this.item, this.callback});

  // function
  Future<void> routing() async {
    if (item.redirection == "PRODUCT") {
      Navigator.pushNamed(
        Get.context!,
        "/product-details/${item.product!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "SUBCATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.subcategory!.categorySlug}/${item.subcategory!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "CATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.category!.slug}/${item.category!.subcategorySlug}",
      ).then((value) => callback());
    } else if (item.redirection == "BRANDS") {
      Navigator.pushNamed(
        Get.context!,
        "/search?qf=${item.brand}",
      ).then((value) => callback());
    } else if (item.redirection == "URL") {
      String route = item.redirectionUrl.replaceAll(globals.webUri, '/');
      if (route.contains("banners-shopping-list")) {
        route = route.substring(1, route.length - 1);
        var response = await UtilsServices.bannerShoppingList(route);
        if (response != null) {
          Navigator.pushNamed(
            Get.context!,
            "/edit-shopping-list/${response['uuid']}",
          ).then((value) => callback());
        }
      } else {
        Navigator.pushNamed(Get.context!, route).then((value) => callback());
      }
    }
  }
}

class SeasonBannerRouting {
  final SeasonBestModel item;
  final dynamic callback;
  SeasonBannerRouting({required this.item, this.callback});

  // function
  void routing() {
    if (item.redirection == "PRODUCT") {
      Navigator.pushNamed(
        Get.context!,
        "/product-details/${item.product!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "SUBCATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.subCategory!.categorySlug}/${item.subCategory!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "CATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.category!.slug}/${item.category!.subcategorySlug}",
      ).then((value) => callback());
    } else if (item.redirection == "URL") {
      Navigator.pushNamed(
        Get.context!,
        item.redirectionUrl.replaceAll(globals.webUri, '/'),
      ).then((value) => callback());
    }
  }
}

class MySectionBannerRouting {
  final MySectionModel item;
  final dynamic callback;
  MySectionBannerRouting({required this.item, this.callback});

  // function
  void routing() {
    if (item.redirection == "PRODUCT") {
      Navigator.pushNamed(
        Get.context!,
        "/product-details/${item.product!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "SUBCATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.subCategory!.categorySlug}/${item.subCategory!.slug}",
      ).then((value) => callback());
    } else if (item.redirection == "CATEGORY") {
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${item.category!.slug}/${item.category!.subcategorySlug}",
      ).then((value) => callback());
    } else if (item.redirection == "BRANDS") {
      Navigator.pushNamed(
        Get.context!,
        "/search?qf=${item.brand}",
      ).then((value) => callback());
    } else if (item.redirection == "URL") {
      Navigator.pushNamed(
        Get.context!,
        item.redirectionUrl.replaceAll(globals.webUri, '/'),
      ).then((value) => callback());
    }
  }
}

class SelectDefaultPackage {
  final List<Package> items;
  SelectDefaultPackage({required this.items});

  // function
  dynamic defaultPackage() {
    List result = items.where((item) => item.userQuantity! > 0).toList();
    return result.isNotEmpty ? result[0] : items[0];
  }
}

class SelectDefaultProductPackage {
  final List<ProductPackage>? items;
  SelectDefaultProductPackage({required this.items});

  // function
  dynamic defaultPackage() {
    List result = items!.where((item) => item.userQuantity! > 0).toList();
    return result.isNotEmpty ? result[0] : items![0];
  }
}

class PromotionBannerRouting {
  final String url;
  PromotionBannerRouting({required this.url});

  // function
  void routing() {
    if (url.contains('product-details/')) {
      List slug = url.split('/');
      Navigator.pushNamed(
        Get.context!,
        "/product-details/${slug[slug.length - 1]}",
      );
    } else if (url.contains('search?qf=')) {
      List queryfilter = url.split('qf=');
      Navigator.pushNamed(
        Get.context!,
        "/search?qf=${queryfilter[queryfilter.length - 1]}",
      );
    } else if (url.contains('subcategory/')) {
      List slugs = url.split('/');
      Navigator.pushNamed(
        Get.context!,
        "/subcategory/${slugs[slugs.length - 2]}/${slugs[slugs.length - 1]}",
      );
    } else if (url.contains('order-detail/')) {
      List slug = url.split('/');
      Navigator.pushNamed(
        Get.context!,
        "/order-detail/${slug[slug.length - 1]}",
      );
    } else if (url.contains('help-detail/') ||
        url.contains('complaint-detail/')) {
      List slug = url.split('/');
      Navigator.pushNamed(
        Get.context!,
        "/help-detail/${slug[slug.length - 1]}",
      );
    } else {
      Navigator.pushNamed(Get.context!, url);
    }
  }
}

class CartRouting {
  final GetStorage box = GetStorage();
  Future<void> routing() async {
    if (box.hasData('token')) {
      var response = await UtilsServices.cartHasPreOrderItem();
      print(response);
      if (!response['address']){
        Navigator.pushNamed(
          Get.context!,
          "/add-address",
        );
      } else if (response['status']) {
        Navigator.pushNamed(
          Get.context!,
          "/pre-order",
        );
      } else if (!response['status']) {
        Navigator.pushNamed(
          Get.context!,
          "/cart",
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        Get.context!,
        "/login",
        (route) => false,
      );
    }
  }
}
