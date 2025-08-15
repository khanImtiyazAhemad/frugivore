import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/auth.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future updateProfile(data, avatar) async {
    final token = await AuthServices.getToken();

    try {
      var request = http.MultipartRequest("POST", Uri.parse('${url}profile'));
      if (avatar != null) {
        request.files.add(http.MultipartFile(
            'avatar', avatar.readAsBytes().asStream(), avatar.lengthSync(),
            filename:
                "${DateTime.now().millisecondsSinceEpoch}.jpg",
            contentType: MediaType('image', 'jpg')));
      }

      request.fields.addAll(data);
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'JWT $token'
      });
      http.Response response =
          await http.Response.fromStream(await request.send());
      final jsonResponse = json.decode(response.body);
      globals.payload['uuid'] = jsonResponse['uuid'];
      globals.payload['email'] = jsonResponse['email'];
      globals.payload['phone'] = jsonResponse['phone'];
      globals.payload['avatar'] = jsonResponse['avatar'];
      globals.payload['name'] = jsonResponse['name'];
      globals.payload['gender'] = jsonResponse['gender'];
      globals.payload['date_of_birth'] = jsonResponse['date_of_birth'];
      globals.payload['alternate_phone'] = jsonResponse['alternate_phone'];
      globals.payload['referral_code'] = jsonResponse['referral_code'];
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
