import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/welcome.dart';
import 'package:frugivore/models/welcome.dart';
import 'package:frugivore/screens/welcome.dart';

class WelcomeController extends GetxController {
  var isLoader = true.obs;
  var signupCode = true.obs;
  var havingSignupCode = false.obs;
  TextEditingController signupCodeValue = TextEditingController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = WelcomeModel().obs;
  WelcomeModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchWelcomeDetails();
      if (response != null) {
        _data.value = response;
        if (response.type != null && signupCode.value) {
          showDialog(
            context: Get.context!,
            builder: (_) => SignupCodePopUp(),
            barrierDismissible: false,
          );
          signupCode(false);
        }
      }
    } finally {
      isLoader(false);
    }
  }

  void submitSignupCodeMethod() async {
    if (signupCodeValue.text.trim() == '') {
      globals.toast("Please enter Mobile Number");
    } else {
      Map data = {
        "signup_code": signupCodeValue.text.trim(),
      };
      var response = await Services.submitSignupCode(data);
      if (response != null) {
        _data.value = response;
        Get.close(1);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    apicall();
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
    apicall();
    refreshController.loadComplete();
  }
}
