// To parse this JSON data, do
//
//     final helpSubTopicDetailModel = helpSubTopicDetailModelFromJson(jsonString);
import 'dart:io';
import 'dart:convert';

HelpSubTopicDetailModel helpSubTopicDetailModelFromJson(String str) =>
    HelpSubTopicDetailModel.fromJson(json.decode(str));

String helpSubTopicDetailModelToJson(HelpSubTopicDetailModel data) =>
    json.encode(data.toJson());

class HelpSubTopicDetailModel {
  HelpSubTopicDetailModel({
    this.uuid,
    this.subTopic,
    this.subSubTopic,
    this.content,
    this.callSupport,
    this.chatSupport,
    this.itemsSupport,
    this.commentSupport,
    this.buttonSupport,
    this.buttonText,
    this.buttonRedirection,
    this.commentAttachment,
    this.orderDetail,
  });

  String? uuid;
  String? subTopic;
  String? subSubTopic;
  String? content;
  bool? callSupport;
  bool? chatSupport;
  bool? itemsSupport;
  bool? commentSupport;
  bool? buttonSupport;
  String? buttonText;
  String? buttonRedirection;
  bool? commentAttachment;
  bool? orderDetail;

  factory HelpSubTopicDetailModel.fromJson(Map<String, dynamic> json) =>
      HelpSubTopicDetailModel(
        uuid: json["uuid"],
        subTopic: json["sub_topic"],
        subSubTopic:
            json["sub_sub_topic"],
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
        commentAttachment: json["comment_attachment"],
        orderDetail: json["order_detail"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "sub_topic": subTopic,
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
        "comment_attachment":
            commentAttachment,
        "order_detail": orderDetail,
      };
}

class ImageUploadModel {
  bool? isUploaded;
  bool? uploading;
  File? imageFile;
  String? imageUrl;
  String? productName;

  ImageUploadModel(
      {this.isUploaded,
      this.uploading,
      this.imageFile,
      this.imageUrl,
      this.productName});
}

HelpOrderDetailModel helpOrderDetailModelFromJson(String str) =>
    HelpOrderDetailModel.fromJson(json.decode(str));

String helpOrderDetailModelToJson(HelpOrderDetailModel data) =>
    json.encode(data.toJson());

class HelpOrderDetailModel {
  HelpOrderDetailModel({
    this.invoiceNumber,
    this.address,
    this.orderStatus,
    this.deliverySlot,
    this.orderId,
    this.deliveryDate,
    this.orderItems,
    this.dateRange,
    this.canChangeDateTime,
    this.dateRecords,
    this.deliveryBoy,
    this.deliveryPhone,
  });

  String? invoiceNumber;
  String? address;
  String? orderStatus;
  String? deliverySlot;
  String? orderId;
  String? deliveryDate;
  List<OrderItem>? orderItems;
  String? dateRange;
  bool? canChangeDateTime;
  List<DateRecord>? dateRecords;
  String? deliveryBoy;
  String? deliveryPhone;

  factory HelpOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      HelpOrderDetailModel(
        invoiceNumber:
            json["invoice_number"],
        address: json["address"],
        orderStatus: json["order_status"],
        deliverySlot:
            json["delivery_slot"],
        orderId: json["order_id"],
        deliveryDate:
            json["delivery_date"],
        orderItems: json["order_items"] == null
            ? null
            : List<OrderItem>.from(
                json["order_items"].map((x) => OrderItem.fromJson(x))),
        dateRange: json["date_range"],
        canChangeDateTime: json["can_change_date_time"],
        dateRecords: json["date_records"] == null
            ? null
            : List<DateRecord>.from(
                json["date_records"].map((x) => DateRecord.fromJson(x))),
        deliveryBoy: json["delivery_boy"],
        deliveryPhone:
            json["delivery_phone"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "address": address,
        "order_status": orderStatus,
        "delivery_slot": deliverySlot,
        "order_id": orderId,
        "delivery_date": deliveryDate,
        "order_items": orderItems == null
            ? null
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "date_range": dateRange,
        "can_change_date_time":
            canChangeDateTime,
        "date_records": dateRecords == null
            ? null
            : List<dynamic>.from(dateRecords!.map((x) => x.toJson())),
        "delivery_boy": deliveryBoy,
        "delivery_phone": deliveryPhone,
      };
}

class DateRecord {
  DateRecord({
    this.checked,
    this.valid,
    this.day,
    this.date,
    this.value,
    this.percentage,
    this.time,
  });

  bool? checked;
  bool? valid;
  String? day;
  String? date;
  String? value;
  String? percentage;
  List<Time>? time;

  factory DateRecord.fromJson(Map<String, dynamic> json) => DateRecord(
        checked: json["checked"],
        valid: json["valid"],
        day: json["day"],
        date: json["date"],
        value: json["value"],
        percentage: json["percentage"],
        time: json["time"] == null
            ? null
            : List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "checked": checked,
        "valid": valid,
        "day": day,
        "date": date,
        "value": value,
        "percentage": percentage,
        "time": time == null
            ? null
            : List<dynamic>.from(time!.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    this.text,
    this.id,
    this.disable,
    this.noPrefferedSlot,
    this.value,
  });

  String? text;
  int? id;
  bool? disable;
  bool? noPrefferedSlot;
  String? value;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        text: json["text"],
        id: json["id"],
        disable: json["disable"],
        noPrefferedSlot: json["no_preffered_slot"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "id": id,
        "disable": disable,
        "no_preffered_slot": noPrefferedSlot,
        "value": value,
      };
}

class OrderItem {
  OrderItem({
    this.extra,
    this.productName,
    this.quantity,
    this.package,
    this.brand,
    this.individualPrice,
    this.cartPrice,
    this.offerTitle,
    this.isDeleted,
    this.refundedQuantity,
    this.image,
    this.returnDueTo,
  });

  bool? extra;
  String? productName;
  int? quantity;
  String? package;
  String? brand;
  String? individualPrice;
  String? cartPrice;
  dynamic offerTitle;
  bool? isDeleted;
  int? refundedQuantity;
  String? image;
  dynamic returnDueTo;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        extra: json["extra"],
        productName: json["product_name"],
        quantity: json["quantity"],
        package: json["package"],
        brand: json["brand"],
        individualPrice:
            json["individual_price"],
        cartPrice: json["cart_price"],
        offerTitle: json["offer_title"],
        isDeleted: json["is_deleted"],
        refundedQuantity: json["refunded_quantity"],
        image: json["image"],
        returnDueTo: json["return_due_to"],
      );

  Map<String, dynamic> toJson() => {
        "extra": extra,
        "product_name": productName,
        "quantity": quantity,
        "package": package,
        "brand": brand,
        "individual_price": individualPrice,
        "cart_price": cartPrice,
        "offer_title": offerTitle,
        "is_deleted": isDeleted,
        "refunded_quantity": refundedQuantity,
        "image": image,
        "return_due_to": returnDueTo,
      };
}
