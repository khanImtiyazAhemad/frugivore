// To parse this JSON data, do
//
//     final referEarnModel = referEarnModelFromJson(jsonString);

import 'dart:convert';

ReferEarnModel referEarnModelFromJson(String str) => ReferEarnModel.fromJson(json.decode(str));

String referEarnModelToJson(ReferEarnModel data) => json.encode(data.toJson());

class ReferEarnModel {
    ReferEarnModel({
        this.data,
        this.banner,
        this.referrals,
    });

    Data? data;
    List<Banner>? banner;
    List<String>? referrals;

    factory ReferEarnModel.fromJson(Map<String, dynamic> json) => ReferEarnModel(
        data: Data.fromJson(json["data"]),
        banner: List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
        referrals: List<String>.from(json["referrals"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "banner": List<dynamic>.from(banner!.map((x) => x.toJson())),
        "referrals": List<dynamic>.from(referrals!.map((x) => x)),
    };
}

class Banner {
    Banner({
        this.image,
    });

    String? image;

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}

class Data {
    Data({
        this.content,
    });

    String? content;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
    };
}
