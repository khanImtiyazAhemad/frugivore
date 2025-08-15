import 'dart:core';
import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/wallet/wallet.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<WalletModel>? fetchWalletDetails() async {
    final token = await AuthServices.getToken();
    try {
      final response =
          await client.get(Uri.parse("${url}wallet"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT $token'
      });
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        WalletModel data = WalletModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
