import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/topics.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<HelpTopicsModel>? fetchHelpTopics() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-topics"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      HelpTopicsModel data = HelpTopicsModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
