import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:frugivore/controllers/order_tracking.dart';

import 'package:frugivore/connectivity.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTrackingController());
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomConditionalBottomBar(),
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
                          OrderTrackingTitleBar(
                            title: "Order Tracking - FGV0001111",
                            subTitle: "Order placed",
                            search: false,
                          ),
                          Card(
                            margin: plr10,
                            shape: roundedCircularRadius,
                            child: Padding(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      color: yellowColor,
                                      child: FaIcon(
                                        getIconFromCss('fat fa-user-cowboy'),
                                        color: whiteColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "We'll assign a delivery partner as soon as your order is processed",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, height: 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            margin: plr10,
                            shape: roundedCircularRadius,
                            child: Padding(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      color: yellowColor,
                                      child: FaIcon(
                                        getIconFromCss('fat fa-moped'),
                                        color: whiteColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "You'r delivery details",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "Details of your current order",
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            margin: plr10,
                            shape: roundedCircularRadius,
                            child: Padding(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      color: yellowColor,
                                      child: FaIcon(
                                        getIconFromCss('fat fa-message'),
                                        color: whiteColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Need help with this order?",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "Chat with us about any issue related to your order",
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 1,
                                    child: FaIcon(
                                        getIconFromCss('fat fa-angle-right'),
                                        color: yellowColor,
                                        size: 32,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            margin: plr10,
                            shape: roundedCircularRadius,
                            child: Padding(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      color: yellowColor,
                                      child: FaIcon(
                                        getIconFromCss(
                                          'fat fa-basket-shopping',
                                        ),
                                        color: whiteColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order Summary",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "Order ID: #FGV000111",
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
