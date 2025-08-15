// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
    bool? allowSms;
    bool? allowEmail;
    bool? allowNotification;

    PrivacyModel({
        this.allowSms,
        this.allowEmail,
        this.allowNotification,
    });

    factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
        allowSms: json["allow_sms"],
        allowEmail: json["allow_email"],
        allowNotification: json["allow_notification"],
    );

    Map<String, dynamic> toJson() => {
        "allow_sms": allowSms,
        "allow_email": allowEmail,
        "allow_notification": allowNotification,
    };
}
