import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/subscription/createSubscriptionPlan.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<CreateSubscriptionPlanModel>? fetchDetail(String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}subscription/$uuid"),
        headers: headers
      );
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
      CreateSubscriptionPlanModel data =
          CreateSubscriptionPlanModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future createSubscriptionPlan(String? uuid, data) async {
    Map<String, String>? headers = await utils.postHeaders();

    try {
      final response = await client.post(
          Uri.parse("${url}subscription-save-as-draft/$uuid"),
          headers: headers,
          body: data);
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
