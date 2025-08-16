import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';

import 'package:frugivore/controllers/welcome.dart';

import 'package:frugivore/connectivity.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomConditionalBottomBar(
            controller: controller),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: NetworkSensitive(
                child: Container(
                    color: bodyColor,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: "Registration Successfull",
                                      search: false),
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
                                                    Image.asset(
                                                        "assets/images/welcome.jpeg"),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        controller.data.message ?? "",
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  customElevatedButton(
                                                                      pinkColor,
                                                                      whiteColor),
                                                              onPressed: () =>
                                                                  Navigator
                                                                      .pushReplacementNamed(
                                                                          context,
                                                                          "/"),
                                                              child:
                                                                  Text("Shop"),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  customElevatedButton(
                                                                      pinkColor,
                                                                      whiteColor),
                                                              onPressed: () =>
                                                                  Navigator.pushNamed(
                                                                          context,
                                                                          '/cart')
                                                                      .then(
                                                                          (_) {
                                                                controller
                                                                    .apicall();
                                                              }),
                                                              child: Text(
                                                                  "Go to Cart"),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ])))),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class SignupCodePopUp extends StatelessWidget {
  const SignupCodePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    return AlertDialog(
      titlePadding: EdgeInsets.all(5),
        title: IconButton(
          alignment: Alignment.bottomLeft,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.cancel_outlined, size: 40, color: backgroundGrey),
        ),
        insetPadding: EdgeInsets.all(0),
        content: Obx(
          () => Center(
              child: NetworkSensitive(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: 80,
                                  child: Image.asset("assets/images/logo.png",
                                      fit: BoxFit.contain)),
                              SizedBox(height: 20),
                              Text("Do you have Sign up Code ?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 20),
                              if (controller.havingSignupCode.value)
                                Column(
                                  children: [
                                    Container(
                                        decoration: boxDecoration,
                                        padding: EdgeInsets.all(10),
                                        child: TextField(
                                          controller:
                                              controller.signupCodeValue,
                                          obscureText: false,
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          onSubmitted: (text) => controller
                                              .submitSignupCodeMethod(),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "SIGN UP CODE",
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: customNonSlimmerElevatedButton(
                                            pinkColor, whiteColor),
                                        onPressed: () =>
                                            controller.submitSignupCodeMethod(),
                                        child: Text("SUBMIT"),
                                      ),
                                    )
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                      style: customNonSlimmerElevatedButton(
                                          pinkColor, whiteColor),
                                      child: Text("Yes"),
                                      onPressed: () =>
                                          controller.havingSignupCode(true),
                                    )),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: ElevatedButton(
                                      style: customNonSlimmerElevatedButton(
                                          backgroundGrey, whiteColor),
                                      child: Text("No"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ))
                                  ],
                                )
                            ],
                          ),
                        ),
                      )))),
        ));
  }
}
