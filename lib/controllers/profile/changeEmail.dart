import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/regex.dart' as regex;
import 'package:frugivore/globals.dart' as globals;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/profile/changeEmail.dart';

class ChangeEmailController extends GetxController {
  var isLoader = true.obs;
  var confirmation = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController email =
      TextEditingController(text: "${globals.payload['email']}");

  void apicall() async {
    try {
      isLoader(true);
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    apicall();
    super.onInit();
  }

  void changeEmail() async {
    if (email.text.trim() == "") {
      globals.toast("Email can't be blank");
    } else if (!regex.emailRegex.hasMatch(email.text.trim())) {
      globals.toast("Please enter valid Email");
    } else if (globals.payload['email'] == email.text.trim()) {
      globals.toast("Email same as previous Email");
    } else {
      Map data = {"email": email.text};
      var response = await Services.changeEmail(data);
      if (response != null) {
        confirmation(true);
      }
    }
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
