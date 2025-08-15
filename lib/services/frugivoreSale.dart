import 'dart:convert';

import '../utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:frugivore/models/frugivoreSale.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<FrugivoreSaleModel>? fetchFrugivoreSale(String? slug) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse('${url}frugivore-sale/${slug!}'),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      FrugivoreSaleModel data =
          FrugivoreSaleModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<FrugivoreSaleModel>? loadMore(String uri) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse(uri), headers: headers);
      final jsonResponse = json.decode(response.body);
      FrugivoreSaleModel data =
          FrugivoreSaleModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
