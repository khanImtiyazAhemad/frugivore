import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/staticPages/signUpRewards.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<SignUpRewardsModel> fetchDetail() async {
    try {
      final response = await client.get(
        Uri.parse("${url}sign-up-rewards"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonResponse = json.decode(response.body);
      SignUpRewardsModel detail =
          SignUpRewardsModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
