import 'dart:core';

import 'dart:convert';
import '../utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/productDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ProductDetailModel> fetchProductDetail(String slug) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse("${url}product-detail/$slug"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        ProductDetailModel detail = ProductDetailModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
