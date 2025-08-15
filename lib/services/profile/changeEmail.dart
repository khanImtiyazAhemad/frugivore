import 'dart:core';

import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future changeEmail(data) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(Uri.parse("${url}change-email"),
          headers: <String, String>{'Authorization': 'JWT $token'},
          body: data);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
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
