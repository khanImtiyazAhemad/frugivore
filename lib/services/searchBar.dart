import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/searchBar.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<ProductAutocompleteModel>> fetchProductAutoCompleteResults(
      String pattern) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse('${url}product-autocomplete?qf=$pattern'),
          headers: headers);
      List<ProductAutocompleteModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<ProductAutocompleteModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProductAutocompleteModel>(
            (json) => ProductAutocompleteModel.fromJson(json))
        .toList();
  }
}
