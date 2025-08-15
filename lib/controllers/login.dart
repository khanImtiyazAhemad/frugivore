import 'package:frugivore/models/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:get_storage/get_storage.dart';

import 'package:frugivore/regex.dart' as regex;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/services/login.dart';

class LoginController extends GetxController {
  var isLoader = true.obs;
  static final GetStorage box = GetStorage();
  var appSignature = "".obs;
  String? referrerCode;
  String? referredCode;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _banner = LoginBannerModel().obs;
  LoginBannerModel get banner => _banner.value;
  set banner(value) => _banner.value = value;

  TextEditingController mobile = TextEditingController();
  TextEditingController referralCode = TextEditingController();

  InputDecoration decoration = InputDecoration(
      counterText: "",
      contentPadding: EdgeInsets.all(10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: primaryColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)));

  void getOTP() {
    if (mobile.text.trim() == '') {
      globals.toast("Please enter Mobile Number");
    } else if (mobile.text.trim() != '' && mobile.text.trim().length != 10) {
      globals.toast(
          "Mobile Number should not be less than or greater than 10 digits");
    } else if (!regex.mobileRegex.hasMatch(mobile.text.trim())) {
      globals.toast("Please enter valid Mobile Number");
    } else {
      Map data = {
        "mobile": mobile.text.trim(),
        'signature': appSignature.value
      };
      if (referrerCode != null) {
        data['referral_id'] = referrerCode;
      }
      if (referredCode != null) {
        data['referral_creation_code'] = referredCode;
      }
      Services.getOtp(data).then((response) async {
        await box.write('otpBanner', response.image);
        Navigator.pushNamed(
            Get.context!, "/auth/${response.mobile}/${response.uuid}");
      }).catchError((onError) {
        globals.toast(onError.toString());
      });
    }
  }

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.loginBanner();
      _banner.value = response;
      // _banner.value = response;
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.currentRoute.contains('/REFERRAL')) {
      referrerCode = Get.parameters['referrerCode'];
      referralCode.text = referrerCode!;
      referredCode = Get.parameters['referredCode'];
    }
    apicall();
    final signature = await SmsAutoFill().getAppSignature;
    appSignature(signature);
  }


}
