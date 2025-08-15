import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/models/shoppingList/myShoppingLists.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<MyShoppingListModel>? fetchShoppingLists() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse('${url}my-shopping-list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        MyShoppingListModel data = MyShoppingListModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

    static Future<MyShoppingListModel>? loadMore(uri) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        MyShoppingListModel data = MyShoppingListModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future createShoppingList(data) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(Uri.parse("${url}add-shopping-list"),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Authorization': 'JWT $token'
          },
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
}
