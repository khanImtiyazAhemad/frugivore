import 'dart:convert';

import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/recipe/recipeDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<RecipeDetailModel>? fetchRecipeDetail(String uuid) async {
    try {
      final response = await client.get(
        Uri.parse("${url}recipe-detail/$uuid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonResponse = json.decode(response.body);
      RecipeDetailModel data = RecipeDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
