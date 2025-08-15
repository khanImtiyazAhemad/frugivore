import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/help/helpDetail.dart';
import 'package:frugivore/services/help/helpDetail.dart';

class HelpDetailController extends GetxController {
  var isLoader = true.obs;
  static String? uuid;

  ScrollController scrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController message = TextEditingController();
  TextEditingController reason = TextEditingController();

  File? image;

  final _data = HelpDetailModel().obs;
  HelpDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchHelpDetail(uuid);
      if (response != null) {
        _data.value = response;
        // Future.delayed(const Duration(seconds: 1), () async {
        //   //this is y - I think it's what you want
        //   if (scrollController.hasClients) {
        //     await scrollController.animateTo(
        //       0,
        //       curve: Curves.ease,
        //       duration: const Duration(milliseconds: 500),
        //     );
        //   }
        // });
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void sendMessage() async {
    if (message.text != "") {
      Map<String, String> data = {"message": message.text};
      var response = await Services.sendMessage(uuid, data);
      if (response != null) {
        message.text = "";
        apicall(uuid);
      }
    }
  }

  Future<void> sendAttachment(File? image) async {
    if (image != null) {
      Map<String, String> data = {"message": "Image Uploaded"};
      var response = await Services.sendMessage(uuid, data, attachment: image);
      if (response != null) {
        message.text = "";
        image = null;
        apicall(uuid);
      }
    }
  }

  void escalateIssue() async {
    if (reason.text == "") {
      globals.toast("Please enter the reason of Escalation");
    } else {
      Map data = {"reason": reason.text};
      var response = await Services.escalateIssue(uuid, data);
      if (response != null) {
        Get.close(1);
        apicall(uuid);
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
    apicall(uuid);
    refreshController.loadComplete();
  }
}
