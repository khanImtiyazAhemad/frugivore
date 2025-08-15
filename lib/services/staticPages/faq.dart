import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/staticPages/faq.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<FaqModel>? fetchFaq() async {
    try {
      final response = await client.get(
        Uri.parse("${url}faq"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonResponse = json.decode(response.body);
      FaqModel detail = FaqModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}