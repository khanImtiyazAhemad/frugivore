// To parse this JSON data, do
//
//     final signUpRewardsModel = signUpRewardsModelFromJson(jsonString);

import 'dart:convert';

SignUpRewardsModel signUpRewardsModelFromJson(String str) => SignUpRewardsModel.fromJson(json.decode(str));

String signUpRewardsModelToJson(SignUpRewardsModel data) => json.encode(data.toJson());

class SignUpRewardsModel {
    SignUpRewardsModel({
        this.banner,
        this.content,
    });

    String? banner;
    String? content;

    factory SignUpRewardsModel.fromJson(Map<String, dynamic> json) => SignUpRewardsModel(
        banner: json["banner"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "banner": banner,
        "content": content,
    };
}
