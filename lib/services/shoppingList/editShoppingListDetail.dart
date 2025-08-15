import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/shoppingList/editShoppingListDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ShoppingListDetailModel>? fetchShoppingListDetail(
      String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse("${url}shopping-list-detail/$uuid"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      ShoppingListDetailModel data =
          ShoppingListDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future deleteItem(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client
          .get(Uri.parse("${url}delete-shopping-item/$uuid"), headers: headers);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future updateShoppingList(uuid, data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(
          Uri.parse("${url}update-shopping-list/$uuid"),
          headers: headers,
          body: json.encode(data));
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future updateShoppingListItem(uuid, data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(
          Uri.parse("${url}update-shopping-item/$uuid"),
          headers: headers,
          body: data);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ShoppingListAutocompleteModel>>? fetchAutoCompleteResults(
      String? uuid, String pattern) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
          Uri.parse('${url}shopping-autocomplete/$uuid?qf=$pattern'),
          headers: headers);
      List<ShoppingListAutocompleteModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<ShoppingListAutocompleteModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ShoppingListAutocompleteModel>(
            (json) => ShoppingListAutocompleteModel.fromJson(json))
        .toList();
  }
}
