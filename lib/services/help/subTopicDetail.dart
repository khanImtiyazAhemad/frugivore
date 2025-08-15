import 'dart:core';

import 'dart:convert';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/subTopicDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<HelpSubTopicDetailModel>? fetchHelpSubTopicDetail(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-subtopic-detail/$uuid"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      HelpSubTopicDetailModel data =
          HelpSubTopicDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<HelpSubTopicDetailModel> fetchHelpSubSubTopicDetail(
      uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-sub-subtopic-detail/$uuid"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      HelpSubTopicDetailModel data =
          HelpSubTopicDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<HelpOrderDetailModel>? fetchOrderDetail(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}help-order-detail/$uuid"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      HelpOrderDetailModel data = HelpOrderDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future submitComplaint(data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(Uri.parse("${url}submit-complaint"),
          headers: headers, body: data);
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

  static Future submitMultipleImagesComplaint(data, images) async {
    Map<String, String>? headers = await utils.multipartPostHeaders();
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse('${url}submit-complaint'));
      // if (images != null) {
      //   request.files.add(http.MultipartFile(
      //       'attachment', images.readAsBytes().asStream(), images.lengthSync(),
      //       filename:
      //           (DateTime.now().millisecondsSinceEpoch).toString() + ".png",
      //       contentType: MediaType('image', 'png')));
      // }

      List<http.MultipartFile> newList = [];
      for (int i = 0; i < images.length; i++) {
        // File imageFile = File(images[i].toString());
        // var stream =
        //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        // var length = await imageFile.length();
        // var multipartFile = new http.MultipartFile("imagefile", stream, length,
        //     filename: basename(imageFile.path));
        newList.add(http.MultipartFile(
            i.toString(),
            images[i].imageFile.readAsBytes().asStream(),
            images[i].imageFile.lengthSync(),
            filename: basename(images[i].imageFile.path)));
      }
      request.files.addAll(newList);
      request.fields.addAll(data);
      request.headers.addAll(headers);
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
}
