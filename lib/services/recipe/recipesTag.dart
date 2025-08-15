import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/recipe/recipesTag.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<RecipesTagModel>>? fetchRecipesTag() async {
    try {
      final response = await client.get(
        Uri.parse("${url}recipes-tag"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<RecipesTagModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

    static List<RecipesTagModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RecipesTagModel>((json) => RecipesTagModel.fromJson(json))
        .toList();
  }
}
