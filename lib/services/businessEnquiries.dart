import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;


class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future submitQuery(data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(Uri.parse("${url}submit-enquiry"),
          headers: headers, body: data);
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
