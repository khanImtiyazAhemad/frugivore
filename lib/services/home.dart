import 'dart:convert';
import '../utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/home.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<HomePageModel>? fetchHomePage() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      HomePageModel homeDetail = HomePageModel.fromJson(jsonResponse);
      return homeDetail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<BannersModel>>? fetchBanners() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}banners'),
        headers: headers,
      );
      List<BannersModel> list = parseBannersList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<BannersModel> parseBannersList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BannersModel>((json) => BannersModel.fromJson(json))
        .toList();
  }

  static Future<List<SubCategoriesModel>>? fetchSubCategories() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}subcategories'),
        headers: headers,
      );
      List<SubCategoriesModel> list = parseSubCategoriesList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<SubCategoriesModel> parseSubCategoriesList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<SubCategoriesModel>((json) => SubCategoriesModel.fromJson(json))
        .toList();
  }

  static Future<List<TestimonialsModel>>? fetchTestimonials() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}testimonials'),
        headers: headers,
      );
      List<TestimonialsModel> list = parseTestimonialList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<TestimonialsModel> parseTestimonialList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TestimonialsModel>((json) => TestimonialsModel.fromJson(json))
        .toList();
  }

  static Future<List<BlogsModel>>? fetchBlogs() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}blogs'),
        headers: headers,
      );
      List<BlogsModel> list = parseBlogList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<BlogsModel> parseBlogList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BlogsModel>((json) => BlogsModel.fromJson(json)).toList();
  }

  static Future<List<PurchaseHistoryModel>>? fetchPurchaseHistory() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}purchase-history'),
        headers: headers,
      );
      List<PurchaseHistoryModel> list = parsePurchaseHistoryList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<PurchaseHistoryModel> parsePurchaseHistoryList(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PurchaseHistoryModel>(
            (json) => PurchaseHistoryModel.fromJson(json))
        .toList();
  }

  static Future<RecentOrderFeedbackModel>? fetchRecentOrderFeedback() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}recent-order-feedback'),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      RecentOrderFeedbackModel data =
          RecentOrderFeedbackModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<SeasonBestModel>>? fetchSeasonBestItems() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}banner-section'),
        headers: headers,
      );
      List<SeasonBestModel> list = parseSeasonBestItems(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<SeasonBestModel> parseSeasonBestItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<SeasonBestModel>((json) => SeasonBestModel.fromJson(json))
        .toList();
  }

  static Future<List<MySectionModel>>? fetchMySectionItems() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}banner-section-two'),
        headers: headers,
      );
      List<MySectionModel> list = parseMySectionItems(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<MySectionModel> parseMySectionItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MySectionModel>((json) => MySectionModel.fromJson(json))
        .toList();
  }

  static Future rateusOrder(String uuid, Map data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(
          Uri.parse("${url}last-order-feedback/$uuid"),
          headers: headers,
          body: data);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<UndeliveredOrderModel>? fetchlastUndeliverdOrder() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse("${url}last-undelivered-order"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      UndeliveredOrderModel? undeliveredOrderDetail =
          UndeliveredOrderModel.fromJson(jsonResponse);
      return undeliveredOrderDetail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<MarketingTilesModel>>? fetchMarketingTiles() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse('${url}marketing-tiles'),
        headers: headers,
      );
      List<MarketingTilesModel> list = parseMarketingTiles(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<MarketingTilesModel> parseMarketingTiles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MarketingTilesModel>((json) => MarketingTilesModel.fromJson(json))
        .toList();
  }

  static Future<EarliestDeliverySlotModel>? fetchEarliestDeliverySlot() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse("${url}earliest-delivery-slot"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      EarliestDeliverySlotModel data =
          EarliestDeliverySlotModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
