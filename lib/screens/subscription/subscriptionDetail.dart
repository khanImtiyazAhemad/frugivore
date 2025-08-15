import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/subscription/subscriptionDetail.dart';
import 'package:frugivore/controllers/subscription/subscriptionDetail.dart';

import 'package:frugivore/connectivity.dart';

class SubscriptionDetailPage extends StatelessWidget {
  const SubscriptionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionDetailController());
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
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TitleCard(
                                                title: "Subscription Detail"),
                                            Card(
                                                shadowColor: Colors.transparent,
                                                margin: plr10,
                                                shape:
                                                    shapeRoundedRectangleBorderBLR,
                                                child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(children: [
                                                            Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              p10,
                                                                          decoration: controller.selectedTab.value == "Upcoming Occurance"
                                                                              ? BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor)))
                                                                              : null,
                                                                          child: Text(
                                                                              "Upcoming Occurance",
                                                                              textAlign: TextAlign.center),
                                                                        ),
                                                                        onTap: () =>
                                                                            controller.selectedTab("Upcoming Occurance"))),
                                                            Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              p10,
                                                                          decoration: controller.selectedTab.value == "Previous Occurance"
                                                                              ? BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor)))
                                                                              : null,
                                                                          child: Text(
                                                                              "Previous Occurance",
                                                                              textAlign: TextAlign.center),
                                                                        ),
                                                                        onTap: () =>
                                                                            controller.selectedTab("Previous Occurance")))
                                                          ]),
                                                          controller.selectedTab
                                                                      .value ==
                                                                  "Upcoming Occurance"
                                                              ? controller
                                                                      .data
                                                                      .upcomingOccurance!.isNotEmpty ? Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: controller
                                                                      .data
                                                                      .upcomingOccurance
                                                                      !.map<Widget>(
                                                                          (item) {
                                                                    return UpcomingOccuranceCard(
                                                                        item:
                                                                            item,
                                                                        index: controller.data.upcomingOccurance!.indexOf(item) +
                                                                            1);
                                                                  }).toList(),
                                                                ) : Padding(
                                                                      padding:
                                                                          p10,
                                                                      child: Text(
                                                                          "Sorry there is no occurrence at this Moment",
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                    )
                                                              : controller
                                                                          .data
                                                                          .previousOccurance
                                                                          !.isNotEmpty
                                                                  ? Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: controller
                                                                          .data
                                                                          .previousOccurance
                                                                          !.map<Widget>(
                                                                              (item) {
                                                                        return PreviousOccuranceCard(
                                                                            item:
                                                                                item,
                                                                            index:
                                                                                controller.data.previousOccurance!.indexOf(item) + 1);
                                                                      }).toList(),
                                                                    )
                                                                  : Padding(
                                                                      padding:
                                                                          p10,
                                                                      child: Text(
                                                                          "Sorry there is no occurrence at this Moment",
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                    )
                                                        ]))),
                                            SizedBox(height: 80)
                                          ]))
                                ]));
                    })))));
  }
}

class UpcomingOccuranceCard extends StatelessWidget {
  final UpcomingOccurance item;
  final int index;
  const UpcomingOccuranceCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionDetailController());
    return Obx(() => Column(
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                  border: Border(bottom: BorderSide(color: borderColor)),
                ),
                child: Padding(
                    padding: p10,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("$index. ${item.date}",
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                  Text(item.process!,
                                      style: TextStyle(
                                          fontSize: 12, color: darkGrey))
                                ])),
                        Expanded(
                          flex: 1,
                          child:
                              item.date == controller.upcomingSelectedCard.value
                                  ? Icon(Icons.remove)
                                  : Icon(Icons.add),
                        )
                      ],
                    )),
              ),
              onTap: () => controller.upcomingSelectedCard(item.date),
            ),
            Visibility(
              visible: item.date == controller.upcomingSelectedCard.value,
              child: Column(
                children: [
                  Padding(
                      padding: p20,
                      child:
                          Text(item.skipMessage!, textAlign: TextAlign.center)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor)
                          .copyWith(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero))),
                      child: Text(item.skipDateStatus!
                          ? "Skip this Occurance"
                          : "Resume this Occurance"),
                      onPressed: () => controller.skipDate(
                          item.skipDate, item.skipDateStatus! ? true : false),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class PreviousOccuranceCard extends StatelessWidget {
  final PreviousOccurance item;
  final int index;
  const PreviousOccuranceCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionDetailController());
    return Obx(() => Column(
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                  border: Border(bottom: BorderSide(color: borderColor)),
                ),
                child: Padding(
                    padding: p10,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("$index. ${item.date}",
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                  Text(item.process!,
                                      style: TextStyle(
                                          fontSize: 12, color: darkGrey))
                                ])),
                        Expanded(
                          flex: 1,
                          child:
                              item.date == controller.previousSelectedCard.value
                                  ? Icon(Icons.remove)
                                  : Icon(Icons.add),
                        )
                      ],
                    )),
              ),
              onTap: () => controller.previousSelectedCard(item.date),
            ),
            Visibility(
              visible: item.date == controller.previousSelectedCard.value,
              child: Column(
                children: [
                  if (item.placed!)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: p10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("# ${item.order!.invoiceNumber}",
                                    style: TextStyle(color: primaryColor)),
                                SizedBox(height: 10),
                                Row(children: [
                                  Expanded(child: Text("Sub Total")),
                                  Expanded(
                                      child: Text("Rs ${item.order!.orderValue}",
                                          textAlign: TextAlign.end))
                                ]),
                                Row(children: [
                                  Expanded(child: Text("Delivery Charges")),
                                  Expanded(
                                      child: Text(
                                          "Rs ${item.order!.deliveryCharges}",
                                          textAlign: TextAlign.end))
                                ]),
                                Row(children: [
                                  Expanded(
                                      child: Text("PAID by Frugivore Wallet")),
                                  Expanded(
                                      child: Text("- Rs ${item.order!.wallet}",
                                          textAlign: TextAlign.end))
                                ]),
                                Row(children: [
                                  Expanded(child: Text("Pending Amonut")),
                                  Expanded(
                                      child: Text("Rs Nil",
                                          textAlign: TextAlign.end))
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Expanded(
                                      child: Text("Current Money Balance")),
                                  Expanded(
                                      child: Text(
                                          "Rs ${item.order!.currentMoneyBalance}",
                                          textAlign: TextAlign.end))
                                ]),
                              ],
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style:
                                  customElevatedButton(pinkColor, whiteColor),
                              child: Text("Order Detail"),
                              onPressed: () => Navigator.pushNamed(context,
                                      '/order-detail/${item.order!.orderId}')
                                  .then((value) =>
                                      controller.apicall(controller.uuid))),
                        )
                      ],
                    )
                  else
                    Padding(
                        padding: p20,
                        child: Text(item.process!, textAlign: TextAlign.center)),
                ],
              ),
            )
          ],
        ));
  }
}
