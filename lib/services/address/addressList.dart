import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/address/addressList.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<AddressListModel> fetchAddressList() async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.get(
        Uri.parse('${url}address-list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        AddressListModel data = AddressListModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future deleteAddress(String uuid) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.get(
        Uri.parse('${url}delete-address/$uuid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
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

  static Future makeDeliverHere(String pk) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(
          Uri.parse('${url}change-deliver-here-address'),
          headers: <String, String>{'Authorization': 'JWT $token'},
          body: {"pk": pk});
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

  static Future makeOrderDeliveryHere(String pk, String orderId) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(
          Uri.parse('${url}change-delivery-address/$orderId'),
          headers: <String, String>{'Authorization': 'JWT $token'},
          body: {"pk": pk});
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
