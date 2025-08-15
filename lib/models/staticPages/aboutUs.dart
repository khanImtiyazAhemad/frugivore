// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
    AboutUsModel({
        this.data,
        this.title,
    });

    Data? data;
    String? title;

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        data: Data.fromJson(json["data"]),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "title": title,
    };
}

class Data {
    Data({
        this.image,
        this.content,
    });

    String? image;
    String? content;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        image: json["image"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "content": content,
    };
}
