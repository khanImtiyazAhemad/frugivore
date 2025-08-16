import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';

import 'package:frugivore/controllers/whatsFree.dart';

import 'package:frugivore/connectivity.dart';

class WhatsFreePage extends StatelessWidget {
  const WhatsFreePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WhatsFreeController());
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
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      CustomTitleBar(
                                          title: "What's Free", search: false),
                                      Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Padding(
                                              padding: p10,
                                              child: Column(children: [
                                                SizedBox(height: 30),
                                                Text(
                                                    "50% off on your first order upto INR 200 will be credited in your Frugivore wallet upon the delivery of your first Order",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black)),
                                                SizedBox(height: 20),
                                                SizedBox(
                                                    height: 36,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ElevatedButton(
                                                        style:
                                                            customCircularElevatedButton(
                                                                primaryColor,
                                                                whiteColor),
                                                        onPressed: () =>
                                                            Navigator.pushNamed(
                                                                context, "/"),
                                                        child: Text("Shop Now"))),
                                                SizedBox(height: 20),
                                                Container(
                                                  alignment:
                                                      Alignment.center,
                                                  child: Text(
                                                      "Invite your friends to experience Frugivore",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black)),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                          FaIcon(
                                                              getIconFromCss(
                                                                  'fat fa-money-bill-wave'),
                                                              color:
                                                                  primaryColor,
                                                              size: 24),
                                                          SizedBox(width: 5),
                                                          Text("They get Rs 150",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black))
                                                        ])),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                          Text("You get Rs 150",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black)),
                                                          SizedBox(width: 5),
                                                          FaIcon(
                                                              getIconFromCss(
                                                                  'fat fa-money-bill-wave'),
                                                              color:
                                                                  primaryColor,
                                                              size: 24),
                                                        ]))
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                    height: 36,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ElevatedButton(
                                                        style:
                                                            customCircularElevatedButton(
                                                                primaryColor,
                                                                whiteColor),
                                                        onPressed: () =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/refer-earn"),
                                                        child: Text(
                                                            "Refer a Friend"))),
                                                SizedBox(height: 20),
                                                // Text(
                                                //     "Earn 5% cashback in your Frugivore wallet on every order purchase",
                                                //     textAlign: TextAlign.center,
                                                //     style: TextStyle(
                                                //       fontSize: 16,
                                                //       color: Colors.black,
                                                //     )),
                                                // SizedBox(height: 10),
                                                // controller
                                                //         .cashbackHideWhatsFreeContent
                                                //         .value
                                                //     ? SizedBox()
                                                //     : Column(
                                                //         crossAxisAlignment:
                                                //             CrossAxisAlignment
                                                //                 .start,
                                                //         children: [
                                                //           Text("Learn More",
                                                //               style: TextStyle(
                                                //                 fontSize: 16,
                                                //                 color: Colors
                                                //                     .black,
                                                //               )),
                                                //           SizedBox(height: 5),
                                                //           Text(
                                                //               "-- Cashback will not be awarded if any other offer is already applied on the order.",
                                                              
                                                //               style: TextStyle(
                                                //                 fontSize: 16,
                                                //                 color: Colors
                                                //                     .black,
                                                //               )),
                                                //           SizedBox(height: 10)
                                                //         ],
                                                //       ),
                                                // controller
                                                //         .cashbackHideWhatsFreeContent
                                                //         .value
                                                //     ? GestureDetector(
                                                //         child: Column(
                                                //           children: [
                                                //             Text("View More"),
                                                //             FaIcon(
                                                //                 getIconFromCss(
                                                //                     'fat fa-angle-down'),
                                                //                 color:
                                                //                     primaryColor,
                                                //                 size: 24),
                                                //           ],
                                                //         ),
                                                //         onTap: () => controller
                                                //             .cashbackHideWhatsFreeContent(
                                                //                 false),
                                                //       )
                                                //     : GestureDetector(
                                                //         child: Column(
                                                //           children: [
                                                //             Text("View Less"),
                                                //             FaIcon(
                                                //                 getIconFromCss(
                                                //                     'fat fa-angle-up'),
                                                //                 color:
                                                //                     primaryColor,
                                                //                 size: 24),
                                                //           ],
                                                //         ),
                                                //         onTap: () => controller
                                                //             .cashbackHideWhatsFreeContent(
                                                //                 true),
                                                //       ),
                                                // SizedBox(height: 10),
                                                // Container(
                                                //     height: 36,
                                                //     width:
                                                //         MediaQuery.of(context)
                                                //             .size
                                                //             .width,
                                                //     child: ElevatedButton(
                                                //         child: Text("Shop Now"),
                                                //         style:
                                                //             customCircularElevatedButton(
                                                //                 primaryColor,
                                                //                 whiteColor),
                                                //         onPressed: () =>
                                                //             Navigator.pushNamed(
                                                //                 context, "/"))),
                                                // SizedBox(height: 20),
                                                Text(
                                                    "Follow & Connect with us on Instagram. Rs 100 will be awarded for every story you mention us",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black)),
                                                SizedBox(height: 10),
                                                controller
                                                        .instagarmHideWhatsFreeContent
                                                        .value
                                                    ? SizedBox()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("T & C",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          SizedBox(height: 5),
                                                          Text(
                                                              "-- Stories should be featured from real & active accounts.",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          SizedBox(height: 5),
                                                          Text(
                                                              "-- Stories should not have abusive content and only feature relatable content from ordered items.",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          SizedBox(height: 5),
                                                          Text(
                                                              "-- Only one credit shall be awarded per week for any amount of stories uploaded.",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          SizedBox(height: 10)
                                                        ],
                                                      ),
                                                controller
                                                        .instagarmHideWhatsFreeContent
                                                        .value
                                                    ? GestureDetector(
                                                        child: Column(
                                                          children: [
                                                            Text("View More"),
                                                            FaIcon(
                                                                getIconFromCss(
                                                                    'fat fa-angle-down'),
                                                                color:
                                                                    primaryColor,
                                                                size: 24),
                                                          ],
                                                        ),
                                                        onTap: () => controller
                                                            .instagarmHideWhatsFreeContent(
                                                                false),
                                                      )
                                                    : GestureDetector(
                                                        child: Column(
                                                          children: [
                                                            Text("View Less"),
                                                            FaIcon(
                                                                getIconFromCss(
                                                                    'fat fa-angle-up'),
                                                                color:
                                                                    primaryColor,
                                                                size: 24),
                                                          ],
                                                        ),
                                                        onTap: () => controller
                                                            .instagarmHideWhatsFreeContent(
                                                                false),
                                                      ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                    height: 36,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ElevatedButton(
                                                        style:
                                                            customCircularElevatedButton(
                                                                primaryColor,
                                                                whiteColor),
                                                        onPressed: () => controller
                                                            .launchCustomUrl(
                                                                'https://instagram.com/frugivoreindia?igshid=MzRlODBiNWFlZA=='),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("Follow Us"),
                                                            SizedBox(width: 10),
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .instagram,
                                                                color:
                                                                    whiteColor,
                                                                size: 18)
                                                          ],
                                                        ))),
                                              ]))),
                                    ]));
                    })))));
  }
}
