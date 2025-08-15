import 'dart:convert';

import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/auth.dart';
import 'package:frugivore/models/wallet/addMoney.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<AddMoneyModel>? fetchDetail() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse("${url}add-money"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      AddMoneyModel data = AddMoneyModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<WalletOffersModel>>? fetchWalletOffers() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse("${url}wallet-offers"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      List<WalletOffersModel> list = parseList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<WalletOffersModel> parseList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<WalletOffersModel>((json) => WalletOffersModel.fromJson(json))
        .toList();
  }

  static Future walletRecharge(pay, code) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(Uri.parse("${url}pay-online?pay=$pay&code=$code"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
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
