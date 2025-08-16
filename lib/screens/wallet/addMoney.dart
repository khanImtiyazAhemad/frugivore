import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frugivore/controllers/wallet/addMoney.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/connectivity.dart';

class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoneyController());
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(
            controller: controller),
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
                                  CustomTitleBar(
                                      title: "Recharge your Wallet",
                                      search: false),
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                    Card(
                                        margin: plr10,
                                        shape: roundedCircularRadius,
                                        child: Padding(
                                            padding: p10,
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
                                                      Image.asset(
                                                          'assets/images/walletRecharge.jpg'),
                                                      SizedBox(height: 10),
                                                      Text(
                                                          "Your Current Balance : \u{20B9} ${controller.data.totalAmount}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  primaryColor)),
                                                    ])))),
                                    Card(
                                        margin: p10,
                                        shape: roundedCircularRadius,
                                        child: Padding(
                                            padding: p10,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                        "Top up your Account"),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              '\u{20B9}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      36,
                                                                  color:
                                                                      primaryColor)),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          flex: 9,
                                                          child: Container(
                                                              padding: p10,
                                                              decoration:
                                                                  shapeDecoration,
                                                              child: TextField(
                                                                  controller:
                                                                      controller
                                                                          .money,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration.collapsed(
                                                                          hintText: "Recharge your Wallet"))),
                                                        )
                                                      ],
                                                    )
                                                  ]),
                                            ))),
                                    SizedBox(height: 10),
                                    Padding(
                                        padding: plr10,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: GestureDetector(
                                              child: Container(
                                                  padding: p10,
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedAmount
                                                                .value ==
                                                            "1000"
                                                        ? primaryColor
                                                        : darkGrey,
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                  ),
                                                  child: Text(
                                                      '+ \u{20B9} 1000',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              whiteColor))),
                                              onTap: () => controller
                                                  .changeMoney('1000'),
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                                child: GestureDetector(
                                              child: Container(
                                                  padding: p10,
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedAmount
                                                                .value ==
                                                            "2000"
                                                        ? primaryColor
                                                        : darkGrey,
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                  ),
                                                  child: Text(
                                                      '+ \u{20B9} 2000',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              whiteColor))),
                                              onTap: () => controller
                                                  .changeMoney('2000'),
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                                child: GestureDetector(
                                              child: Container(
                                                  padding: p10,
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedAmount
                                                                .value ==
                                                            "3000"
                                                        ? primaryColor
                                                        : darkGrey,
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                  ),
                                                  child: Text(
                                                      '+ \u{20B9} 3000',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              whiteColor))),
                                              onTap: () => controller
                                                  .changeMoney('3000'),
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                                child: GestureDetector(
                                              child: Container(
                                                  padding: p10,
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedAmount
                                                                .value ==
                                                            "5000"
                                                        ? primaryColor
                                                        : darkGrey,
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                  ),
                                                  child: Text(
                                                      '+ \u{20B9} 5000',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              whiteColor))),
                                              onTap: () => controller
                                                  .changeMoney('5000'),
                                            ))
                                          ],
                                        )),
                                    if (controller.offers.isNotEmpty)
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TitleCard(
                                              title:
                                                  "Wallet Recharge Offers"),
                                          Padding(
                                              padding: plr10,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                      children: controller
                                                          .offers
                                                          .map<Widget>(
                                                              (item) {
                                                    return Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .40),
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        decoration: boxDecorationWithBorder.copyWith(
                                                            color:
                                                                whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CachedNetworkImage(
                                                                  imageUrl:
                                                                      item.banner!),
                                                              Container(
                                                                  color: controller.recommendedPromotion.value ==
                                                                          item
                                                                              .id
                                                                      ? primaryColor
                                                                      : darkGrey,
                                                                  width: MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      .25,
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(
                                                                          5),
                                                                      child: Text(
                                                                          "${item.code}",
                                                                          style: TextStyle(color: whiteColor)))),
                                                              if (item.description !=
                                                                      null ||
                                                                  item.description !=
                                                                      '')
                                                                Padding(
                                                                  padding:
                                                                      plbr10,
                                                                  child:
                                                                      Text(
                                                                    "${item.description}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            8),
                                                                  ),
                                                                ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    plbr10,
                                                                width: MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    .8,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: customElevatedButton(
                                                                      controller.recommendedPromotion.value == item.id
                                                                          ? primaryColor
                                                                          : darkGrey,
                                                                      whiteColor),
                                                                  child: Text(
                                                                      "Apply"),
                                                                  onPressed:
                                                                      () {
                                                                    controller.selectedAmount(item
                                                                        .amount
                                                                        .toString());
                                                                    controller.selectedCode(item.code);
                                                                    controller
                                                                        .money
                                                                        .text = item.amount.toString();
                                                                    controller
                                                                        .recommendedPromotion(item.id);
                                                                  },
                                                                ),
                                                              )
                                                            ]));
                                                  }).toList()))),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    Container(
                                      padding: p10,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      height: 60.0,
                                      child: ElevatedButton(
                                        style: customElevatedButton(
                                            pinkColor, whiteColor),
                                        child: Text("RECHARGE"),
                                        onPressed: () =>
                                            controller.addMoney(),
                                      ),
                                    )
                                  ]),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}
