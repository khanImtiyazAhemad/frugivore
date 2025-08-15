// To parse this JSON data, do
//
//     final helpSubTopicsModel = helpSubTopicsModelFromJson(jsonString);

import 'dart:convert';

List<HelpSubTopicsModel> helpSubTopicsModelFromJson(String str) =>
    List<HelpSubTopicsModel>.from(
        json.decode(str).map((x) => HelpSubTopicsModel.fromJson(x)));

String helpSubTopicsModelToJson(List<HelpSubTopicsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpSubTopicsModel {
  HelpSubTopicsModel(
      {this.uuid,
      this.subTopic,
      this.content,
      this.subSubTopics,
      this.callSupport,
      this.chatSupport,
      this.itemsSupport,
      this.commentSupport,
      this.buttonSupport,
      this.buttonText,
      this.buttonRedirection});

  String? uuid;
  String? subTopic;
  String? content;
  bool? subSubTopics;
  bool? callSupport;
  bool? chatSupport;
  bool? itemsSupport;
  bool? commentSupport;
  bool? buttonSupport;
  String? buttonText;
  String? buttonRedirection;

  factory HelpSubTopicsModel.fromJson(Map<String, dynamic> json) =>
      HelpSubTopicsModel(
        uuid: json["uuid"],
        subTopic: json["sub_topic"],
        content: json["content"],
        subSubTopics:
            json["sub_sub_topics"],
        callSupport: json["call_support"],
        chatSupport: json["chat_support"],
        itemsSupport:
            json["items_support"],
        commentSupport:
            json["comment_support"],
        buttonSupport:
            json["button_support"],
        buttonText: json["button_text"],
        buttonRedirection: json["button_redirection"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "sub_topic": subTopic,
        "content": content,
        "sub_sub_topics": subSubTopics,
        "call_support": callSupport,
        "chat_support": chatSupport,
        "items_support": itemsSupport,
        "comment_support": commentSupport,
        "button_support": buttonSupport,
        "button_text": buttonText,
        "button_redirection":
            buttonRedirection,
      };
}
