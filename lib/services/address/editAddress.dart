import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/address/editAddress.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<EditAddressDetailModel>? fetchAddressDetail(String uuid) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.get(
        Uri.parse('${url}edit-address/$uuid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        EditAddressDetailModel data =
            EditAddressDetailModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future editAddress(String? uuid, data) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(Uri.parse('${url}edit-address/$uuid'),
          headers: <String, String>{'Authorization': 'JWT $token'},
          body: data);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        return jsonResponse;
      }else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
