import 'dart:core';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/welcome.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<WelcomeModel>? fetchWelcomeDetails() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response =
          await client.get(Uri.parse("${url}signup-code"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        WelcomeModel data = WelcomeModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<WelcomeModel>? submitSignupCode(data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(Uri.parse("${url}signup-code"),
          headers: headers, body: data);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        WelcomeModel data = WelcomeModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
