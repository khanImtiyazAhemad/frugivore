import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/controllers/preOrder/orderReview.dart';

import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/preOrder/orderReview.dart';

import 'package:frugivore/connectivity.dart';

class PreOrderReviewPage extends StatelessWidget {
  const PreOrderReviewPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(PreOrderReviewController());
    return Scaffold(
        // appBar: CustomAppBar(),
        bottomNavigationBar: Obx(() => CustomOrderNavigationBar(
            amount: controller.amountPayable.value,
            text: "PAY",
            offer: controller.orderReview.discount != null ||
                    controller.orderReview.cashback != null
                ? true
                : false,
            controller: controller)),
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
                      child: Obx(() {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(
                                  children: [
                                    CustomTitleBar(
                                        title: "Delivery Details",
                                        search: false),
                                    Card(
                                        margin: plr10,
                                        shape: roundedCircularRadius,
                                        child: Padding(
                                            padding: p10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10),
                                                Text("1.Select Address"),
                                                Container(
                                                    margin: ptb5,
                                                    height: 40,
                                                    decoration:
                                                        shapeDecoration,
                                                    child: Padding(
                                                      padding: plr10,
                                                      child: DropdownButton(
                                                          value: controller
                                                              .defaultAddress,
                                                          isExpanded: true,
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          underline:
                                                              Container(
                                                                  height:
                                                                      0),
                                                          iconSize: 30,
                                                          items: controller
                                                              .addressList
                                                              .map((value) {
                                                            return DropdownMenuItem(
                                                              value: value
                                                                  .id
                                                                  .toString(),
                                                              child: Text(
                                                                  value
                                                                      .completeAddress,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.0)),
                                                            );
                                                          }).toList(),
                                                          onChanged: (selectedvalue) =>
                                                              controller
                                                                  .changeAddress(
                                                                      selectedvalue)),
                                                    )),
                                                SizedBox(height: 10),
                                                Text(
                                                    "2.Select Delivery Date"),
                                                Column(children: [
                                                  Padding(
                                                      padding: pt5,
                                                      child: NormalDateSelectorContainer(
                                                          items: controller
                                                              .orderReview
                                                              .dateRecords!)),
                                                  NormalTimeRow(),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          height: 24.0,
                                                          width: 24.0,
                                                          child: Checkbox(
                                                            checkColor:
                                                                whiteColor,
                                                            activeColor:
                                                                pinkColor,
                                                            value: controller
                                                                .carryBag
                                                                .value,
                                                            onChanged: (val) =>
                                                                controller
                                                                    .carryBag(
                                                                        val),
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Do you want Carry Bag ? (optional)*",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                    ],
                                                  ),
                                                  if (controller
                                                      .carryBag.value)
                                                    CarryBagRow(),
                                                ]),
                                                SizedBox(height: 10),
                                                Text(
                                                    "3. Any Special Instructions (optional)*"),
                                                Container(
                                                    margin: ptb5,
                                                    decoration:
                                                        shapeDecoration,
                                                    child: Padding(
                                                      padding: p10,
                                                      child: TextField(
                                                          controller:
                                                              controller
                                                                  .instruction,
                                                          maxLines: 5,
                                                          decoration: InputDecoration
                                                              .collapsed(
                                                                  hintText:
                                                                      "Eg. 1 Avacados should be ripe. I want to eat them right away.\n\nEg. 2 I have to go to work, please try to deliver before 10:00 AM.")),
                                                    )),
                                                Text(
                                                  "* Followed on best efforts basis. No guarantees.",
                                                  style: TextStyle(
                                                      color: pinkColor),
                                                )
                                              ],
                                            ))),
                                    SizedBox(height: 80)
                                  ],
                                ),
                        );
                      })))),
        ));
  }
}

//  ----------------- NORMAL CONTAINER SECTION --------------------------
class NormalDateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  const NormalDateSelectorContainer({super.key, required this.items});
  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(PreOrderReviewController());
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
                                      color: item.value ==
                                              controller
                                                  .activeNormalDateRecord.value
                                          ? whiteColor
                                          : null)),
                              Text(item.date!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
    final controller =
      Get.put(PreOrderReviewController());
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.activeNormalTimeRecord.map<Widget>((time) {
          if (controller.selectedNormalTimeSlot.value == "") {
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
                                  fontSize: 14,
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
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color:
                                  time.disable! ? Colors.red : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class CarryBagRow extends StatelessWidget {
  const CarryBagRow({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(PreOrderReviewController());
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedCarryBag(item.id.toString());
      }
      return Obx(() => Container(
          decoration: boxDecorationBottomBorder,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Text(item.name ?? "", style: TextStyle(fontSize: 14)),
                    leading: SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Radio(
                            activeColor: packageColor,
                            value: item.id.toString(),
                            groupValue: controller.selectedCarryBag.value,
                            onChanged: (value) =>
                                controller.addCarryBag(value, item.price))),
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.info, color: backgroundGrey, size: 18),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => CarryBagPopUp(item: item),
                      barrierDismissible: true,
                    ),
                  )),
              Expanded(flex: 1, child: Text("Rs:${item.price}")),
              Expanded(
                  flex: 1,
                  child: item.bagDefault!
                      ? Text("Free",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryColor))
                      : controller.selectedCarryBag.value == item.id.toString()
                          ? Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                          child: Container(
                                              height: 38,
                                              padding: ptb10,
                                              decoration: cartLeftButton,
                                              child: Icon(Icons.remove,
                                                  color: whiteColor, size: 15)),
                                          onTap: () => controller
                                              .decreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style:
                                                  TextStyle(color: whiteColor),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller:
                                                  controller.carryBagTextField,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "1",
                                              )))),
                                  Expanded(
                                      child: GestureDetector(
                                          child: Container(
                                              height: 38,
                                              padding: ptb10,
                                              decoration: cartRightButton,
                                              child: Icon(Icons.add,
                                                  color: whiteColor, size: 15)),
                                          onTap: () => controller
                                              .increaseCarryBagQuantity(
                                                  item.price)))
                                ],
                              ))
                          : Container(
                              color: whiteColor,
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style:
                                    customElevatedButton(pinkColor, whiteColor),
                                child: Text("ADD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                                onPressed: () => controller.addCarryBag(
                                    item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class CarryBagPopUp extends StatelessWidget {
  final Bag item;
  const CarryBagPopUp({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text('${item.name} Description',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 14))),
        content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          CachedNetworkImage(imageUrl: item.image!),
          Html(data: item.description)
        ])));
  }
}
