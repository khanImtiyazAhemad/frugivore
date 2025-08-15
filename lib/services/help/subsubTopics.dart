import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/subsubTopics.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<List<HelpSubSubTopicsModel>>? fetchHelpSubSubTopics(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-sub-subtopics/$uuid"),
        headers: headers,
      );
      List<HelpSubSubTopicsModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

    static List<HelpSubSubTopicsModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HelpSubSubTopicsModel>((json) => HelpSubSubTopicsModel.fromJson(json))
        .toList();
  }
}
