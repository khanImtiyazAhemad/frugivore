import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/controllers/orderOtp.dart';

import 'package:frugivore/connectivity.dart';

class OrderOtppage extends StatelessWidget {
  const OrderOtppage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderOTPController());

    final submitOtpButton = Material(
      borderRadius: BorderRadius.circular(5),
      color: pinkColor,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Text("Submit",
              textAlign: TextAlign.center,
              style:
                  controller.style.copyWith(color: Colors.white, fontSize: 16)),
          onPressed: () => controller.submitOTP()),
    );

    return PopScope(
        canPop: false,
        child: Scaffold(
            body: SafeArea(
          child: Container(
              color: bodyColor,
              width: MediaQuery.of(context).size.width,
              child: Obx(() {
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: NetworkSensitive(
                        child: controller.isLoader.value
                            ? Loader()
                            : Column(
                            children: [
                              CustomTitleBar(
                                  title: "ENTER OTP", search: false),
                              Card(
                                  margin: plr10,
                                  shape: roundedCircularRadius,
                                  child: Padding(
                                      padding: p10,
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${controller.min}:${controller.sec}",
                                                    style: TextStyle(
                                                        color: packageColor,
                                                        fontSize: 42)),
                                                SizedBox(height: 30),
                                                Text(
                                                  "We have sent an OTP on your registered Mobile Number",
                                                  textAlign:
                                                      TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16),
                                                ),
                                                SizedBox(height: 10),
                                                Divider(
                                                    color: Colors.black),
                                                SizedBox(height: 20),
                                                Text("Enter OTP",
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 20),
                                                PinFieldAutoFill(
                                                  cursor: Cursor(
                                                    width: 1,
                                                    height: 30,
                                                    color: primaryColor,
                                                    enabled: true,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      controller.otpText,
                                                  currentCode:
                                                      controller.code,
                                                  decoration:
                                                      UnderlineDecoration(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.black),
                                                    colorBuilder:
                                                        FixedColorBuilder(
                                                            Colors
                                                                .black
                                                                .withValues(alpha:0.3)),
                                                  ),
                                                  autoFocus: true,
                                                  codeLength: 4,
                                                  onCodeSubmitted: (code) {
                                                    if (code.length == 4) {
                                                      controller
                                                          .submitOTP();
                                                    }
                                                  },
                                                  onCodeChanged: (code) {
                                                    if (code!.length == 4) {
                                                      controller
                                                          .submitOTP();
                                                    }
                                                    controller.code = code;
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                Align(
                                                    alignment: Alignment
                                                        .centerRight,
                                                    child: GestureDetector(
                                                      child: Text(
                                                          "Resend OTP",
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                            color:
                                                                pinkColor,
                                                            fontSize: 16,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          )),
                                                      onTap: () =>
                                                          controller.apicall(
                                                              controller
                                                                  .uuid),
                                                    )),
                                                SizedBox(height: 20),
                                                submitOtpButton,
                                                SizedBox(height: 20),
                                              ])))),
                            ],
                                                          )));
              })),
        )));
  }
}

class SessionTimeOutPopUp extends StatelessWidget {
  const SessionTimeOutPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderOTPController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      title: Text("Session Time Out",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: primaryColor)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: ElevatedButton(
            style: customElevatedButton(backgroundGrey, Colors.black),
            onPressed: () => controller.repeatOrderReview(),
            child: Text("OK"),
          ),
        ),
      ),
    );
  }
}
