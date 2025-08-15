// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.data,
    this.title,
  });

  List<Datum>? data;
  String? title;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "title": title,
      };
}

class Datum {
  Datum({
    this.id,
    this.tag,
    this.name,
  });

  int? id;
  List<Tag>? tag;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tag: List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": List<dynamic>.from(tag!.map((x) => x.toJson())),
        "name": name,
      };
}

class Tag {
  Tag({
    this.id,
    this.question,
    this.answer,
  });
  int? id;
  String? question;
  String? answer;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };
}
