import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/utils.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<DynamicOfferModel>>? fetchCashback() async {
    try {
      final response = await client.get(
        Uri.parse('${url}cashback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print("Response $jsonResponse");
      List<DynamicOfferModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<DynamicOfferModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<DynamicOfferModel>((json) => DynamicOfferModel.fromJson(json))
        .toList();
  }
}
