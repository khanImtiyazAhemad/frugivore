import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/controllers/login.dart';
import 'package:frugivore/widgets/theme.dart';

import 'package:frugivore/connectivity.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final mobileField = TextField(
      controller: controller.mobile,
      obscureText: false,
      autofocus: true,
      style: controller.style,
      keyboardType: TextInputType.number,
      onSubmitted: (text) => controller.getOTP(),
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      decoration: InputDecoration.collapsed(hintText: "Mobile Number"),
    );

    final getOtpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20),
      color: primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Text("CONTINUE",
            textAlign: TextAlign.center,
            style: controller.style.copyWith(color: Colors.white)),
        onPressed: () => controller.getOTP(),
      ),
    );

    return Scaffold(
      appBar: AppBar(elevation: 1, backgroundColor: whiteColor),
      body: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: NetworkSensitive(child: Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: controller.isLoader.value
                      ? Loader()
                      : Center(
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  controller.banner.image != ''
                                      ? CachedNetworkImage(
                                          imageUrl: controller.banner.image ?? "")
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "https://frugivore-bucket.s3.amazonaws.com/media/banner/2023-06-23/mango_banner_mobile.jpg"),
                                  GestureDetector(
                                    child: Padding(
                                      padding: p10,
                                      child: FaIcon(
                                          getIconFromCss('fat fa-circle-xmark'),
                                          color: Colors.black,
                                          size: 30),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                        height: 40,
                                        child: Image.asset(
                                            "assets/images/logo.png",
                                            fit: BoxFit.contain)),
                                    SizedBox(height: 20),
                                    Text("Login or SignUp",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 20),
                                    Container(
                                        decoration: loginBoxDecoration,
                                        padding:
                                            EdgeInsets.fromLTRB(5, 10, 5, 10),
                                        child: Row(children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "+91",
                                                style: TextStyle(fontSize: 18),
                                              )),
                                          Expanded(flex: 9, child: mobileField)
                                        ])),
                                    if (Get.currentRoute.contains('/REFERRAL'))
                                      Column(children: [
                                        SizedBox(height: 10),
                                        Container(
                                            padding: p10,
                                            decoration: boxDecoration.copyWith(
                                                color: bodyColor),
                                            child: TextField(
                                              controller:
                                                  controller.referralCode,
                                              style: controller.style,
                                              readOnly: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "REFERRAL CODE",
                                              ),
                                            ))
                                      ]),
                                    SizedBox(height: 20),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "By continuing, I agree to the ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'FilsonProRegular')),
                                      TextSpan(
                                          text: "Terms and Conditions ",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.pushNamed(
                                                context, "/terms-condition"),
                                          style: TextStyle(
                                              color: Color(0xff7e906f),
                                              fontFamily: 'FilsonProRegular')),
                                      TextSpan(
                                          text: "&",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'FilsonProRegular')),
                                      TextSpan(
                                          text: " Privacy Policy",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.pushNamed(
                                                context, "/privacy-policy"),
                                          style: TextStyle(
                                              color: Color(0xff7e906f),
                                              fontFamily: 'FilsonProRegular')),
                                    ])),
                                    SizedBox(height: 20),
                                    getOtpButton,
                                    SizedBox(height: 30),
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
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Navigator.pushNamed(
                                                        context, "/get-help"),
                                              style: TextStyle(
                                                  color: Color(0xff7e906f),
                                                  fontFamily:
                                                      'FilsonProRegular')),
                                        ])),
                                    SizedBox(height: 30),
                                    ThemeStrip()
                                    // GestureDetector(
                                    //   onTap: () => Navigator.pushNamed(context, "/"),
                                    //   child: Container(
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Text("Explore More >",
                                    //           textAlign: TextAlign.right,
                                    //           style:
                                    //               TextStyle(fontSize: 18, color: primaryColor))),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              })))),
    );
  }
}
