import 'dart:io';
import 'dart:core';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/controllers/picker.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/models/help/subTopicDetail.dart';
import 'package:frugivore/services/help/subTopicDetail.dart';

class SubTopicDetailController extends GetxController {
  var isLoader = true.obs;
  var itemsContainer = false.obs;
  var subSubTopic = false.obs;
  var preference = "Select your Preference".obs;
  RxDouble totalSelectedItemPrice = 0.0.obs;
  int? ongoing, past = 0;
  String? uuid, orderId;
  List<String> orderItemsListing = [];

  List<String> selectedItem = [];
  List<Object> images = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController comment = TextEditingController();

  final _data = HelpSubTopicDetailModel().obs;
  HelpSubTopicDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  final _orderDataResponse = HelpOrderDetailModel().obs;
  HelpOrderDetailModel get orderDataResponse => _orderDataResponse.value;
  set orderDataResponse(value) => _orderDataResponse.value = value;

  Future<void> apicall(uuid) async {
    images = [];
    try {
      isLoader(true);
      var response = subSubTopic.value
          ? await Services.fetchHelpSubSubTopicDetail(uuid)
          : await Services.fetchHelpSubTopicDetail(uuid);
      if (response != null) {
        _data.value = response;
        if (response.commentAttachment!) {
          images.add("Add Images");
        }
      }
      var unreadResponse = await UtilsServices.unreadCount();
      ongoing = unreadResponse['on_going'];
      past = unreadResponse['past'];
    } finally {
    }
  }

  Future<void> orderData(orderId) async {
    try {
      itemsContainer(false);
      var response = await Services.fetchOrderDetail(orderId);
      if (response != null) {
        _orderDataResponse.value = response;
        for (OrderItem item in orderDataResponse.orderItems!) {
          orderItemsListing.add("${item.productName!} -- ${item.package!}");
        }
        if (data.orderDetail!) {
          data.content!.replaceAll("Delivery Boy Name: XXXXXX",
              "Delivery Boy Name: ${orderDataResponse.deliveryBoy}");
          data.content!.replaceAll("Delivery Boy Contact: xxxxxxxx",
              "Delivery Boy Contact: ${orderDataResponse.deliveryPhone}");
        }
      }
    } finally {
      itemsContainer(true);
    }
  }

  @override
  void onInit() async {
    uuid = Get.parameters['uuid'];
    subSubTopic(Get.arguments[0]);
    await apicall(uuid);
    if (Get.arguments.length == 2) {
      orderId = Get.arguments[1];
      if (orderId != null) await orderData(orderId);
    }
    isLoader(false);

    super.onInit();
  }

  void calculatePrice() {
    double sum = 0.0;
    images = [];
    for (String item in selectedItem) {
      images.add(item);
      String productName = item.split(" -- ")[0];
      for (OrderItem item in orderDataResponse.orderItems!) {
        if (productName == item.productName) {
          sum = sum + double.parse(item.cartPrice!);
        }
      }
    }
    totalSelectedItemPrice(sum);
  }

  Future onAddImageClick(int index) async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((file) {
      ImageUploadModel imageUpload = ImageUploadModel();
      imageUpload.isUploaded = false;
      imageUpload.uploading = false;
      imageUpload.imageFile = File(file!.path);
      imageUpload.imageUrl = file.path;
      imageUpload.productName = images[index].toString();
      images.replaceRange(index, index + 1, [imageUpload]);
      Get.close(1);
    });
  }

  void openCamera(int index) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    String currentRoute = Get.currentRoute;
    Navigator.push(
        Get.context!,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(
                camera: firstCamera,
                pageUrl: currentRoute,
                index: index,
                images: images)));
  }

  String detailsCreation() {
    String message =
        "${subSubTopic.value ? data.subSubTopic : data.subTopic} \n";
    for (String item in selectedItem) {
      message = "$message\n${selectedItem.indexOf(item) + 1}.$item";
    }
    if (totalSelectedItemPrice.value > 200) {
      message = "$message\n\nSelected Preference : ${preference.value}";
    }
    return message;
  }

  Future<void> submitRequest() async {
    List result = images.whereType<ImageUploadModel>().toList();
    if (selectedItem.length != result.length) {
      globals.toast("Please upload images for all the selected items");
    } else if (totalSelectedItemPrice.value > 200 &&
        preference.value == "Select your Preference") {
      globals.toast("Please select your preference");
    } else {
      isLoader(true);
      Map<String, String> payload = {
        "topic": subSubTopic.value ? data.subSubTopic ?? "" : data.subTopic ?? "",
        "details": detailsCreation(),
        "order_number": orderId != null ? orderId! : "",
      };
      if (data.commentSupport!) payload['comment'] = comment.text;
      var response =
          await Services.submitMultipleImagesComplaint(payload, images);
      if (response != null) {
        isLoader(false);
        resetData();
        Navigator.pushNamed(Get.context!, "/help-detail/${response['uuid']}");
      }
    }
  }

  void resetData() {
    preference("Select your Preference");
    totalSelectedItemPrice(0.0);
    selectedItem = [];
    images = [];
    comment.text = "";
  }

  void submitCommentSupportRequest() async {
    List result = images.whereType<ImageUploadModel>().toList();
    if (comment.text == "") {
      globals.toast("Please enter your issue");
    } else if (data.commentAttachment! && images.length != result.length) {
      globals.toast("Please upload images for all containers");
    } else {
      isLoader(true);
      Map<String, String> payload = {
        "topic": subSubTopic.value ? data.subSubTopic ?? "" : data.subTopic ?? "",
        "details": detailsCreation(),
        "comment": comment.text,
        "order_number": orderId != null ? orderId! : "",
      };
      var response =
          await Services.submitMultipleImagesComplaint(payload, images);
      if (response != null) {
        isLoader(false);
        resetData();
        Navigator.pushNamed(Get.context!, "/help-detail/${response['uuid']}");
      }
    }
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(uuid);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }

}
