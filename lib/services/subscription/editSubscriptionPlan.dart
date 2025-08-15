import 'dart:convert';

import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/auth.dart';
import 'package:frugivore/models/subscription/editSubscriptionPlan.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<EditSubscriptionPlanModel>? fetchDetail(String uuid) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse("${url}edit-subscription-plan/$uuid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
      EditSubscriptionPlanModel data =
          EditSubscriptionPlanModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future updateSubscriptionPlan(String? uuid, data) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.post(Uri.parse("${url}edit-subscription-plan/$uuid"),
          headers: <String, String>{'Authorization': 'JWT $token'},
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
