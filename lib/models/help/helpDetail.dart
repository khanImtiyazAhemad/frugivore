// To parse this JSON data, do
//
//     final helpDetailModel = helpDetailModelFromJson(jsonString);

import 'dart:convert';

HelpDetailModel helpDetailModelFromJson(String str) => HelpDetailModel.fromJson(json.decode(str));

String helpDetailModelToJson(HelpDetailModel data) => json.encode(data.toJson());

class HelpDetailModel {
    HelpDetailModel({
        this.data,
        this.message,
    });

    Data? data;
    String? message;

    factory HelpDetailModel.fromJson(Map<String, dynamic> json) => HelpDetailModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.id,
        this.complaintId,
        this.dateOfComplaint,
        this.issueId,
        this.subject,
        this.issueStatus,
        this.image,
        this.complaints,
        this.topic,
    });

    int? id;
    String? complaintId;
    String? dateOfComplaint;
    String? issueId;
    String? subject;
    String? issueStatus;
    String? image;
    List<Complaint>? complaints;
    String? topic;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        complaintId: json["complaint_id"],
        dateOfComplaint: json["date_of_complaint"],
        issueId: json["issue_id"],
        subject: json["subject"],
        issueStatus: json["issue_status"],
        image: json["image"],
        complaints: json["complaints"] == null ? null : List<Complaint>.from(json["complaints"].map((x) => Complaint.fromJson(x))),
        topic: json["topic"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "complaint_id": complaintId,
        "date_of_complaint": dateOfComplaint,
        "issue_id": issueId,
        "subject": subject,
        "issue_status": issueStatus,
        "image": image,
        "complaints": complaints == null ? null : List<dynamic>.from(complaints!.map((x) => x.toJson())),
        "topic": topic,
    };
}

class Complaint {
    Complaint({
        this.message,
        this.attachment,
        this.createdAt,
        this.isSender,
    });

    String? message;
    dynamic attachment;
    String? createdAt;
    bool? isSender;

    factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        message: json["message"],
        attachment: json["attachment"],
        createdAt: json["created_at"],
        isSender: json["is_sender"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "attachment": attachment,
        "created_at": createdAt,
        "is_sender": isSender,
    };
}
