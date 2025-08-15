import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/controllers/staticPages/getHelp.dart';

import 'package:frugivore/connectivity.dart';

class GetHelpPage extends StatelessWidget {
  const GetHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetHelpController());

    return Scaffold(
        appBar: AppBar(
            iconTheme:
                IconThemeData(color: primaryColor //change your color here
                    ),
            elevation: 1,
            backgroundColor: whiteColor),
        body: Center(
            child: Obx(() => controller.isLoader.value
                ? Loader()
                : NetworkSensitive(
                    child: Center(
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: p10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("I don't remember my mobile number",
                                  style: TextStyle(fontSize: 24),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 30),
                              Text(
                                  "If you don’t remember your mobile number associated with your account at Frugivore, you may call us by pressing the “Call Now” button below to help you log back in.",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 30),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: customElevatedButton(
                                        pinkColor, whiteColor),
                                    onPressed: () => controller.launchCaller(),
                                    child: Text("Call Now")),
                              ),
                              SizedBox(height: 30),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: " Want to know more? ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'FilsonProRegular')),
                                    TextSpan(
                                        text: " Search FAQs ",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(
                                              context, "/faq"),
                                        style: TextStyle(
                                            color: Color(0xff7e906f),
                                            fontFamily: 'FilsonProRegular')),
                                  ])),
                            ],
                          ),
                        )),
                  )))));
  }
}
