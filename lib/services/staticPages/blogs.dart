import 'dart:convert';
import 'package:frugivore/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:frugivore/models/staticPages/blogs.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<BlogsListModel>? fetchBlogs(name) async {
    try {
      final response = await client.get(
        Uri.parse("${url}blogs-list/$name"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonResponse = json.decode(response.body);
      BlogsListModel detail = BlogsListModel.fromJson(jsonResponse);
      return detail;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
