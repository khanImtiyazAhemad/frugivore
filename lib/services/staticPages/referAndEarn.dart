import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/staticPages/referAndEarn.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ReferEarnModel>? fetchCondition() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
          Uri.parse("${url}referral/${globals.payload['referral_code']}"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      ReferEarnModel detail = ReferEarnModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future submitReference(data) async {
    Map<String, String>? headers = await utils.postHeaders();

    try {
      final response = await client.post(
          Uri.parse("${url}referral/${globals.payload['referral_code']}"),
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
