// To parse this JSON data, do
//
//     final helpSubSubTopicsModel = helpSubSubTopicsModelFromJson(jsonString);

import 'dart:convert';

List<HelpSubSubTopicsModel> helpSubSubTopicsModelFromJson(String str) =>
    List<HelpSubSubTopicsModel>.from(
        json.decode(str).map((x) => HelpSubSubTopicsModel.fromJson(x)));

String helpSubSubTopicsModelToJson(List<HelpSubSubTopicsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpSubSubTopicsModel {
  HelpSubSubTopicsModel(
      {this.uuid,
      this.subSubTopic,
      this.content,
      this.callSupport,
      this.chatSupport,
      this.itemsSupport,
      this.commentSupport,
      this.buttonSupport,
      this.buttonText,
      this.buttonRedirection});

  String? uuid;
  String? subSubTopic;
  String? content;
  bool? callSupport;
  bool? chatSupport;
  bool? itemsSupport;
  bool? commentSupport;
  bool? buttonSupport;
  String? buttonText;
  String? buttonRedirection;

  factory HelpSubSubTopicsModel.fromJson(Map<String, dynamic> json) =>
      HelpSubSubTopicsModel(
        uuid: json["uuid"],
        subSubTopic: json["sub_sub_topic"],
        content: json["content"],
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
        "sub_sub_topic": subSubTopic,
        "content": content,
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
