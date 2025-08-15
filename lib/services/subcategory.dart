import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/subcategory.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<SubCategoryModel>? fetchSubCategoryProducts(
      String qsp, String category, String subcategory) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse("${url}subcategory/$category/$subcategory?sort=$qsp"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        SubCategoryModel detail = SubCategoryModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<SubCategoryModel>? loadMore(uri) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse(uri),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        SubCategoryModel data = SubCategoryModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
