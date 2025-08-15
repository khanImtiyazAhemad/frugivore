import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/categories.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<ShopByCategoriesModel>>? fetchCategories() async {
    try {
      final response = await client.get(
        Uri.parse('${url}shop-by-categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<ShopByCategoriesModel> list = parseCategoriesList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<ShopByCategoriesModel> parseCategoriesList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ShopByCategoriesModel>((json) => ShopByCategoriesModel.fromJson(json))
        .toList();
  }
}
