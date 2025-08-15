import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/utils.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/models/orderOtp.dart';
import 'package:frugivore/services/orderOtp.dart';

import 'package:frugivore/screens/orderOtp.dart';

class OrderOTPController extends GetxController {
  var isLoader = true.obs;
  String? code;
  String? uuid;
  bool? wallet;
  var min = "15".obs;
  var sec = "00".obs;

  dynamic timer;

  final _data = OrderOtpModel().obs;
  OrderOtpModel get data => _data.value;
  set data(value) => _data.value = value;

  String? mobile;
  FocusNode? otp1FocusNode, otp2FocusNode, otp3FocusNode, otp4FocusNode;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController otpText = TextEditingController();
  InputDecoration decoration = InputDecoration(
      counterText: "",
      contentPadding: EdgeInsets.all(10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: primaryColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)));

  void tickerRunning(remainingTime) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      remainingTime -= 1000;
      int minValue = (remainingTime / (60 * 1000)).floor();
      min(minValue < 10 ? "0$minValue" : minValue.toString());

      int secValue = ((remainingTime - (minValue * 60 * 1000)) / 1000).floor();
      sec(secValue < 10 ? "0$secValue" : secValue.toString());

      if (remainingTime <= 1000) {
        timer.cancel();
        showDialog(
          context: Get.context!,
          builder: (_) => SessionTimeOutPopUp(),
          barrierDismissible: false,
        );
      }
    });
  }

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchOTP(uuid);
      if (response != null) {
        _data.value = response;
        tickerRunning(response.remainingTime);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    wallet = Get.arguments != null ? Get.arguments[0] : false;
    otp1FocusNode = FocusNode();
    otp2FocusNode = FocusNode();
    otp3FocusNode = FocusNode();
    otp4FocusNode = FocusNode();
    apicall(uuid);
    super.onInit();
  }

  void submitOTP() async {
    String otp = otpText.text;
    if (otp == "") {
      globals.toast("Please enter OTP");
    } else if (otp.length < 4) {
      globals.toast("Please enter complete OTP");
    } else {
      var response = await Services.submitOtp(uuid, otp, wallet);
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        timer.cancel();
        Navigator.of(Get.context!).pushNamedAndRemoveUntil(
            "/successfull/$uuid", (Route<dynamic> route) => false);
      }
    }
  }

  void repeatOrderReview() async {
    Get.close(1);
    isLoader(true);
    Services.repeatOrderReview(uuid).then((response) {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        timer.cancel();
        // Get.reset();
        cartRouting();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void cartRouting() async {
    // Get.reset();
    timer.cancel();
    CartRouting().routing();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
