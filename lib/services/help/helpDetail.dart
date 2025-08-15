import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/auth.dart';
import 'package:frugivore/models/help/helpDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<HelpDetailModel>? fetchHelpDetail(String uuid) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.get(
        Uri.parse("${url}help-detail/$uuid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );
      final jsonResponse = json.decode(response.body);
      HelpDetailModel detail = HelpDetailModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future sendMessage(String? uuid, data, {attachment}) async {
    final token = await AuthServices.getToken();
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse('${url}complaint-message/$uuid'));
      if (attachment != null) {
        request.files.add(http.MultipartFile('attachment',
            attachment.readAsBytes().asStream(), attachment.lengthSync(),
            filename:
                "${DateTime.now().millisecondsSinceEpoch}.png",
            contentType: MediaType('image', 'png')));
      }

      request.fields.addAll(data);
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'JWT $token'
      });
      http.Response response =
          await http.Response.fromStream(await request.send());
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

  static Future escalateIssue(String? uuid, data) async {
    final token = await AuthServices.getToken();
    try {
      final response = await client.post(
          Uri.parse('${url}escalate-issue/$uuid'),
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
