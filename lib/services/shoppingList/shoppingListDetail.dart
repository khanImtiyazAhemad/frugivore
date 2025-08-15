import 'dart:convert';

import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/auth.dart';
import 'package:frugivore/models/shoppingList/shoppingListDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ShoppingListDetailModel>? fetchShoppingListDetail(String uuid) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse("${url}shopping-list-detail/$uuid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      ShoppingListDetailModel data = ShoppingListDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
