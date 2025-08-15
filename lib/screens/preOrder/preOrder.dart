import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/controllers/preOrder/preOrder.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/connectivity.dart';


class PreOrderPage extends StatelessWidget {
  const PreOrderPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderController());
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
                              CustomTitleBar(title: "Cart", search: true),
                              Card(
                                  margin: plr10,
                                  shape: roundedCircularRadius,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(children: [
                                      Padding(
                                          padding: p10,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 20),
                                                Text(
                                                  "My Cart",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                    "Select an Order type to Checkout"),
                                              ])),
                                    ]),
                                  )),
                              SizedBox(height: 10),
                              StandardItemCard(),
                              SizedBox(height: 10),
                              PreOrderItemCard(),
                              SizedBox(height: 80)
                            ]));
                })))));
  }
}

class StandardItemCard extends StatelessWidget {
  const StandardItemCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderController());
    return Card(
      margin: plr10,
      shape: roundedCircularRadius,
      child: Column(
        children: [
          Padding(
            padding: p10,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child:
                              Image.asset("assets/images/standardOrder.png")),
                      VerticalDivider(
                        color: borderColor,
                        thickness: 1,
                        width: 5,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text("STANDARD ORDER",
                                        style: TextStyle(color: pinkColor)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${controller.data.remaingingItemsCount} Items",
                                        style: TextStyle(color: pinkColor)),
                                  )
                                ],
                              ),
                              Text(
                                  "Rs. ${controller.data.remainingOrderAmount}"),
                              Text("Expected Delivery: Tomorrow or Later"),
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: ptb10,
                  child: Text(
                      "NOTE: These items are available. They are delivered same day or next day of order. Pay now or choose CoD."),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor).copyWith(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
              onPressed: () => Navigator.pushNamed(context,"/cart").then((_){controller.apicall();}),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place Standard Order Now"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_outlined, size: 16)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PreOrderItemCard extends StatelessWidget {
  const PreOrderItemCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderController());
    return Card(
      margin: plr10,
      shape: roundedCircularRadius,
      child: Column(
        children: [
          Padding(
            padding: p10,
            child: Column(
              children: [
                IntrinsicHeight(
                    child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Image.asset("assets/images/preOrderCart.png")),
                  VerticalDivider(color: borderColor, thickness: 1, width: 5),
                  SizedBox(width: 5),
                  Expanded(
                      flex: 8,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text("PRE ORDER",
                                        style: TextStyle(color: pinkColor)),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          "${controller.data.preOrderItemsCount} Items",
                                          style: TextStyle(color: pinkColor)))
                                ]),
                            Text("Rs. ${controller.data.preOrderAmount}"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                      "Expected Delivery: ${controller.data.dateRange} Days"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      icon:
                                          Icon(Icons.delete, color: pinkColor),
                                      onPressed: () =>
                                          Navigator.pushNamed(context,"/pre-order-cart")),
                                )
                              ],
                            ),
                          ])),
                ])),
                Padding(
                  padding: ptb10,
                  child: Text(
                      "NOTE: These items are NOT in stock. These are arranged by us specifically for you, once you place a paid order."),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor).copyWith(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
              onPressed: () => Navigator.pushNamed(context,"/pre-order-cart"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place Pre-Order Now"),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_outlined, size: 16)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
