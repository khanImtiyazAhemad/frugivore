import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/subTopics.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<HelpSubTopicsModel>>? fetchHelpSubTopics(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-subtopics/$uuid"),
        headers: headers,
      );
      List<HelpSubTopicsModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

    static List<HelpSubTopicsModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HelpSubTopicsModel>((json) => HelpSubTopicsModel.fromJson(json))
        .toList();
  }
}
