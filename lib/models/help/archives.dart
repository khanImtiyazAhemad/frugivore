// To parse this JSON data, do
//
//     final archiveModel = archiveModelFromJson(jsonString);

import 'dart:convert';

ArchiveModel archiveModelFromJson(String str) => ArchiveModel.fromJson(json.decode(str));

String archiveModelToJson(ArchiveModel data) => json.encode(data.toJson());

class ArchiveModel {
    ArchiveModel({
        this.page,
        this.maxPage,
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? page;
    int? maxPage;
    int? count;
    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory ArchiveModel.fromJson(Map<String, dynamic> json) => ArchiveModel(
        page: json["page"],
        maxPage: json["max_page"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
  Result(
      {this.id,
      this.complaintId,
      this.dateOfComplaint,
      this.issueId,
      this.subject,
      this.issueStatus,
      this.counter,
      this.topic,
      this.unreadCount});

  int? id;
  String? complaintId;
  String? dateOfComplaint;
  String? issueId;
  String? subject;
  String? issueStatus;
  int? counter;
  String? topic;
  int? unreadCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        complaintId: json["complaint_id"],
        dateOfComplaint: json["date_of_complaint"],
        issueId: json["issue_id"],
        subject: json["subject"],
        issueStatus: json["issue_status"],
        counter: json["counter"],
        topic: json["topic"],
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "complaint_id": complaintId,
        "date_of_complaint": dateOfComplaint,
        "issue_id": issueId,
        "subject": subject,
        "issue_status": issueStatus,
        "counter": counter,
        "topic": topic,
        "unread_count": unreadCount,
      };
}
