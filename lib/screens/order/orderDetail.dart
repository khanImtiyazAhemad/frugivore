import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/order/orderDetail.dart';
import 'package:frugivore/controllers/order/orderDetail.dart';

import 'package:frugivore/connectivity.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
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
                                  CustomTitleBar(
                                      title:
                                          "Order Details - ${controller.data.invoiceNumber}",
                                      search: false),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -10.0, 0.0),
                                    color: whiteColor,
                                    child: Row(children: [
                                      Expanded(
                                          child: GestureDetector(
                                              child: Container(
                                                padding: p10,
                                                decoration: controller
                                                            .selectedTab
                                                            .value ==
                                                        "Summary"
                                                    ? BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    primaryColor)))
                                                    : null,
                                                child: Text("Summary",
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                              onTap: () => controller
                                                  .selectedTab("Summary"))),
                                      Expanded(
                                          child: GestureDetector(
                                              child: Container(
                                                padding: p10,
                                                decoration: controller
                                                            .selectedTab
                                                            .value ==
                                                        "Items"
                                                    ? BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    primaryColor)))
                                                    : null,
                                                child: Text("Items",
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                              onTap: () => controller
                                                  .selectedTab("Items")))
                                    ]),
                                  ),
                                  controller.selectedTab.value == "Summary"
                                      ? Padding(
                                          padding: plr10,
                                          child: Column(
                                            children: [
                                              OrderDeliverySlot(),
                                              SizedBox(height: 10),
                                              OrderAddressDetail(),
                                              SizedBox(height: 10),
                                              OrderInvoice(),
                                              SizedBox(height: 10),
                                              OrderHelpSubTopics()
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: plr10,
                                          child: OrderItemsContainer(
                                              items:
                                                  controller.data.orderItems!)),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class OrderHelpSubTopics extends StatelessWidget {
  const OrderHelpSubTopics({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Column(
      children: [
        Container(
            padding: p5,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffB3B6B7),
            child: Text("Got an issue?")),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.data.helpSubtopics!.map<Widget>((item) {
                return GestureDetector(
                  child: Container(
                    color: whiteColor,
                    padding: ptlr10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 7, child: Text(item.subTopic ?? "")),
                            Expanded(
                                flex: 1,
                                child: Image.asset(
                                    'assets/images/blackBackArrow.png',
                                    height: 12)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(height: 1, color: Colors.black)
                      ],
                    ),
                  ),
                  onTap: () => item.subSubTopics!
                      ? Navigator.pushNamed(
                          context, "/help-sub-subtopics/${item.uuid}",
                          arguments: [item.subTopic, controller.data.orderId])
                      : Navigator.pushNamed(
                          context, "/help-subtopic-detail/${item.uuid}",
                          arguments: [
                              item.subSubTopics,
                              controller.data.orderId
                            ]),
                );
              }).toList(),
            ))
      ],
    );
  }
}

class OrderDeliverySlot extends StatelessWidget {
  const OrderDeliverySlot({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Column(
      children: [
        Container(
            padding: p5,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffB3B6B7),
            child: Text("Delivery Slot")),
        Container(
          color: whiteColor,
          padding: p10,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Status: ${controller.data.orderStatus}",
                          style: TextStyle(fontSize: 12, height: 1)),
                      SizedBox(height: 5),
                      Text("Date: ${controller.data.deliveryDate}",
                          style: TextStyle(fontSize: 12, height: 1)),
                      SizedBox(height: 5),
                      Text("Time Slot: ${controller.data.deliverySlot}",
                          style: TextStyle(fontSize: 12, height: 1)),
                    ]),
              ),
              Expanded(
                flex: 3,
                child: controller.data.canChangeDateTime!
                    ? ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => ChangeDateTime(),
                        barrierDismissible: true,
                      ),
                      child: Text("Edit Delivery",
                          style: TextStyle(fontSize: 10)),
                    )
                    : SizedBox(height: 0),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OrderAddressDetail extends StatelessWidget {
  const OrderAddressDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Column(children: [
      Container(
          padding: p5,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffB3B6B7),
          child: Text("Address")),
      Container(
          padding: p10,
          color: whiteColor,
          child: Row(children: [
            Expanded(
                flex: 7,
                child: Text("Address: ${controller.data.address}",
                    maxLines: 5,
                    softWrap: true,
                    style: TextStyle(fontSize: 12, height: 1))),
            Expanded(
                flex: 3,
                child: controller.data.canChangeDateTime!
                    ? ElevatedButton(
                    style: customElevatedButton(pinkColor, whiteColor),
                    onPressed: () =>
                        Navigator.pushNamed(context, "/address-list").then(
                            (value) => controller.apicall(controller.uuid)),
                    child: Text("Edit Address",
                        style: TextStyle(fontSize: 10)),
                                          )
                    : SizedBox(height: 0)),
          ]))
    ]);
  }
}

class OrderInvoice extends StatelessWidget {
  const OrderInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Column(children: [
      Container(
          padding: p5,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffB3B6B7),
          child: Text("Invoice")),
      Container(
          padding: p10,
          color: whiteColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: controller.staticText("Sub Total")),
              Expanded(
                  child: controller.staticText(
                      "Rs. ${controller.data.orderValue}",
                      textAlign: TextAlign.end))
            ]),
            Row(children: [
              Expanded(child: controller.staticText("Delivery Charges")),
              Expanded(
                  child: controller.staticText(
                      "Rs. ${controller.data.deliveryCharges}",
                      textAlign: TextAlign.end))
            ]),
            Row(children: [
              Expanded(child: controller.staticText("CarryBag's Price")),
              Expanded(
                  child: controller.staticText(
                      "Rs. ${controller.data.carryBagPrice}",
                      textAlign: TextAlign.end))
            ]),
            if (controller.data.discountPromocodeAmount != null)
              Row(children: [
                Expanded(child: controller.staticText("Promo Discount")),
                Expanded(
                    child: controller.staticText(
                        "Rs. ${controller.data.discountPromocodeAmount}",
                        textAlign: TextAlign.end))
              ]),
            if (controller.data.wallet != null)
              Row(children: [
                Expanded(child: controller.staticText("Paid by Wallet")),
                Expanded(
                    child: controller.staticText(
                        "- Rs. ${controller.data.wallet}",
                        textAlign: TextAlign.end))
              ]),
            if (controller.data.statusOfPayment == "PAID" ||
                controller.data.statusOfPayment == "CANCELLED")
              Column(children: [
                Row(children: [
                  Expanded(
                      child: controller.staticText(
                          "Paid via ${controller.data.modeOfPayment}")),
                  Expanded(
                      child: controller.staticText(
                          "- Rs. ${controller.data.pendingAmount}",
                          textAlign: TextAlign.end))
                ]),
                Row(children: [
                  Expanded(child: controller.staticText("Pending Amount")),
                  Expanded(
                      child: controller.staticText("Rs. Nil",
                          textAlign: TextAlign.end))
                ]),
              ])
            else
              Row(children: [
                Expanded(child: controller.staticText("Pending Amount")),
                Expanded(
                    child: controller.staticText(
                        "Rs. ${controller.data.pendingAmount}",
                        textAlign: TextAlign.end))
              ]),
            if (controller.data.totalRefund != null)
              Column(children: [
                Row(children: [
                  Expanded(
                      child: controller.staticText(
                          "Refunded in Frugivore Wallet",
                          color: Colors.red)),
                  Expanded(
                      child: controller.staticText(
                          "- Rs. ${controller.data.totalRefund}",
                          color: Colors.red,
                          textAlign: TextAlign.end))
                ]),
                Row(children: [
                  Expanded(
                      child: controller.staticText("Available Refund to Bank",
                          color: Colors.red)),
                  Expanded(
                      child: controller.staticText(
                          "- Rs. ${controller.data.availableRefund ?? 0.0}",
                          color: Colors.red,
                          textAlign: TextAlign.end))
                ]),
                Row(children: [
                  Expanded(
                      child: controller.staticText(
                    "Refunded to Bank",
                  )),
                  Expanded(
                      child: controller.staticText(
                          "Rs. ${controller.data.refundedAmount ?? 0.00}",
                          textAlign: TextAlign.end))
                ])
              ]),
            if (controller.data.canDownloadInvoice!)
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  style: customElevatedButton(yellowColor, whiteColor),
                  onPressed: () => controller.downloadInvoice(),
                  child: Text("TAX INVOICE"),
                )
              ]),
            if (controller.data.payNow!)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  onPressed: () => controller.payNow(),
                  child: Text("PAY NOW"),
                ),
              )
            else if (controller.data.canClaimRefund!)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: customElevatedButton(skyBlueColor, whiteColor),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => RefundDetailPopUp(),
                    barrierDismissible: false,
                  ),
                  child: Text("CLAIM REFUND"),
                ),
              )
          ]))
    ]);
  }
}

class OrderItemsContainer extends StatelessWidget {
  final List<OrderItem> items;
  const OrderItemsContainer({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Column(
      children: [
        if (controller.data.canRepeatOrder!)
          Padding(
              padding: plbr10,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  style: customElevatedButton(primaryColor, whiteColor),
                  onPressed: () =>
                      controller.repeatOrder(controller.data.orderId),
                  child: Text("Repeat Order"),
                ),
              ])),
        Container(
          color: whiteColor,
          child: Column(
              children: items.map<Widget>((item) {
            return Column(
              children: [
                Container(
                  padding: p5,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xffB3B6B7),
                  child: Text(item.name!),
                ),
                Column(
                  children: item.items!.map<Widget>((obj) {
                    return OrderItemCard(item: obj);
                  }).toList(),
                )
              ],
            );
          }).toList()),
        ),
      ],
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final Item item;
  const OrderItemCard({super.key, required  this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border(top: BorderSide(color: borderColor))),
      padding: p10,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            flex: 3,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: item.image != null
                    ? CachedNetworkImage(imageUrl: item.image!)
                    : Image.asset('assets/images/logo.png')),
          ),
          Expanded(
              flex: 7,
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (item.offerTitle != null)
                        Text(item.brand!,
                            style: TextStyle(color: pinkColor, fontSize: 14)),
                      Text(item.brand!,
                          style: TextStyle(color: packageColor, fontSize: 12)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Text(item.productName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xff525252),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 10),
                      Container(
                          height: 28,
                          width: 50,
                          margin: EdgeInsets.only(right: 2, bottom: 2),
                          decoration: BoxDecoration(
                              border: Border.all(color: packageColor, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(item.package!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: packageColor)))),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Rs: ${item.cartPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Quantity: ${item.quantity}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      if (item.returnDueTo != null)
                        Text(
                          "${item.returnDueTo}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        )
                    ],
                  )))
        ]),
        // Image.asset(
        //     item.veg ? 'assets/images/veg.png' : 'assets/images/nonVeg.png',
        //     height: 10)
      ]),
    );
  }
}

class RefundDetailPopUp extends StatelessWidget {
  const RefundDetailPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: plr10,
        contentPadding: EdgeInsets.all(0),
        title: Container(
            padding: ptb20,
            color: whiteColor,
            child: Text("Refund Details",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              Container(
                padding: p15,
                decoration: BoxDecoration(
                    color: Color(0xffe2e2e2),
                    border: Border(bottom: BorderSide(color: whiteColor))),
                child: Row(children: [
                  Expanded(flex: 6, child: Text("Available Refund to Bank")),
                  Expanded(
                      flex: 3,
                      child: Text("Rs ${controller.data.availableRefund}")),
                  Expanded(
                      flex: 1, child: Icon(Icons.arrow_forward_ios, size: 14)),
                ]),
              ),
              Column(
                children:
                    controller.data.refundAvailableItem!.map<Widget>((item) {
                  return Container(
                    padding: p2,
                    decoration: boxDecorationBottomBorder,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: item.image != null
                                ? CachedNetworkImage(
                                    imageUrl: item.image ?? "", height: 30)
                                : Image.asset('assets/images/logo.png',
                                    height: 30)),
                        SizedBox(width: 5),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.offerTitle != null)
                                  Text("${item.offerTitle}",
                                      style: TextStyle(
                                          fontSize: 10, color: pinkColor)),
                                Text("${item.productName}",
                                    style: TextStyle(fontSize: 10))
                              ],
                            )),
                        SizedBox(width: 5),
                        Expanded(
                            flex: 2,
                            child: Text(
                                "Rs ${item.individualPrice} X ${item.refundedQuantity}",
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            flex: 2,
                            child: Text("Rs ${item.cartPrice}",
                                style: TextStyle(fontSize: 10))),
                      ],
                    ),
                  );
                }).toList(),
              ),
              if (controller.data.orderStatus == "Cancelled" ||
                  controller.data.orderStatus == "Rejected")
                Container(
                  padding: p2,
                  decoration: boxDecorationBottomBorder,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image.asset('assets/images/logo.png')),
                      SizedBox(width: 5),
                      Expanded(
                          flex: 5,
                          child: Text("Order ${controller.data.orderStatus}",
                              style: TextStyle(fontSize: 10))),
                      SizedBox(width: 5),
                      Expanded(flex: 2, child: Text("-")),
                      SizedBox(width: 5),
                      Expanded(
                          flex: 2,
                          child: Text(
                              "Rs ${controller.data.cancellationRefund}",
                              style: TextStyle(fontSize: 10))),
                    ],
                  ),
                )
            ],
          ),
          if (controller.data.refundedAmount != null)
            Column(
              children: [
                Container(
                  padding: p15,
                  decoration: BoxDecoration(
                    color: Color(0xffe2e2e2),
                    border: Border(bottom: BorderSide(color: whiteColor)),
                  ),
                  child: Row(children: [
                    Expanded(
                      flex: 6,
                      child: Text("Refunded To Bank"),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text("Rs ${controller.data.refundedAmount}"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ]),
                ),
                Column(
                  children:
                      controller.data.refundToBankItem!.map<Widget>((item) {
                    return Container(
                      padding: p2,
                      decoration: boxDecorationBottomBorder,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: item.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: item.image ?? "", height: 30)
                                  : Image.asset('assets/images/logo.png',
                                      height: 30)),
                          SizedBox(width: 5),
                          Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.offerTitle != null)
                                    Text("${item.offerTitle}",
                                        style: TextStyle(
                                            fontSize: 10, color: pinkColor)),
                                  Text("${item.productName}",
                                      style: TextStyle(fontSize: 10))
                                ],
                              )),
                          SizedBox(width: 5),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "Rs ${item.individualPrice} X ${item.refundedQuantity}",
                                  style: TextStyle(fontSize: 10))),
                          SizedBox(width: 5),
                          Expanded(
                              flex: 2,
                              child: Text("Rs ${item.cartPrice}",
                                  style: TextStyle(fontSize: 10))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          SizedBox(height: 10),
          Padding(
            padding: p10,
            child: Text(
                "The refund of Rs ${controller.data.totalRefund} will be made to the source of payment within 5-7 days. Do you want to go ahead? ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12)),
          ),
          Padding(
            padding: p10,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: customElevatedButton(skyBlueColor, whiteColor),
                    onPressed: () => controller.claimRefund(),
                    child: Text("PROCESS"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: customElevatedButton(darkGrey, whiteColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("CANCEL"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ]));
  }
}

class NormalDateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  const NormalDateSelectorContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeNormalDateRecord = item;
        controller.activeNormalTimeRecord.assignAll(item.time!);
        controller.selectedNormalTimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color:
                          item.value == controller.activeNormalDateRecord.value
                              ? primaryColor
                              : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(children: [
                              Text(item.day!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: item.value ==
                                              controller
                                                  .activeNormalDateRecord.value
                                          ? whiteColor
                                          : null)),
                              Text(item.date!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: item.value ==
                                              controller
                                                  .activeNormalDateRecord.value
                                          ? whiteColor
                                          : null))
                            ])),
                        if (item.value ==
                            controller.activeNormalDateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS")
                      ]),
                ),
                onTap: () {
                  controller.activeNormalDateRecord = item;
                  controller.activeNormalTimeRecord.assignAll(item.time!);
                  controller.selectedNormalTimeSlot("");
                },
              )));
    }).toList());
  }
}

class NormalTimeRow extends StatelessWidget {
  const NormalTimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.activeNormalTimeRecord.map<Widget>((time) {
          if (controller.selectedNormalTimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedNormalTimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedNormalTimeSlot(
                !time.disable! ? time.id.toString() : ""),
            child: Container(
                padding: plr10,
                decoration: boxDecorationlbrBorder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 7,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(time.value!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      time.disable! ? borderColor : null)),
                          leading: SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                  activeColor: packageColor,
                                  value: !time.disable!
                                      ? time.id.toString()
                                      : "",
                                  groupValue: time.disable!
                                      ? null
                                      : controller
                                          .selectedNormalTimeSlot.value,
                                  onChanged: (value) => controller
                                      .selectedNormalTimeSlot(value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(time.text!,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 12,
                                color: time.disable!
                                    ? Colors.red
                                    : packageColor)))
                  ],
                )),
          );
        }).toList()));
  }
}

class ChangeDateTime extends StatelessWidget {
  const ChangeDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: plr10,
        contentPadding: EdgeInsets.all(10),
        title: Container(
            width: MediaQuery.of(context).size.width,
            padding: ptb20,
            color: whiteColor,
            child: Text("Update Date & Time Slot",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NormalDateSelectorContainer(items: controller.data.dateRecords!),
            NormalTimeRow(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor),
                      onPressed: () =>
                          controller.changeDeliverySlotDateTime(),
                      child: Text("UPDATE")),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style: customElevatedButton(darkGrey, whiteColor),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("CANCEL")),
                ),
              ],
            ),
          ],
        ));
  }
}

class ClaimRefundPopUp extends StatelessWidget {
  final String message;
  const ClaimRefundPopUp({super.key, required  this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/orderPlaced.png', height: 80),
          SizedBox(height: 20),
          Text(message, textAlign: TextAlign.center),
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop()))
        ],
      ),
    );
  }
}
