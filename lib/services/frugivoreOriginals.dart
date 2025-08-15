import 'dart:convert';

import '../utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:frugivore/models/frugivoreOriginals.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<FrugivoreOriginalsModel>? fetchFrugivoreOriginals(String? qsp) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse('${url}frugivore-originals?sort=$qsp'),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      FrugivoreOriginalsModel data =
          FrugivoreOriginalsModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<FrugivoreOriginalsModel>? loadMore(String uri) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse(uri), headers: headers);
      final jsonResponse = json.decode(response.body);
      FrugivoreOriginalsModel data =
          FrugivoreOriginalsModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
