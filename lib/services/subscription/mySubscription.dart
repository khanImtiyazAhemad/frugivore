import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/models/subscription/mySubscription.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<MySubscriptionModel>? fetchSubscription() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse('${url}my-subscriptions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        MySubscriptionModel data = MySubscriptionModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<MySubscriptionModel>? loadMore(uri) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        MySubscriptionModel data = MySubscriptionModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
