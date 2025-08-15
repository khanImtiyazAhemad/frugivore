import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/offers/deals.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<DealsModel>>? fetchDeals() async {
    try {
      final response = await client.get(
        Uri.parse('${url}deals'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<DealsModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<DealsModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DealsModel>((json) => DealsModel.fromJson(json)).toList();
  }
}
