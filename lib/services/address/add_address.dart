import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future addAddress(data) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(Uri.parse('${url}add-address'),
          headers: <String, String>{'Authorization': 'JWT $token'},
          body: data);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      }else if (response.statusCode == 400) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
