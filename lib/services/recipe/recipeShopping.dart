import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/recipe/recipeShopping.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<RecipeShoppingModel>? fetchIngredients(String uuid) async {
    try {
      final response = await client.get(
        Uri.parse("${url}recipe-shopping/$uuid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonResponse = json.decode(response.body);
      RecipeShoppingModel data = RecipeShoppingModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future moveToCart(uuid, data) async {
    Map<String, String>? headers = await utils.postHeaders();

    try {
      final response = await client.post(
          Uri.parse("${url}recipe-move-to-cart/$uuid"),
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
}
