import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/controllers/payment.dart';

import 'package:frugivore/connectivity.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
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
                                : Column(
                                children: [
                                  CustomTitleBar(
                                      title: "Payment",
                                      search: false,
                                      bottom: true),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffa4b19a),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            bottomRight:
                                                Radius.circular(16))),
                                    width:
                                        MediaQuery.of(context).size.width *
                                            1,
                                    child: Padding(
                                      padding: p10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order will be delivered at:",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14, height: 1),
                                          ),
                                          Text(
                                            "${controller.data.deliveryAddress}",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14, height: 1),
                                          ),
                                          Text(
                                            "Delivered on : ${controller.data.deliveryDate}",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14, height: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Card(
                                      margin: plr10,
                                      color: whiteColor,
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
                                                    Text("Payment Time"),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        "${controller.min}:${controller.sec}",
                                                        style: TextStyle(
                                                            color:
                                                                primaryColor,
                                                            fontSize: 42,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                                  ])))),
                                  SizedBox(height: 10),
                                  Text(
                                    "Recharge your wallet to get more savings",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: plr10,
                                    child: ElevatedButton(
                                      style:
                                          rechargeNowCustomElevatedButton(
                                              pinkColor, whiteColor),
                                      onPressed: () => Navigator.pushNamed(
                                          context, "/recharge/''"),
                                      child: Text("RECHARGE NOW"),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Card(
                                      margin: plr10,
                                      color: whiteColor,
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
                                                    Row(children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              "Total Payable")),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Rs ${controller.data.subTotal}",
                                                            textAlign:
                                                                TextAlign
                                                                    .end,
                                                          )),
                                                    ]),
                                                    SizedBox(height: 10),
                                                    GestureDetector(
                                                      onTap: () => controller
                                                          .changeWallet(
                                                              controller
                                                                  .wallet
                                                                  .value),
                                                      child: Row(children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        24.0,
                                                                    width:
                                                                        24.0,
                                                                    child:
                                                                        Checkbox(
                                                                      checkColor:
                                                                          whiteColor,
                                                                      activeColor:
                                                                          pinkColor,
                                                                      value: controller
                                                                          .wallet
                                                                          .value,
                                                                      onChanged: (val) =>
                                                                          controller.changeWallet(val),
                                                                    )),
                                                                Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10),
                                                                    child: Text(
                                                                        "Use My Wallet Balance",
                                                                        style:
                                                                            TextStyle(color: Colors.black))),
                                                              ],
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                                "- Rs ${controller.walletAmount.value}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color:
                                                                        pinkColor))),
                                                      ]),
                                                    ),
                                                    if (controller.data
                                                            .discount !=
                                                        null)
                                                      GestureDetector(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            margin: ptb5,
                                                            padding: p5,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xfff0f6f8),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    controller.data.discount ==
                                                                            null
                                                                        ? Text("Promo Code Available")
                                                                        : Text("Promo Code Applied"),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        size:
                                                                            26)
                                                                  ],
                                                                ),
                                                                if (controller
                                                                        .data
                                                                        .discount !=
                                                                    null)
                                                                  Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: 5),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Padding(
                                                                            padding: p10,
                                                                            child: DottedBorder(
                                                                              child: Text(controller.data.discount!.code ?? "", textAlign: TextAlign.center),
                                                                            ),
                                                                          )),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            child: Text(
                                                                              "DISCOUNT -Rs ${controller.data.discountAmount}",
                                                                              textAlign: TextAlign.end,
                                                                              style: TextStyle(color: Colors.red, fontSize: 10),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height: 5)
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () => {}),
                                                    if (controller.data
                                                            .cashback !=
                                                        null)
                                                      GestureDetector(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            margin: ptb5,
                                                            padding: p5,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xfff8f0f0),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    controller.data.cashback ==
                                                                            null
                                                                        ? Text("Cashback Available")
                                                                        : Text("Cashback Applied"),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        size:
                                                                            26)
                                                                  ],
                                                                ),
                                                                if (controller
                                                                        .data
                                                                        .cashback !=
                                                                    null)
                                                                  Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: 5),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Padding(
                                                                                  padding: p10,
                                                                                  child: DottedBorder(
                                                                                    // color: Colors.black,
                                                                                    // strokeWidth: 2,
                                                                                    child: Text(controller.data.cashback!.code ?? "", textAlign: TextAlign.center),
                                                                                  ))),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            child: Text(
                                                                              "Rs ${controller.data.cashbackAmount}*",
                                                                              textAlign: TextAlign.end,
                                                                              style: TextStyle(color: Colors.red, fontSize: 10),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height: 5)
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () => {}),
                                                    SizedBox(height: 10),
                                                    Divider(
                                                        height: 1,
                                                        color:
                                                            Colors.black),
                                                    SizedBox(height: 15),
                                                    Row(children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              "Net Payable")),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              "Rs ${controller.netPayable.value}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .end)),
                                                    ]),
                                                    SizedBox(height: 5),
                                                    if (controller
                                                            .netPayable
                                                            .value ==
                                                        0)
                                                      SizedBox(
                                                        height:
                                                            buttonHeight,
                                                        width:
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                        child:
                                                            ElevatedButton(
                                                          style:
                                                              customElevatedButton(
                                                                  pinkColor,
                                                                  whiteColor),
                                                          onPressed: () =>
                                                              controller
                                                                  .placedWalletOrder(),
                                                          child: Text(
                                                              'Placed Order'),
                                                        ),
                                                      )
                                                  ])))),
                                  SizedBox(height: 10),
                                  Card(
                                      margin: plr10,
                                      color: whiteColor,
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                                padding:
                                                                    p10,
                                                                decoration:
                                                                    shapeDecoration,
                                                                child: TextField(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                    controller:
                                                                        controller
                                                                            .promocode,
                                                                    decoration:
                                                                        InputDecoration.collapsed(hintText: "Enter Coupon Code")))),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                SizedBox(
                                                              width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width,
                                                              child: ElevatedButton(
                                                                  style: customCircularElevatedButton(
                                                                      pinkColor,
                                                                      whiteColor),
                                                                  onPressed: () => controller.appliedDiscountCode(
                                                                      controller
                                                                          .uuid,
                                                                      controller
                                                                          .promocode
                                                                          .text),
                                                                  child: Text(
                                                                      "Apply")),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    controller.data.discountcode
                                                                    !.isNotEmpty ||
                                                            controller
                                                                    .data
                                                                    .cashbackcode
                                                                    !.isNotEmpty
                                                        ? Column(children: [
                                                            Row(children: [
                                                              Expanded(
                                                                  child: GestureDetector(
                                                                      child: Container(
                                                                        padding:
                                                                            p10,
                                                                        decoration: controller.selectedTab.value == "Exciting Offers"
                                                                            ? BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor)))
                                                                            : null,
                                                                        child:
                                                                            Text("Exciting Offers", textAlign: TextAlign.center),
                                                                      ),
                                                                      onTap: () => controller.selectedTab("Exciting Offers"))),
                                                              Expanded(
                                                                  child: GestureDetector(
                                                                      child: Container(
                                                                        padding:
                                                                            p10,
                                                                        decoration: controller.selectedTab.value == "Available Cashback"
                                                                            ? BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor)))
                                                                            : null,
                                                                        child:
                                                                            Text("Available Cashback", textAlign: TextAlign.center),
                                                                      ),
                                                                      onTap: () => controller.selectedTab("Available Cashback")))
                                                            ]),
                                                            SizedBox(
                                                                height: 10),
                                                            controller.selectedTab
                                                                        .value ==
                                                                    "Exciting Offers"
                                                                ? controller.data.discountcode!.isNotEmpty
                                                                    ? Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            controller.data.discountcode!.map<Widget>((item) {
                                                                          return Container(
                                                                            padding: ptb5,
                                                                            decoration: boxDecorationBottomBorder,
                                                                            child: Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 7,
                                                                                  child: Container(
                                                                                      padding: p5,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(item.code ?? "", style: TextStyle(fontSize: 14, color: controller.data.discount != null && controller.data.discount!.id == item.id ? pinkColor : null)),
                                                                                          if (item.description != "") Text(item.description ?? "", style: TextStyle(fontSize: 12, color: controller.data.discount != null && controller.data.discount!.id == item.id ? pinkColor : null))
                                                                                        ],
                                                                                      )),
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Expanded(
                                                                                  flex: 3,
                                                                                  child: controller.data.discount == null || controller.data.discount!.id == item.id
                                                                                      ? SizedBox()
                                                                                      : SizedBox(
                                                                                          width: MediaQuery.of(context).size.width,
                                                                                          child: ElevatedButton(style: customCircularElevatedButton(pinkColor, whiteColor), onPressed: () => controller.appliedDiscountCode(controller.uuid, item.code), child: Text("Apply")),
                                                                                        ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            p10,
                                                                        child:
                                                                            Text("Sorry there is no exciting offers available at this moment", textAlign: TextAlign.center),
                                                                      )
                                                                : controller.data.cashbackcode!.isNotEmpty
                                                                    ? Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            controller.data.cashbackcode!.map<Widget>((item) {
                                                                          return Container(
                                                                            padding: ptb5,
                                                                            decoration: boxDecorationBottomBorder,
                                                                            child: Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 7,
                                                                                  child: Container(
                                                                                    padding: p5,
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(item.code ?? "", style: TextStyle(fontSize: 14, color: controller.data.cashback != null && controller.data.cashback!.id == item.id ? pinkColor : null)),
                                                                                        if (item.description != "") Text(item.description ?? "", style: TextStyle(fontSize: 12, color: controller.data.cashback != null && controller.data.cashback!.id == item.id ? pinkColor : null))
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Expanded(
                                                                                  flex: 3,
                                                                                  child: controller.data.cashback != null && controller.data.cashback!.id != item.id ? Text("NOT APPLICABLE", style: TextStyle(color: Colors.red, fontSize: 12)) : SizedBox(),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            p10,
                                                                        child:
                                                                            Text("Sorry there is no cashback available at this moment", textAlign: TextAlign.center),
                                                                      )
                                                          ])
                                                        : SizedBox(),
                                                  ])))),
                                  SizedBox(height: 10),
                                  if (controller.netPayable.value != 0)
                                    Card(
                                      color: whiteColor,
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
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Choose Payment Option",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Column(
                                                          children: controller
                                                              .paymentOptions
                                                              .map((item) {
                                                        return Padding(
                                                          padding: pt10,
                                                          child:
                                                              PaymentOptionStrip(
                                                                  item:
                                                                      item),
                                                        );
                                                      }).toList())
                                                    ])))),
                                  SizedBox(height: 80),
                                ],
                                                                  ));
                      })))),
        ),
      ),
    );
  }
}

class PaymentOptionStrip extends StatelessWidget {
  final Map item;

  const PaymentOptionStrip({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return GestureDetector(
        child: Container(
          padding: ptb10,
          decoration: paymentboxDecorationWithBorder,
          child: Row(
            children: [
              Expanded(flex: 1, child: item['leading']),
              Expanded(
                  flex: 8,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child:
                          Text(item['title'], style: TextStyle(fontSize: 14)))),
              Expanded(
                  flex: 1,
                  child: Image.asset("assets/images/blackBackArrow.png",
                      height: 18)),
            ],
          ),
        ),
        onTap: () {
          if (item['razorpay']) {
            controller.createRazorPayOrder(item['value']);
          } else {
            controller.timer.cancel();
            // Navigator.pushNamed(context, '/order-otp/${controller.uuid}',
            //     arguments: [controller.wallet.value]);
            globals.payload['cart'] = "0";
            Navigator.pushNamed(context, '/successfull/${controller.uuid}');
          }
        });
  }
}

class CancelOrderPopUp extends StatelessWidget {
  const CancelOrderPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/exclamation.png", height: 60),
            SizedBox(height: 10),
            Text("Do you want to Cancel the Order?",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: customElevatedButton(pinkColor, whiteColor),
                    onPressed: () => controller.removeOrder(),
                    child: Text("YES"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: customElevatedButton(backgroundGrey, Colors.black),
                    onPressed: () => controller.repeatOrderReview(),
                    child: Text("NO"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SessionTimeOutPopUp extends StatelessWidget {
  const SessionTimeOutPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      title: Text("Session Time Out",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: primaryColor)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: ElevatedButton(
            style: customElevatedButton(backgroundGrey, Colors.black),
            onPressed: () => controller.repeatOrderReview(),
            child: Text("OK"),
          ),
        ),
      ),
    );
  }
}
