import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/utils.dart';
import 'package:frugivore/auth.dart';
import 'package:frugivore/notification.dart';
import 'package:frugivore/widgets/custom.dart';

class AuthController extends GetxController with CodeAutoFill {
  @override
  String? code = "";
  var appSignature = "".obs;
  String devicetoken = "Dummy Testing";
  final _authStatus = 'Unknown'.obs;
  var isLoader = true.obs;
  var ticker = 30.obs;
  var resendOTP = false.obs;
  String? mobile;
  String? uuid;
  FocusNode? otp1FocusNode, otp2FocusNode, otp3FocusNode, otp4FocusNode;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController otpText = TextEditingController();
  InputDecoration decoration = InputDecoration(
      counterText: "",
      contentPadding: EdgeInsets.all(10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: primaryColor)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)));

  void submitOTP() async {
    String otp = otpText.text;
    if (otp.length != 4) {
      globals.toast("Please enter OTP. OTP should not be less than 4 digits");
    } else {
      isLoader(true);
      AuthServices.submitOtp(mobile, otp, devicetoken).then((response) async {
        isLoader(false);
        if (response.containsKey('error')) {
          globals.toast(response['error']);
        } else if (response.containsKey('message')) {
          globals.toast(response['message']);
        } else {
          // Get.reset();
          globals.payload['uuid'] = response['data']['uuid'];
          globals.payload['email'] = response['data']['email'];
          globals.payload['phone'] = response['data']['phone'];
          globals.payload['avatar'] = response['data']['avatar'];
          globals.payload['name'] = response['data']['name'];
          globals.payload['gender'] = response['data']['gender'];
          globals.payload['date_of_birth'] = response['data']['date_of_birth'] ?? "";

          globals.payload['alternate_phone'] =
              response['data']['alternate_phone'] ?? "" ;
          globals.payload['token'] = response['data']['token'];
          globals.payload['referral_code'] = response['data']['referral_code'];
          globals.payload['address'] = response['data']['address'];
          await AuthServices.setToken(response['data']['token']);
          globals.payload['cart'] = response['data']['cart'].toString();
          globals.payload['notification'] =
              response['data']['notification'].toString();
          globals.payload.refresh();
          AppInitialization().setInitialData();
          if (response.containsKey('fresh') && response['fresh']) {
            Navigator.pushNamedAndRemoveUntil(
                Get.context!, '/welcome', (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                Get.context!, '/', (route) => false);
            // Navigator.pushNamedAndRemoveUntil(Get.context!, "/", (Route<dynamic> route) => false);

          }
        }
      }).catchError((onError) {
        isLoader(false);
        globals.toast(onError.toString());
      });
    }
  }

  void tickerRunning() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      ticker(ticker.value - 1);
      if (ticker.value <= 0) {
        timer.cancel();
        resendOTP(true);
      }
    });
  }

  void resendOtp() {
    AuthServices.resendOtp(uuid!).then((response) {
      globals.toast("OTP resend on : +91 $mobile", color: primaryColor);
      ticker(30);
      resendOTP(false);
      tickerRunning();
    }).catchError((error) {});
  }

  @override
  void codeUpdated() {
  }

  @override
  void onInit() async {
    super.onInit();
    listenForCode();
    mobile = Get.parameters['mobile'];
    uuid = Get.parameters['uuid'];

    tickerRunning();
    otp1FocusNode = FocusNode();
    otp2FocusNode = FocusNode();
    otp3FocusNode = FocusNode();
    otp4FocusNode = FocusNode();
    PushNotificationsManager().init().then((_) {
      devicetoken = PushNotificationsManager.token!;
    });
    if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
    }
    final signature = await SmsAutoFill().getAppSignature;
    appSignature(signature);
    isLoader(false);
  }

  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      _authStatus('$status');
      if (status == TrackingStatus.notDetermined) {
        // if (await showCustomTrackingDialog(Get.context!)) {
        //   await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        _authStatus('$status');
        // }
      }
    } on PlatformException {
      _authStatus('PlatformException was thrown');
    }
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("I'll decide later"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Allow tracking'),
            ),
          ],
        ),
      ) ??
      false;


  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
}
