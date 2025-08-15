// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';
import 'package:frugivore/models/utils.dart';

AddressListModel addressListModelFromJson(String str) =>
    AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) =>
    json.encode(data.toJson());

class AddressListModel {
  AddressListModel({
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
  List<Address>? results;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        page: json["page"],
        maxPage: json['max_page'],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Address>.from(json["results"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "max_page": maxPage,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}
