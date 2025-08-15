import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/theme.dart';
import 'package:frugivore/controllers/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/connectivity.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthPage extends StatelessWidget {
  static final GetStorage box = GetStorage();

  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final submitOtpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20),
      color: primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: controller.style.copyWith(color: Colors.white)),
        onPressed: () => controller.submitOTP(),
      ),
    );
    String otpBanner = box.read('otpBanner');
    return Scaffold(
        appBar: AppBar(elevation: 1, backgroundColor: whiteColor),
        body: Center(
            child: Obx(() => controller.isLoader.value
                ? Loader()
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: NetworkSensitive(
                        child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    otpBanner != ""
                                        ? CachedNetworkImage(
                                            imageUrl: otpBanner)
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "https://frugivore-bucket.s3.amazonaws.com/media/banner/2023-06-23/mango_banner_mobile.jpg"),
                                    GestureDetector(
                                      child: Padding(
                                        padding: p10,
                                        child: FaIcon(
                                            getIconFromCss('fat fa-arrow-left'),
                                            color: Colors.black,
                                            size: 30),
                                      ),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: plr10,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30),
                                        GestureDetector(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text:
                                                        "Enter the 4 digit code sent to +91-${controller.mobile} or on registered Email",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'FilsonProRegular'),
                                                  ),
                                                  TextSpan(
                                                      text: ' Edit',
                                                      style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                ])),
                                            onTap: () => Get.back()),
                                        SizedBox(height: 30),
                                        PinFieldAutoFill(
                                          cursor: Cursor(
                                            width: 1,
                                            height: 30,
                                            color: primaryColor,
                                            enabled: true,
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: controller.otpText,
                                          currentCode: controller.code,
                                          decoration: UnderlineDecoration(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            colorBuilder: FixedColorBuilder(
                                                Colors.black.withValues(alpha: 0.3)),
                                          ),
                                          autoFocus: true,
                                          codeLength: 4,
                                          onCodeSubmitted: (code) {
                                            if (code.length == 4) {
                                              controller.submitOTP();
                                            }
                                          },
                                          onCodeChanged: (code) {
                                            if (code!.length == 4) {
                                              controller.submitOTP();
                                            }
                                            controller.code = code;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        submitOtpButton,
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: controller
                                                        .resendOTP.value
                                                    ? GestureDetector(
                                                        child: Text(
                                                            "Resend OTP in",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    primaryColor)),
                                                        onTap: () => controller
                                                            .resendOtp(),
                                                      )
                                                    : Text("Resend OTP in",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: darkGrey))),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                    controller.ticker.value >=
                                                            10
                                                        ? "00:${controller.ticker.value}"
                                                        : "00:0${controller.ticker.value}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 14))),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      " Having trouble logging in? ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'FilsonProRegular')),
                                              TextSpan(
                                                  text: " Get help ",
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/get-help"),
                                                  style: TextStyle(
                                                      color: Color(0xff7e906f),
                                                      fontFamily:
                                                          'FilsonProRegular')),
                                            ])),
                                        SizedBox(height: 20),
                                        ThemeStrip()
                                      ]),
                                ),
                              ],
                            )))))));
  }
}
