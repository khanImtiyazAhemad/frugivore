import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/stars.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/filter.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/order/myOrder.dart';
import 'package:frugivore/controllers/order/myOrder.dart';

import 'package:frugivore/connectivity.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                if (mode == LoadStatus.loading) {
                  return controller.wait.value
                      ? SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()))
                      : SizedBox();
                } else {
                  return SizedBox();
                }
              },
            ),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: NetworkSensitive(
                child: Container(
                    color: bodyColor,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: "My Orders", search: false),
                                  CustomFilterContainer(
                                      count: controller.orders.count,
                                      text: "Orders",
                                      invoices: controller.orders.invoices,
                                      callback: controller.apicall),
                                  Column(
                                      children: controller.results
                                          .map<Widget>((item) {
                                    return OrderCard(item: item);
                                  }).toList()),
                                  SizedBox(height: 10),
                                  controller.wait.value
                                      ? CircularProgressIndicator()
                                      : Obx(() => Text(
                                          "Page ${controller.orders.page}/${controller.orders.maxPage}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class OrderCard extends StatelessWidget {
  final Result? item;
  const OrderCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/order-detail/${item!.orderId ?? ""}")
          .then((value) => controller.apicall(controller.qsp)),
      child: Card(
          margin: p10,
          shadowColor: Colors.transparent,
          color: whiteColor,
          elevation: 0.1,
          shape: roundedCircularRadius,
          child: Padding(
              padding: p10,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item!.orderStatus != "Cancelled" &&
                            item!.orderStatus != "Rejected")
                        //   Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         controller.trainElements(7, item!.orderplaced),
                        //         controller.trainLine(7),
                        //         controller.trainElements(
                        //             7, item!.orderprocessed),
                        //         controller.trainLine(7),
                        //         controller.trainElements(
                        //             7, item!.outfordelivery),
                        //         controller.trainLine(7),
                        //         if (item!.delivered!.time != null &&
                        //             item!.cancelled!.time == null)
                        //           controller.trainElements(7, item!.delivered)
                        //         else if (item!.delivered!.time == null &&
                        //             item!.cancelled!.time != null)
                        //           controller.trainElements(7, item!.cancelled)
                        //         else
                        //           controller.trainElements(7, item!.delivered),
                        //       ]),
                        // if (item!.orderStatus != "Cancelled" &&
                        //     item!.orderStatus != "Rejected")
                        //   SizedBox(height: 20),
                        // SizedBox(height: 5),
                        Text("#${item!.invoiceNumber}",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold, height: 1)),
                        SizedBox(height: 5),
                        Text(item!.orderStatus!.toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: item!.orderStatus == "Delivered"
                                    ? Colors.green
                                    : item!.orderStatus == "Rejected" ||
                                            item!.orderStatus == "Cancelled"
                                        ? Colors.red
                                        : Colors.orange)),
                        SizedBox(height: 5),
                        Text("Delivery Slot : ${item!.deliverySlot}",
                            style: TextStyle(fontSize: 12, height: 1)),
                        SizedBox(height: 5),
                        Text("Rs ${item!.totalPrice}",
                            style: TextStyle(fontSize: 12)),
                        if (item!.deliveryBoy != "" && item!.orderStatus == "Delivered")
                          Text("Your Order Delivered by : ${item!.deliveryBoy}, ${item!.deliveryBoyNumber}", style: TextStyle(fontWeight: FontWeight.bold),)
                        else if (item!.deliveryBoy != "" && item!.orderStatus != "Cancelled")
                          Text("Your Order will be Delivered by : ${item!.deliveryBoy}, ${item!.deliveryBoyNumber}"),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("${item!.totalItems} Items"),
                            ),
                            if (item!.canCancel!)
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                        style: customElevatedButton(
                                            Colors.red, whiteColor),
                                        onPressed: () {
                                          controller.selectedCancelOrder(
                                              globals.cancelOrder[0]);
                                          showDialog(
                                            context: context,
                                            builder: (_) =>
                                                CancleOrder(item: item!),
                                            barrierDismissible: false,
                                          );
                                        },
                                        child: Text("Cancel Order",
                                            style: TextStyle(fontSize: 12)))),
                              ),
                            if (item!.canRepeatOrder!)
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: customElevatedButton(
                                          primaryColor, whiteColor),
                                      onPressed: () =>
                                          controller.repeatOrder(item!.orderId),
                                      child: Text("Repeat Order",
                                          style: TextStyle(fontSize: 12)),
                                    )),
                              ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                      style: customElevatedButton(
                                          darkGrey, whiteColor),
                                      onPressed: () => Navigator.pushNamed(
                                              context,
                                              "/order-detail/${item!.orderId}")
                                          .then((value) => controller
                                              .apicall(controller.qsp)),
                                      child: Text("View Details",
                                          style: TextStyle(fontSize: 12)))),
                            )
                          ],
                        ),
                        if (item!.claimRefund!)
                          GestureDetector(
                              child: Text("*Claim Refund",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                              onTap: () => Navigator.pushNamed(
                                      context, "/order-detail/${item!.orderId}")
                                  .then((value) =>
                                      controller.apicall(controller.qsp))),
                        if (item!.canGiveFeedback! && item!.rating! <= 0)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("Share Feedback",
                                        textAlign: TextAlign.center)),
                                GestureDetector(
                                    child: StarRating(
                                      value: item!.rating,
                                      filledStar:
                                          Icon(Icons.star, color: yellowColor),
                                      unfilledStar: Icon(Icons.star_border,
                                          color: Colors.black),
                                      color: yellowColor,
                                      onChanged: (index) => showDialog(
                                        context: context,
                                        builder: (_) =>
                                            OrderFeedback(item: item!),
                                        barrierDismissible: true,
                                      ),
                                    ),
                                    onTap: () => showDialog(
                                          context: context,
                                          builder: (_) =>
                                              OrderFeedback(item: item!),
                                          barrierDismissible: true,
                                        )),
                              ])
                        else if (item!.rating! > 0 || item!.comment != null)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("My Feedback",
                                        textAlign: TextAlign.center)),
                                StarRating(
                                  value: item!.rating,
                                  filledStar:
                                      Icon(Icons.star, color: yellowColor),
                                  unfilledStar: Icon(Icons.star,
                                      color: Color(0xff525252)),
                                  color: yellowColor,
                                  onChanged: (index) => {},
                                ),
                                SizedBox(height: 5),
                                if (item!.comment != null) Text(item!.comment)
                              ]),
                        GestureDetector(
                            child: Row(children: [
                              Expanded(
                                flex: 9,
                                child: Container(
                                    padding: ptb15,
                                    child: Text("Need help with this order?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                      'assets/images/blackBackArrow.png',
                                      height: 15))
                            ]),
                            onTap: () => Navigator.pushNamed(
                                context, "/order-detail/${item!.orderId}")),
                      ])))),
    );
  }
}

class CancleOrder extends StatelessWidget {
  final Result item;
  const CancleOrder({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return Obx(() => AlertDialog(
          titlePadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(10),
          title: Container(
              padding: p10,
              child: Image.asset("assets/images/exclamation.png", height: 60)),
          content: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Do you want to Cancel this Order?"),
            SizedBox(height: 20),
            Container(
                height: 50,
                padding: plr10,
                decoration: shapeDecoration,
                child: DropdownButton(
                    value: controller.selectedCancelOrder.value,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: Container(height: 0),
                    iconSize: 30,
                    items: globals.cancelOrder.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 14.0)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      controller.selectedCancelOrder(val.toString());
                      controller.cancellationReason.text = "";
                    })),
            SizedBox(height: 5),
            if (controller.selectedCancelOrder.value == "Others")
              Container(
                  margin: ptb5,
                  decoration: shapeDecoration,
                  child: Padding(
                    padding: p10,
                    child: TextField(
                        controller: controller.cancellationReason,
                        maxLines: 3,
                        decoration: InputDecoration.collapsed(
                            hintText: "Write your Cancellation Reason")),
                  )),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .4,
                        child: ElevatedButton(
                            style: customElevatedButton(pinkColor, whiteColor),
                            child: Text('Yes'),
                            onPressed: () =>
                                controller.cancelOrder(item.orderId)))),
                SizedBox(width: 10),
                Expanded(
                    child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .4,
                        child: ElevatedButton(
                            child: Text('No'),
                            onPressed: () => Navigator.of(context).pop())))
              ],
            )
          ])),
        ));
  }
}

class OrderFeedback extends StatefulWidget {
  final Result item;
  const OrderFeedback({super.key, required this.item});
  @override
  OrderFeedbackState createState() => OrderFeedbackState();
}

class OrderFeedbackState extends State<OrderFeedback> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        content: Padding(
          padding: p2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Rate your Order"),
              StarRating(
                  value: controller.rate.value,
                  filledStar: Icon(Icons.star, color: yellowColor),
                  unfilledStar: Icon(Icons.star, color: Color(0xff525252)),
                  color: yellowColor,
                  onChanged: (index) => setState(() {
                        controller.rate(index);
                      })),
              SizedBox(height: 10),
              Text("Rate your Delivery Boy"),
              StarRating(
                  value: controller.deliveryBoyRating.value,
                  filledStar: Icon(Icons.star, color: yellowColor),
                  unfilledStar: Icon(Icons.star, color: Color(0xff525252)),
                  color: yellowColor,
                  onChanged: (index) => setState(() {
                        controller.deliveryBoyRating(index);
                      })),
              SizedBox(height: 10),
              Container(
                  padding: p10,
                  decoration: shapeDecoration,
                  child: TextField(
                      maxLines: 3,
                      controller: controller.comment,
                      decoration:
                          InputDecoration.collapsed(hintText: "Comment"))),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: customElevatedButton(pinkColor, whiteColor),
                    onPressed: () => controller.feedback(widget.item.orderId),
                    child: Text("Submit")),
              )
            ],
          ),
        ));
  }
}
