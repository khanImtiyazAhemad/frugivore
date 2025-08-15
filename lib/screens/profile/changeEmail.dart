import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/controllers/profile/changeEmail.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/connectivity.dart';



class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeEmailController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: NetworkSensitive(
                child: Container(
                color: bodyColor,
                height : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: controller.isLoader.value
                          ? Loader()
                          : Column(children: [
                              CustomTitleBar(title: "Edit Email Address", search: false),
                              controller.confirmation.value
                                  ? ConfirmationContainer()
                                  : Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(children: [
                                    Card(
                                        margin: plr10,
                                        shape: roundedCircularRadius,
                                        child: Padding(
                                            padding: p20,
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding: p15,
                                                        decoration:
                                                            shapeDecoration,
                                                        child: TextField(
                                                          controller:
                                                              controller.email,
                                                          decoration:
                                                              InputDecoration
                                                                  .collapsed(
                                                                      hintText:
                                                                          "Change Email Address"),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      SizedBox(
                                                        height: 40,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ElevatedButton(
                                                          style: customElevatedButton(pinkColor, whiteColor),
                                                          onPressed: () =>
                                                              controller
                                                                  .changeEmail(),
                                                          child: Text(
                                                              "Change Email"),
                                                        ),
                                                      )
                                                    ])))),
                                  ])),
                              SizedBox(height: 80)
                            ]));
                })))));
  }
}

class ConfirmationContainer extends StatelessWidget {
  const ConfirmationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: plr10,
        shape: roundedCircularRadius,
        child: Padding(
            padding: p20,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "We have sent a verification link to your email please visit your inbox and click on a link to verify.", textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: customElevatedButton(pinkColor, whiteColor),
                          onPressed: () => Navigator.pushNamed(context,"/"),
                          child: Text("HOME"),
                        ),
                      )
                    ]))));
  }
}
