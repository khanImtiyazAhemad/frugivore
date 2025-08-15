import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/controllers/successfull.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/models/successfull.dart';

import 'package:frugivore/connectivity.dart';

class SuccessfullPage extends StatelessWidget {
  const SuccessfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuccessfullController());
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      width: MediaQuery.of(context).size.width,
                      child: Obx(() {
                        return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: controller.isLoader.value
                                ? Loader()
                                : Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Column(children: [
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
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/confirmation.gif"),
                                                        if (controller
                                                                    .successfullPage
                                                                    .cashbackMessage !=
                                                                "" &&
                                                            controller
                                                                    .successfullPage
                                                                    .cashbackMessage !=
                                                                null)
                                                          Text(
                                                              controller
                                                                  .successfullPage
                                                                  .cashbackMessage ?? "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color:
                                                                      yellowColor,
                                                                  fontSize:
                                                                      12)),
                                                        if (controller
                                                                    .successfullPage
                                                                    .cashbackSubmessage !=
                                                                "" &&
                                                            controller
                                                                    .successfullPage
                                                                    .cashbackSubmessage !=
                                                                null)
                                                          Text(
                                                              controller
                                                                  .successfullPage
                                                                  .cashbackSubmessage ?? "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color:
                                                                      yellowColor,
                                                                  fontSize: 12,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                        GestureDetector(
                                                          child: Text(
                                                            "Like your Purchase ? Refer us to your friends and get Rs 150 in your wallet.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onTap: () => Navigator
                                                              .pushNamed(
                                                                  context,
                                                                  "/refer-earn"),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Column(
                                                          children: controller
                                                              .data
                                                              .map<Widget>(
                                                                  (item) {
                                                            return Details(
                                                                item: item);
                                                          }).toList(),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: customElevatedButton(
                                                                      yellowColor,
                                                                      Colors
                                                                          .black),
                                                                  onPressed: () => Navigator.of(
                                                                          context)
                                                                      .pushNamedAndRemoveUntil(
                                                                          "/",
                                                                          (Route<dynamic> route) =>
                                                                              false),
                                                                  child: Text(
                                                                      "HOME"),
                                                                )),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                                flex: 2,
                                                                child: ElevatedButton(
                                                                    style: customElevatedButton(
                                                                        yellowColor,
                                                                        Colors
                                                                            .black),
                                                                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                                                                        "/my-order",
                                                                        (Route<dynamic>
                                                                                route) =>
                                                                            false),
                                                                    child: Text(
                                                                        "MY ORDERS"))),
                                                          ],
                                                        ),
                                                        SizedBox(width: 10),
                                                        GestureDetector(
                                                          child: Text(
                                                            "Like your Purchase ? Refer us to your friends and get Rs 150 in your wallet.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onTap: () => Navigator
                                                              .pushNamed(
                                                                  context,
                                                                  "/refer-earn"),
                                                        )
                                                      ]))))
                                    ])));
                      }))))),
    );
  }
}

class Details extends StatelessWidget {
  final OrderItemDetail item;
  const Details({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          "---------- Shipment 1 Summary ----------",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        Column(
            children: item.detail!.map<Widget>((item) {
          return Row(children: [
            Expanded(flex: 2, child: Text(item.text!)),
            Expanded(
                flex: 2, child: Text(item.value!, textAlign: TextAlign.end))
          ]);
        }).toList()),
      ],
    );
  }
}
