import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/offers/discounts.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<DiscountModel>? fetchDiscounts(String qsp) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse("${url}discount?sort=$qsp"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      DiscountModel detail = DiscountModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DiscountModel>? loadMore(uri) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse(uri),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        DiscountModel data = DiscountModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
