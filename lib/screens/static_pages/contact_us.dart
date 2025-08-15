import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/controllers/staticPages/contactUs.dart';


import 'package:frugivore/connectivity.dart';


class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactUsController());
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
                            CustomTitleBar(title:"Contact Us", search: false),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Card(
                                      margin: plr10,
                                      shape: roundedCircularRadius,
                                      child: Padding(
                                          padding: p20,
                                          child: Column(children: [
                                            Image.asset(
                                                "assets/images/contactUs.jpeg"),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Icon(Icons.call),
                                                SizedBox(width: 10),
                                                Text("+91 844 844 8994",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.email),
                                                SizedBox(width: 10),
                                                Text("care@frugivore.in",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.shopping_bag),
                                                SizedBox(width: 10),
                                                Text(
                                                    "D-1 Panchwati, Adarsh Nagar,\nNew Delhi - 110033",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            ),
                                          ]))))
                            ]));
                })))));
  }
}
