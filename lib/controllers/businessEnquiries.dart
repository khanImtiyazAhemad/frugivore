import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/businessEnquiries.dart';

import 'package:frugivore/widgets/custom.dart';

class BusinessEnquiriesController extends GetxController {
  var isLoader = true.obs;

  static var defaultSubject = "Hotels".obs;
  final TextEditingController contact = TextEditingController();
  final TextEditingController message = TextEditingController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  static void changeSubjects(val) {
    if (BusinessEnquiriesController.defaultSubject.value != val) {
      BusinessEnquiriesController.defaultSubject(val);
    }
  }

  void submit() async {
    if (contact.text == "") {
      globals.toast("Please enter your Mobile Number/Email");
    } else if (message.text == "") {
      globals.toast("Please enter your message");
    } else {
      Map<String, String> data = {
        "contact": contact.text,
        "subject": defaultSubject.value,
        "message": message.text,
      };
      FocusManager.instance.primaryFocus?.unfocus();
      var response = await Services.submitQuery(data);
      if (response != null) {
        apicall();
        contact.text = "";
        message.text = "";
        defaultSubject.val("Hotels");
        globals.toast(
            "Your Business Enquiry is Submitted successfully! we'll get back to you very soon.",
            color: primaryColor);
      }
    }
  }

  void apicall() async {
    try {} finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    apicall();
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }

}
