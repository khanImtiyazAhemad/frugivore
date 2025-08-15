import 'dart:core';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/home.dart';
import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/pincode.dart';

class UtilsServices {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ProfileModel>? fetchProfile() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}profile"), headers: headers);
      final jsonResponse = json.decode(response.body);
      globals.payload['uuid'] = jsonResponse['uuid'];
      globals.payload['email'] =
          jsonResponse['email'] ?? "";
      globals.payload['phone'] = jsonResponse['phone'];
      globals.payload['avatar'] =
          jsonResponse['avatar'] ?? "";
      globals.payload['name'] =
          jsonResponse['name'] ?? "";
      globals.payload['gender'] =
          jsonResponse['gender'] ?? "";
      globals.payload['date_of_birth'] = jsonResponse['date_of_birth'] ?? "";
      globals.payload['alternate_phone'] =
          jsonResponse['alternate_phone'] ?? "";
      globals.payload['token'] = jsonResponse['token'];
      globals.payload['cart'] = jsonResponse['cart'].toString();
      globals.payload['referral_code'] = jsonResponse['referral_code'];
      globals.payload['address'] = jsonResponse['address'];
      globals.payload['notification'] = jsonResponse['notification'].toString();
      globals.payload.refresh();
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        ProfileModel loginDetail = ProfileModel.fromJson(jsonResponse);
        return loginDetail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future fetchInformativeData() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}information"), headers: headers);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future fetchDefaultFrugivoreSale() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .get(Uri.parse("${url}default-frugivore-sale"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      if (globals.drawerdata[2]['title'] == "Summer Mania Sale") {
        globals.drawerdata.removeAt(2);
      }
      throw Exception(e.toString());
    }
  }

  static Future fetchFestiveData() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}festival"), headers: headers);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['status']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<CategoriesModel>? fetchCategories() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response =
          await client.get(Uri.parse('${url}categories'), headers: headers);
      final jsonResponse = json.decode(response.body);
      return CategoriesModel.fromJson(jsonResponse);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future repeatOrder(String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse("${url}repeat-order/$uuid"),
          headers: headers);
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

  static Future updateCart(product, package, quantity,
      {flashSale = false}) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client
          .post(Uri.parse("${url}update-cart-item"), headers: headers, body: {
        "product": product.toString(),
        "package": package.toString(),
        "quantity": quantity.toString(),
        "flash_sale": flashSale.toString(),
      });
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        globals.payload['cart'] = jsonResponse['count'].toString();
        globals.payload['final_cart_amount'] = jsonResponse['sub_total'].toString();
        globals.payload['total_discounted_price'] =
            jsonResponse['saved'].toString();
        globals.payload['cart_message'] =
            jsonResponse['cart_message'].toString();
        globals.payload.refresh();
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future deleteItem(id) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse("${url}delete-item/$id"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        globals.payload['cart'] = jsonResponse['count'].toString();
        globals.payload.refresh();
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future convertToCart(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .get(Uri.parse("${url}convert-to-cart/$uuid"), headers: headers);
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

  static Future convertToShoppingList(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse("${url}convert-to-shopping-list/$uuid"),
          headers: headers);
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

  static Future activateSubscription(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse("${url}activate-subscription/$uuid"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future deactiveSubscription(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse("${url}deactivate-subscription/$uuid"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future subscriptionValidation(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse("${url}subscription-validation/$uuid"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future cartHasPreOrderItem() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .get(Uri.parse("${url}cart-has-pre-order-item"), headers: headers);
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

  static Future notifyItem(package) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client
          .post(Uri.parse("${url}notify-me"), headers: headers, body: {
        "package": package.toString(),
      });
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

  static Future bannerShoppingList(route) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse(url + route), headers: headers);
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

  static Future unreadCount() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}help-count"), headers: headers);
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future logout() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}logout"), headers: headers);
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

  static Future footerContent() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.post(Uri.parse("${url}base-footer-content"),
          headers: headers);
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

  static Future offerContent() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .post(Uri.parse("${url}sticky-offer-content"), headers: headers);
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

  static Future<List<PinCodeSearchModel>> fetchArea(String pattern) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse('${url}area-search-autcomplete?qf=$pattern'),
          headers: headers);
      List<PinCodeSearchModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<PinCodeSearchModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PinCodeSearchModel>((json) => PinCodeSearchModel.fromJson(json))
        .toList();
  }
}
