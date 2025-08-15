import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/controllers/staticPages/privacyPolicy.dart';


import 'package:frugivore/connectivity.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child:  NetworkSensitive(
              child:Container(
                color: bodyColor,
                height : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: controller.isLoader.value
                          ? Loader()
                          : Column(children: [
                              CustomTitleBar(title: "Privacy Policy", search: false),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Padding(
                                              padding: p20,
                                              child: Html(
                                                  data: controller
                                                      .data.data!.content))),
                                                      SizedBox(height: 200)
                                    ],
                                  ))
                            ]));
                })))));
  }
}
