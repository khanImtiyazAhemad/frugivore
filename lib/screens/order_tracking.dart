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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:frugivore/connectivity.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTrackingController());
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomConditionalBottomBar(controller: controller),
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
                            title:
                                "Order Tracking - #${controller.data.invoiceNumber}",
                            subTitle: "${controller.data.orderStatus}"
                                .toUpperCase(),
                            search: false,
                          ),
                          controller.data.deliveryBoyName != null &&
                                  controller.data.deliveryBoyName!.isNotEmpty
                              ? Card(
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
                                                'fat fa-user-cowboy',
                                              ),
                                              color: whiteColor,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 10,
                                          child: Text(
                                            "I'm ${controller.data.deliveryBoyName}, your delivery partner",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            child: Container(
                                              padding: p10,
                                              decoration: BoxDecoration(
                                                color: yellowColor,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: FaIcon(
                                                getIconFromCss('fat fa-phone'),
                                                color: whiteColor,
                                                size: 26,
                                              ),
                                            ),
                                            onTap: () async {
                                              final phone = controller
                                                  .data
                                                  .deliveryBoyPhone; // or any number
                                              final Uri callUri = Uri(
                                                scheme: 'tel',
                                                path: phone,
                                              );

                                              if (await canLaunchUrl(callUri)) {
                                                await launchUrl(callUri);
                                              } else {
                                                // handle error
                                                debugPrint(
                                                  "Could not launch dialer",
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Card(
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
                                                'fat fa-user-cowboy',
                                              ),
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
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1,
                                            ),
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
                              child: Column(
                                children: [
                                  Row(
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
                                  Divider(color: borderColor),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FaIcon(
                                          getIconFromCss('fat fa-location-dot'),
                                          color: yellowColor,
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        flex: 12,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivery at Home",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "${controller.data.address}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                height: 1,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            controller.data.canChangeDateTime!
                                                ? GestureDetector(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Change Address",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            height: 1,
                                                            color: primaryColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        SizedBox(width: 10),
                                                        FaIcon(
                                                          getIconFromCss(
                                                            'fat fa-angle-right',
                                                          ),
                                                          color: primaryColor,
                                                          size: 14,
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () =>
                                                        Navigator.pushNamed(
                                                          context,
                                                          "/address-list",
                                                        ).then(
                                                          (value) => controller
                                                              .apicall(
                                                                controller.uuid,
                                                              ),
                                                        ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: p5,
                                    decoration: BoxDecoration(
                                      color: yellowColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "Now update your address effortlessly if you've ordered at an incorrect location",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: whiteColor,
                                        height: 1,
                                      ),
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
                              child: GestureDetector(
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
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  "/order-detail/${controller.data.orderId}",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            margin: plr10,
                            shape: roundedCircularRadius,
                            child: Padding(
                              padding: p10,
                              child: Column(
                                children: [
                                  Row(
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
                                              "Order ID: #${controller.data.invoiceNumber}",
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
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FaIcon(
                                          getIconFromCss('fat fa-memo-pad'),
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Items Total",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Rs.${controller.data.orderValue}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FaIcon(
                                          getIconFromCss('fat fa-bicycle'),
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Delivery Charge",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Rs.${controller.data.deliveryCharges}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 11,
                                        child: Text(
                                          "Grand Total",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Rs.${controller.data.totalPrice}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  Wrap(
                                    spacing: 8, // horizontal gap
                                    runSpacing: 8, // vertical gap
                                    children: controller.data.orderItems!
                                        .map<Widget>((obj) {
                                          return obj.image != null
                                              ? CachedNetworkImage(
                                                  imageUrl: obj.image!,
                                                  height: 60,
                                                )
                                              : Image.asset(
                                                  'assets/images/logo.png',
                                                  height: 60,
                                                );
                                        })
                                        .toList(),
                                  ),
                                  Divider(),
                                  GestureDetector(
                                    child: Text(
                                      "View Summary",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      "/order-detail/${controller.data.orderId}",
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
