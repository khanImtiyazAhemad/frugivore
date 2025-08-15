// To parse this JSON data, do
//
//     final successfullDetailModel = successfullDetailModelFromJson(jsonString);

import 'dart:convert';

SuccessfullDetailModel successfullDetailModelFromJson(String str) => SuccessfullDetailModel.fromJson(json.decode(str));

String successfullDetailModelToJson(SuccessfullDetailModel data) => json.encode(data.toJson());

class SuccessfullDetailModel {
    SuccessfullDetailModel({
        this.result,
        this.cashbackMessage,
        this.cashbackSubmessage,
    });

    List<OrderItemDetail>? result;
    String? cashbackMessage;
    String? cashbackSubmessage;

    factory SuccessfullDetailModel.fromJson(Map<String, dynamic> json) => SuccessfullDetailModel(
        result: List<OrderItemDetail>.from(json["result"].map((x) => OrderItemDetail.fromJson(x))),
        cashbackMessage: json["cashback_message"],
        cashbackSubmessage: json["cashback_submessage"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "cashback_message": cashbackMessage,
        "cashback_submessage": cashbackSubmessage,
    };
}

class OrderItemDetail {
    OrderItemDetail({
        this.detail,
    });

    List<Detail>? detail;

    factory OrderItemDetail.fromJson(Map<String, dynamic> json) => OrderItemDetail(
        detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
    };
}

class Detail {
    Detail({
        this.text,
        this.value,
    });

    String? text;
    String? value;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        text: json["text"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
    };
}
