import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/archives.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ArchiveModel>? fetchArchive() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}helps?status=Closed"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      ArchiveModel detail = ArchiveModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ArchiveModel> loadMore(uri) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse(uri),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        ArchiveModel data = ArchiveModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
