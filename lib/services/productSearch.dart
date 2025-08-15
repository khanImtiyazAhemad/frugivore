import 'dart:convert';

import '../utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:frugivore/models/productSearch.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ProductSearchModel>? fetchSearchResults(
      String? qsp, String? pattern) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse('${url}product-search?sort=$qsp&qf=$pattern'),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      ProductSearchModel data = ProductSearchModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ProductSearchModel>? loadMore(String uri) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse(uri), headers: headers);
      final jsonResponse = json.decode(response.body);
      ProductSearchModel data = ProductSearchModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future lookingFor(Map data) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.post(Uri.parse('${url}add-search-products'),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
