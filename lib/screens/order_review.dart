import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/orderReview.dart';
import 'package:frugivore/controllers/orderReview.dart';

import 'package:frugivore/connectivity.dart';

class OrderReviewPage extends StatelessWidget {
  const OrderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderReviewController());
    return Scaffold(
        bottomNavigationBar: Obx(() => CustomOrderNavigationBar(
            amount: controller.amountPayable.value,
            text: "PAY",
            offer: controller.orderReview.discount != null ||
                    controller.orderReview.cashback != null
                ? true
                : false,
            offerText: "PROMOS APPLIED",
            controller: controller)),
        body: GestureDetector(
          onTap: () => controller.hideKeyboard(),
          child: SafeArea(
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
                                                    CrossAxisAlignment
                                                        .start,
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
                                                        child:
                                                            DropdownButton(
                                                                value: controller
                                                                    .defaultAddress,
                                                                isExpanded:
                                                                    true,
                                                                icon: Icon(Icons
                                                                    .arrow_drop_down),
                                                                underline:
                                                                    Container(
                                                                        height:
                                                                            0),
                                                                iconSize:
                                                                    30,
                                                                items: controller
                                                                    .addressList!
                                                                    .map(
                                                                        (value) {
                                                                  return DropdownMenuItem(
                                                                    value: value
                                                                        .id
                                                                        .toString(),
                                                                    child: Text(
                                                                        value
                                                                            .completeAddress,
                                                                        style:
                                                                            TextStyle(fontSize: 14.0)),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (selectedvalue) =>
                                                                    controller
                                                                        .changeAddress(selectedvalue)),
                                                      )),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "2.Select Delivery Date"),
                                                  if (controller.orderReview
                                                      .multipleOrder == true)
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 5),
                                                        if (controller
                                                            .orderReview
                                                            .option1
                                                            !.active == true)
                                                          Option1Container(
                                                              item: controller
                                                                  .orderReview
                                                                  .option1!),
                                                        if (controller
                                                            .orderReview
                                                            .option2
                                                            !.active == true)
                                                          Option2Container(
                                                              item: controller
                                                                  .orderReview
                                                                  .option2!),
                                                        if (controller
                                                            .orderReview
                                                            .option3
                                                            !.active == true)
                                                          Option3Container(
                                                              item: controller
                                                                  .orderReview
                                                                  .option3!),
                                                      ],
                                                    )
                                                  else
                                                    Column(children: [
                                                      Padding(
                                                          padding: pt5,
                                                          child: NormalDateSelectorContainer(
                                                              items: controller
                                                                  .orderReview
                                                                  .dateRecords!)),
                                                      NormalTimeRow(),
                                                      SizedBox(height: 10),
                                                      if (controller
                                                              .orderReview
                                                              .bags
                                                              !.isNotEmpty)
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                height:
                                                                    24.0,
                                                                width: 24.0,
                                                                child:
                                                                    Checkbox(
                                                                  checkColor:
                                                                      whiteColor,
                                                                  activeColor:
                                                                      pinkColor,
                                                                  value: controller
                                                                      .carryBag
                                                                      .value,
                                                                  onChanged:
                                                                      (val) =>
                                                                          controller.carryBag(val),
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Do you want Carry Bag ? (optional)*",
                                                                  style: TextStyle(
                                                                      color:
                                                                          Colors.black),
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
                                      SizedBox(height: 10,),
                                      if (controller
                                              .deliveryInstruction.isNotEmpty)
                                        DeliveryInstructionContainer(
                                            items:
                                                controller.deliveryInstruction),
                                      SizedBox(height: 80)
                                    ],
                                  ),
                          );
                        })))),
          ),
        ));
  }
}

//  ----------------- NORMAL CONTAINER SECTION --------------------------
class NormalDateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  NormalDateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
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
  final controller = Get.put(OrderReviewController());

  NormalTimeRow({super.key});

  @override
  Widget build(BuildContext context) {
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
                                  onChanged: (value) =>
                                      controller.selectedNormalTimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class CarryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  CarryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
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
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
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

// ----------------- OPTION 1 CONTAINER SECTION -------------------------

class Option1DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option1DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption1DateRecord = item;
        controller.activeOption1TimeRecord.assignAll(item.time!);
        controller.selectedOption1TimeSlot("");
      }
      return Expanded(
        flex: items.length,
        child: Obx(() => GestureDetector(
              child: Container(
                alignment: Alignment.center,
                decoration: boxDecorationWithOutRadius.copyWith(
                    color:
                        item.value == controller.activeOption1DateRecord.value
                            ? primaryColor
                            : null),
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                          padding: ptb10,
                          child: Column(
                            children: [
                              Text(item.day!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: item.value ==
                                              controller
                                                  .activeOption1DateRecord
                                                  .value
                                          ? whiteColor
                                          : null)),
                              Text(item.date!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: item.value ==
                                              controller
                                                  .activeOption1DateRecord
                                                  .value
                                          ? whiteColor
                                          : null))
                            ],
                          )),
                      if (item.value ==
                          controller.activeOption1DateRecord.value)
                        Triangle(
                            color: whiteColor,
                            height: 5,
                            width: 10,
                            direction: "ULLRS"),
                    ]),
              ),
              onTap: () {
                controller.activeOption1DateRecord = item;
                controller.activeOption1TimeRecord.assignAll(item.time!);
                controller.selectedOption1TimeSlot("");
              },
            )),
      );
    }).toList());
  }
}

class Option1TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option1TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.activeOption1TimeRecord.map<Widget>((time) {
          if (controller.selectedOption1TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption1TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption1TimeSlot(
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
                                          .selectedOption1TimeSlot.value,
                                  onChanged: (value) =>
                                      controller.selectedOption1TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option1carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option1carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption1CarryBag(item.id.toString());
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
                            groupValue:
                                controller.selectedOption1CarryBag.value,
                            onChanged: (value) => controller.option1AddCarryBag(
                                value, item.price))),
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
                      : controller.selectedOption1CarryBag.value ==
                              item.id.toString()
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
                                              .option1DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option1CarryBagTextField,
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
                                              .option1IncreaseCarryBagQuantity(
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
                                onPressed: () => controller.option1AddCarryBag(
                                    item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option1Container extends StatelessWidget {
  final Option1 item;
  Option1Container({super.key, required this.item});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: controller.deliveryType.value == "OPTION1"
                    ? pinkColor
                    : Colors.transparent)),
        child: Column(children: [
          Container(
              color: backgroundGrey,
              padding: p10,
              child: Row(children: [
                Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () => controller.deliveryTypeController("OPTION1"),
                      child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title!),
                                Text(item.subtitle!,
                                    style: TextStyle(fontSize: 12))
                              ]),
                          leading: SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                  activeColor: packageColor,
                                  value: "OPTION1",
                                  groupValue: controller.selectedDeliveryType,
                                  onChanged: (value) => controller
                                      .deliveryTypeController(value)))),
                    )),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: pinkColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text("${item.items!.length} Items")),
                        onTap: () => showDialog(
                              context: context,
                              builder: (_) => ItemsPopup(
                                  items: item.items!, title: item.popupTitle!),
                              barrierDismissible: true,
                            )))
              ])),
          if (controller.deliveryType.value == "OPTION1")
            Column(
              children: [
                Option1DateSelectorContainer(items: item.deliverySlot!),
                Option1TimeRow()
              ],
            ),
          Container(
              padding: p10,
              width: MediaQuery.of(context).size.width,
              color: pinkColor,
              child: Text("Delivery Fee: Rs ${item.deliveryFee}",
                  style: TextStyle(color: whiteColor))),
          if (controller.deliveryType.value == "OPTION1")
            if (controller.orderReview.bags!.isNotEmpty)
              Padding(
                  padding: p10,
                  child: Column(children: [
                    Row(children: [
                      SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Checkbox(
                              checkColor: whiteColor,
                              activeColor: pinkColor,
                              value: controller.option1CarryBag.value,
                              onChanged: (val) =>
                                  controller.option1CarryBag(val))),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Do you want Carry Bag ? (optional)*",
                              style: TextStyle(color: Colors.black)))
                    ]),
                    if (controller.option1CarryBag.value) Option1carryBagRow(),
                  ]))
        ])));
  }
}

// ----------------- OPTION 2 CONTAINER SECTION -------------------------

class Option2Shipment1DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option2Shipment1DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption2Shipment1DateRecord = item;
        controller.activeOption2Shipment1TimeRecord.assignAll(item.time!);
        controller.selectedOption2Shipment1TimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  // padding: ptb10,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color: item.value ==
                              controller.activeOption2Shipment1DateRecord.value
                          ? primaryColor
                          : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(
                              children: [
                                Text(item.day!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption2Shipment1DateRecord
                                                    .value
                                            ? whiteColor
                                            : null)),
                                Text(item.date!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption2Shipment1DateRecord
                                                    .value
                                            ? whiteColor
                                            : null))
                              ],
                            )),
                        if (item.value ==
                            controller.activeOption2Shipment1DateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS"),
                      ]),
                ),
                onTap: () {
                  controller.activeOption2Shipment1DateRecord = item;
                  controller.activeOption2Shipment1TimeRecord
                      .assignAll(item.time!);
                  controller.selectedOption2Shipment1TimeSlot("");
                },
              )));
    }).toList());
  }
}

class Option2Shipment1TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option2Shipment1TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.activeOption2Shipment1TimeRecord.map<Widget>((time) {
          if (controller.selectedOption2Shipment1TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption2Shipment1TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption2Shipment1TimeSlot(
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
                                          .selectedOption2Shipment1TimeSlot
                                          .value,
                                  onChanged: (value) => controller
                                      .selectedOption2Shipment1TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option2Shipment1carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option2Shipment1carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption2Shipment1CarryBag(item.id.toString());
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
                            groupValue: controller
                                .selectedOption2Shipment1CarryBag.value,
                            onChanged: (value) =>
                                controller.option2Shipment1AddCarryBag(
                                    value, item.price))),
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
                      : controller.selectedOption2Shipment1CarryBag.value ==
                              item.id.toString()
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
                                              .option2Shipment1DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option2Shipment1CarryBagTextField,
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
                                              .option2Shipment1IncreaseCarryBagQuantity(
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
                                onPressed: () =>
                                    controller.option2Shipment1AddCarryBag(
                                        item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option2Shipment2DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option2Shipment2DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption2Shipment2DateRecord = item;
        controller.activeOption2Shipment2TimeRecord.assignAll(item.time!);
        controller.selectedOption2Shipment2TimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  // padding: ptb10,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color: item.value ==
                              controller.activeOption2Shipment2DateRecord.value
                          ? primaryColor
                          : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(
                              children: [
                                Text(item.day!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption2Shipment2DateRecord
                                                    .value
                                            ? whiteColor
                                            : null)),
                                Text(item.date!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption2Shipment2DateRecord
                                                    .value
                                            ? whiteColor
                                            : null))
                              ],
                            )),
                        if (item.value ==
                            controller.activeOption2Shipment2DateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS"),
                      ]),
                ),
                onTap: () {
                  controller.activeOption2Shipment2DateRecord = item;
                  controller.activeOption2Shipment2TimeRecord
                      .assignAll(item.time!);
                  controller.selectedOption2Shipment2TimeSlot("");
                },
              )));
    }).toList());
  }
}

class Option2Shipment2TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option2Shipment2TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.activeOption2Shipment2TimeRecord.map<Widget>((time) {
          if (controller.selectedOption2Shipment2TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption2Shipment2TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption2Shipment2TimeSlot(
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
                                          .selectedOption2Shipment2TimeSlot
                                          .value,
                                  onChanged: (value) => controller
                                      .selectedOption2Shipment2TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option2Shipment2carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option2Shipment2carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption2Shipment2CarryBag(item.id.toString());
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
                            groupValue: controller
                                .selectedOption2Shipment2CarryBag.value,
                            onChanged: (value) =>
                                controller.option2Shipment2AddCarryBag(
                                    value, item.price))),
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
                      : controller.selectedOption2Shipment2CarryBag.value ==
                              item.id.toString()
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
                                              .option2Shipment2DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option2Shipment2CarryBagTextField,
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
                                              .option2Shipment2IncreaseCarryBagQuantity(
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
                                onPressed: () =>
                                    controller.option2Shipment2AddCarryBag(
                                        item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option2Container extends StatelessWidget {
  final Option item;
  Option2Container({super.key, required this.item});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: p20,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(flex: 4, child: Divider(color: Colors.black)),
              Expanded(
                  flex: 1,
                  child: Text("OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20))),
              Expanded(flex: 4, child: Divider(color: Colors.black))
            ])),
        Obx(() => Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: controller.deliveryType.value == "OPTION2"
                        ? pinkColor
                        : Colors.transparent)),
            child: Column(children: [
              Container(
                color: backgroundGrey,
                padding: p10,
                child: Column(children: [
                  GestureDetector(
                    onTap: () => controller.deliveryTypeController("OPTION2"),
                    child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title!),
                              Text(item.subtitle!,
                                  style: TextStyle(fontSize: 12))
                            ]),
                        leading: SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: Radio(
                                activeColor: packageColor,
                                value: "OPTION2",
                                groupValue: controller.selectedDeliveryType,
                                onChanged: (value) =>
                                    controller.deliveryTypeController(value)))),
                  ),
                  if (controller.deliveryType.value != "OPTION2")
                    GestureDetector(
                      onTap: () => controller.deliveryTypeController("OPTION2"),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 8, child: Text(item.shipment1!.title!)),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: pinkColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                          "${item.shipment1!.items!.length} Items"))))
                        ]),
                        SizedBox(height: 5),
                        Row(children: [
                          Expanded(
                              flex: 8, child: Text(item.shipment2!.title!)),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: pinkColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                          "${item.shipment2!.items!.length} Items"))))
                        ])
                      ]),
                    ),
                ]),
              ),
              if (controller.deliveryType.value == "OPTION2")
                Column(
                  children: [
                    Container(
                      color: bodyColor,
                      padding: p10,
                      child: Row(children: [
                        Expanded(flex: 8, child: Text(item.shipment1!.title!)),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: pinkColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                        "${item.shipment1!.items!.length} Items")),
                                onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => ItemsPopup(
                                          items: item.shipment1!.items!,
                                          title: item.shipment1!.popupTitle!),
                                      barrierDismissible: true,
                                    )))
                      ]),
                    ),
                    Option2Shipment1DateSelectorContainer(
                        items: item.shipment1!.deliverySlot!),
                    Option2Shipment1TimeRow(),
                    Container(
                        padding: p10,
                        width: MediaQuery.of(context).size.width,
                        color: pinkColor,
                        child: Text(
                            "Delivery Fee: Rs ${item.shipment1!.deliveryFee}",
                            style: TextStyle(color: whiteColor))),
                    if (controller.orderReview.bags!.isNotEmpty)
                      Padding(
                          padding: p10,
                          child: Column(children: [
                            Row(children: [
                              SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Checkbox(
                                      checkColor: whiteColor,
                                      activeColor: pinkColor,
                                      value: controller
                                          .option2Shipment1CarryBag.value,
                                      onChanged: (val) => controller
                                          .option2Shipment1CarryBag(val))),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Do you want Carry Bag ? (optional)*",
                                      style: TextStyle(color: Colors.black)))
                            ]),
                            if (controller.option2Shipment1CarryBag.value)
                              Option2Shipment1carryBagRow(),
                          ]))
                  ],
                ),
              if (controller.deliveryType.value == "OPTION2")
                Column(children: [
                  Container(
                      color: bodyColor,
                      padding: p10,
                      child: Row(children: [
                        Expanded(flex: 8, child: Text(item.shipment2!.title!)),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: pinkColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                        "${item.shipment2!.items!.length} Items")),
                                onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => ItemsPopup(
                                          items: item.shipment2!.items!,
                                          title: item.shipment2!.popupTitle!),
                                      barrierDismissible: true,
                                    )))
                      ])),
                  Option2Shipment2DateSelectorContainer(
                      items: item.shipment2!.deliverySlot!),
                  Option2Shipment2TimeRow(),
                  Container(
                      padding: p10,
                      width: MediaQuery.of(context).size.width,
                      color: pinkColor,
                      child: Text(
                          "Delivery Fee: Rs ${item.shipment2!.deliveryFee}",
                          style: TextStyle(color: whiteColor))),
                  if (controller.orderReview.bags!.isNotEmpty)
                    Padding(
                        padding: p10,
                        child: Column(children: [
                          Row(children: [
                            SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Checkbox(
                                    checkColor: whiteColor,
                                    activeColor: pinkColor,
                                    value: controller
                                        .option2Shipment2CarryBag.value,
                                    onChanged: (val) => controller
                                        .option2Shipment2CarryBag(val))),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                    "Do you want Carry Bag ? (optional)*",
                                    style: TextStyle(color: Colors.black)))
                          ]),
                          if (controller.option2Shipment2CarryBag.value)
                            Option2Shipment2carryBagRow(),
                        ]))
                ]),
              if (controller.deliveryType.value != "OPTION2")
                Container(
                    padding: p10,
                    width: MediaQuery.of(context).size.width,
                    color: pinkColor,
                    child: Text("Total Delivery Fee: Rs ${item.deliveryFee}",
                        style: TextStyle(color: whiteColor)))
            ]))),
      ],
    );
  }
}

// ----------------- OPTION 3 CONTAINER SECTION -------------------------

class Option3Shipment1DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option3Shipment1DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption3Shipment1DateRecord = item;
        controller.activeOption3Shipment1TimeRecord.assignAll(item.time!);
        controller.selectedOption3Shipment1TimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color: item.value ==
                              controller.activeOption3Shipment1DateRecord.value
                          ? primaryColor
                          : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(
                              children: [
                                Text(item.day!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment1DateRecord
                                                    .value
                                            ? whiteColor
                                            : null)),
                                Text(item.date!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment1DateRecord
                                                    .value
                                            ? whiteColor
                                            : null))
                              ],
                            )),
                        if (item.value ==
                            controller.activeOption3Shipment1DateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS"),
                      ]),
                ),
                onTap: () {
                  controller.activeOption3Shipment1DateRecord = item;
                  controller.activeOption3Shipment1TimeRecord
                      .assignAll(item.time!);
                  controller.selectedOption3Shipment1TimeSlot("");
                },
              )));
    }).toList());
  }
}

class Option3Shipment1TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment1TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.activeOption3Shipment1TimeRecord.map<Widget>((time) {
          if (controller.selectedOption3Shipment1TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption3Shipment1TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption3Shipment1TimeSlot(
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
                                          .selectedOption3Shipment1TimeSlot
                                          .value,
                                  onChanged: (value) => controller
                                      .selectedOption3Shipment1TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option3Shipment1carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment1carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption3Shipment1CarryBag(item.id.toString());
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
                        child: Radio<String>(
                            activeColor: packageColor,
                            value: item.id.toString(),
                            groupValue: controller
                                .selectedOption3Shipment1CarryBag
                                .toString(),
                            onChanged: (value) =>
                                controller.option3Shipment1AddCarryBag(
                                    value, item.price))),
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
                      : controller.selectedOption3Shipment1CarryBag.value ==
                              item.id.toString()
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
                                              .option3Shipment1DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option3Shipment1CarryBagTextField,
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
                                              .option3Shipment1IncreaseCarryBagQuantity(
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
                                onPressed: () =>
                                    controller.option3Shipment1AddCarryBag(
                                        item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option3Shipment2DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option3Shipment2DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption3Shipment2DateRecord = item;
        controller.activeOption3Shipment2TimeRecord.assignAll(item.time!);
        controller.selectedOption3Shipment2TimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  // padding: ptb10,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color: item.value ==
                              controller.activeOption3Shipment2DateRecord.value
                          ? primaryColor
                          : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(
                              children: [
                                Text(item.day!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment2DateRecord
                                                    .value
                                            ? whiteColor
                                            : null)),
                                Text(item.date!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment2DateRecord
                                                    .value
                                            ? whiteColor
                                            : null))
                              ],
                            )),
                        if (item.value ==
                            controller.activeOption3Shipment2DateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS"),
                      ]),
                ),
                onTap: () {
                  controller.activeOption3Shipment2DateRecord = item;
                  controller.activeOption3Shipment2TimeRecord
                      .assignAll(item.time!);
                  controller.selectedOption3Shipment2TimeSlot("");
                },
              )));
    }).toList());
  }
}

class Option3Shipment2TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment2TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.activeOption3Shipment2TimeRecord.map<Widget>((time) {
          if (controller.selectedOption3Shipment2TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption3Shipment2TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption3Shipment2TimeSlot(
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
                                          .selectedOption3Shipment2TimeSlot
                                          .value,
                                  onChanged: (value) => controller
                                      .selectedOption3Shipment2TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option3Shipment2carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment2carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption2Shipment2CarryBag(item.id.toString());
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
                        child: Radio<String>(
                            activeColor: packageColor,
                            value: item.id.toString(),
                            groupValue: controller
                                .selectedOption2Shipment2CarryBag.value,
                            onChanged: (value) =>
                                controller.option3Shipment2AddCarryBag(
                                    value, item.price))),
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
                      : controller.selectedOption3Shipment2CarryBag.value ==
                              item.id.toString()
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
                                              .option3Shipment2DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option3Shipment2CarryBagTextField,
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
                                              .option3Shipment2IncreaseCarryBagQuantity(
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
                                onPressed: () =>
                                    controller.option3Shipment2AddCarryBag(
                                        item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option3Shipment3DateSelectorContainer extends StatelessWidget {
  final List<DateRecord> items;
  Option3Shipment3DateSelectorContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Row(
        children: items.map<Widget>((item) {
      if (item.checked!) {
        controller.activeOption3Shipment3DateRecord = item;
        controller.activeOption3Shipment3TimeRecord.assignAll(item.time!);
        controller.selectedOption3Shipment3TimeSlot("");
      }
      return Expanded(
          flex: items.length,
          child: Obx(() => GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  // padding: ptb10,
                  decoration: boxDecorationWithOutRadius.copyWith(
                      color: item.value ==
                              controller.activeOption3Shipment3DateRecord.value
                          ? primaryColor
                          : null),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            padding: ptb10,
                            child: Column(
                              children: [
                                Text(item.day!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment3DateRecord
                                                    .value
                                            ? whiteColor
                                            : null)),
                                Text(item.date!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: item.value ==
                                                controller
                                                    .activeOption3Shipment3DateRecord
                                                    .value
                                            ? whiteColor
                                            : null))
                              ],
                            )),
                        if (item.value ==
                            controller.activeOption3Shipment3DateRecord.value)
                          Triangle(
                              color: whiteColor,
                              height: 5,
                              width: 10,
                              direction: "ULLRS"),
                      ]),
                ),
                onTap: () {
                  controller.activeOption3Shipment3DateRecord = item;
                  controller.activeOption3Shipment3TimeRecord
                      .assignAll(item.time!);
                  controller.selectedOption3Shipment3TimeSlot("");
                },
              )));
    }).toList());
  }
}

class Option3Shipment3TimeRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment3TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            controller.activeOption3Shipment3TimeRecord.map<Widget>((time) {
          if (controller.selectedOption3Shipment3TimeSlot.value == "" &&
              !time.disable!) {
            controller.selectedOption3Shipment3TimeSlot(time.id.toString());
          }
          return GestureDetector(
            onTap: () => controller.selectedOption3Shipment3TimeSlot(
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
                                          .selectedOption3Shipment3TimeSlot
                                          .value,
                                  onChanged: (value) => controller
                                      .selectedOption3Shipment3TimeSlot(
                                          value.toString()))),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          time.text!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: time.disable!
                                  ? Colors.red
                                  : packageColor),
                        ))
                  ],
                )),
          );
        }).toList()));
  }
}

class Option3Shipment3carryBagRow extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  Option3Shipment3carryBagRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: controller.orderReview.bags!.map<Widget>((item) {
      if (item.bagDefault!) {
        controller.selectedOption2Shipment2CarryBag(item.id.toString());
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
                        child: Radio<String>(
                            activeColor: packageColor,
                            value: item.id.toString(),
                            groupValue: controller
                                .selectedOption2Shipment2CarryBag.value,
                            onChanged: (value) =>
                                controller.option3Shipment3AddCarryBag(
                                    value, item.price))),
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
                      : controller.selectedOption3Shipment3CarryBag.value ==
                              item.id.toString()
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
                                              .option3Shipment3DecreaseCarryBagQuantity(
                                                  item.price))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 38,
                                          padding: ptb10,
                                          color: pinkColor,
                                          child: TextField(
                                              enableInteractiveSelection: false,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: controller
                                                  .option3Shipment3CarryBagTextField,
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
                                              .option3Shipment3IncreaseCarryBagQuantity(
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
                                onPressed: () =>
                                    controller.option3Shipment3AddCarryBag(
                                        item.id.toString(), item.price),
                              )))
            ],
          )));
    }).toList());
  }
}

class Option3Container extends StatelessWidget {
  final Option item;
  Option3Container({super.key, required this.item});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: p20,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(flex: 4, child: Divider(color: Colors.black)),
              Expanded(
                  flex: 1,
                  child: Text("OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20))),
              Expanded(flex: 4, child: Divider(color: Colors.black))
            ])),
        Obx(() => Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: controller.deliveryType.value == "OPTION2"
                        ? pinkColor
                        : Colors.transparent)),
            child: Column(children: [
              Container(
                color: backgroundGrey,
                padding: p10,
                child: Column(children: [
                  GestureDetector(
                    onTap: () => controller.deliveryTypeController("OPTION3"),
                    child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title!),
                              Text(item.subtitle!,
                                  style: TextStyle(fontSize: 12))
                            ]),
                        leading: SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: Radio(
                                activeColor: packageColor,
                                value: "OPTION3",
                                groupValue: controller.selectedDeliveryType,
                                onChanged: (value) =>
                                    controller.deliveryTypeController(value)))),
                  ),
                  if (controller.deliveryType.value != "OPTION3")
                    GestureDetector(
                      onTap: () => controller.deliveryTypeController("OPTION3"),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 8, child: Text(item.shipment1!.title!)),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: pinkColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                          "${item.shipment1!.items!.length} Items"))))
                        ]),
                        SizedBox(height: 5),
                        Row(children: [
                          Expanded(
                              flex: 8, child: Text(item.shipment2!.title!)),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: pinkColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                          "${item.shipment2!.items!.length} Items"))))
                        ])
                      ]),
                    ),
                ]),
              ),
              if (controller.deliveryType.value == "OPTION3")
                Column(
                  children: [
                    Container(
                      color: bodyColor,
                      padding: p10,
                      child: Row(children: [
                        Expanded(flex: 8, child: Text(item.shipment1!.title!)),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: pinkColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                        "${item.shipment1!.items!.length} Items")),
                                onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => ItemsPopup(
                                          items: item.shipment1!.items!,
                                          title: item.shipment1!.popupTitle!),
                                      barrierDismissible: true,
                                    )))
                      ]),
                    ),
                    Option3Shipment1DateSelectorContainer(
                        items: item.shipment1!.deliverySlot!),
                    Option3Shipment1TimeRow(),
                    Container(
                        padding: p10,
                        width: MediaQuery.of(context).size.width,
                        color: pinkColor,
                        child: Text(
                            "Delivery Fee: Rs ${item.shipment1!.deliveryFee}",
                            style: TextStyle(color: whiteColor))),
                    if (controller.orderReview.bags!.isNotEmpty)
                      Padding(
                          padding: p10,
                          child: Column(children: [
                            Row(children: [
                              SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Checkbox(
                                      checkColor: whiteColor,
                                      activeColor: pinkColor,
                                      value: controller
                                          .option2Shipment1CarryBag.value,
                                      onChanged: (val) => controller
                                          .option2Shipment1CarryBag(val))),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Do you want Carry Bag ? (optional)*",
                                      style: TextStyle(color: Colors.black)))
                            ]),
                            if (controller.option2Shipment1CarryBag.value)
                              Option3Shipment1carryBagRow(),
                          ])),
                  ],
                ),
              if (controller.deliveryType.value == "OPTION3")
                Column(children: [
                  Container(
                      color: bodyColor,
                      padding: p10,
                      child: Row(children: [
                        Expanded(flex: 8, child: Text(item.shipment2!.title!)),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: pinkColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                        "${item.shipment2!.items!.length} Items")),
                                onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => ItemsPopup(
                                          items: item.shipment2!.items!,
                                          title: item.shipment2!.popupTitle!),
                                      barrierDismissible: true,
                                    )))
                      ])),
                  Option3Shipment2DateSelectorContainer(
                      items: item.shipment2!.deliverySlot!),
                  Option3Shipment2TimeRow(),
                  Container(
                      padding: p10,
                      width: MediaQuery.of(context).size.width,
                      color: pinkColor,
                      child: Text(
                          "Delivery Fee: Rs ${item.shipment2!.deliveryFee}",
                          style: TextStyle(color: whiteColor))),
                  if (controller.orderReview.bags!.isNotEmpty)
                    Padding(
                        padding: p10,
                        child: Column(children: [
                          Row(children: [
                            SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Checkbox(
                                    checkColor: whiteColor,
                                    activeColor: pinkColor,
                                    value: controller
                                        .option2Shipment2CarryBag.value,
                                    onChanged: (val) => controller
                                        .option2Shipment2CarryBag(val))),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                    "Do you want Carry Bag ? (optional)*",
                                    style: TextStyle(color: Colors.black)))
                          ]),
                          if (controller.option2Shipment2CarryBag.value)
                            Option3Shipment2carryBagRow(),
                        ]))
                ]),
              if (controller.deliveryType.value != "OPTION3")
                Container(
                    padding: p10,
                    width: MediaQuery.of(context).size.width,
                    color: pinkColor,
                    child: Text("Total Delivery Fee: Rs ${item.deliveryFee}",
                        style: TextStyle(color: whiteColor)))
            ]))),
      ],
    );
  }
}

// ----------------- STATIC CONTAINER SECTION -------------------------

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

class SameDayAlert extends StatelessWidget {
  final controller = Get.put(OrderReviewController());

  SameDayAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset("assets/images/sameDayAlert.jpeg"),
          SizedBox(height: 20),
          Container(
              padding: plr20,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text("GO FOR SAME DAY DELIVERY OPTION"),
                  onPressed: () => controller.optForSameDayDelivery())),
          GestureDetector(
              child: Text("No, Thanks",
                  style: TextStyle(decoration: TextDecoration.underline)),
              onTap: () => Navigator.of(context).pop()),
          SizedBox(height: 20),
        ])));
  }
}

class ItemsPopup extends StatelessWidget {
  final List<Item> items;
  final String title;
  ItemsPopup({super.key, required this.items, required this.title});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        contentPadding: plr15,
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 14))),
        content: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: items.map((item) {
                  return Container(
                    decoration: boxDecorationBottomBorder,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CachedNetworkImage(
                              imageUrl: item.package!.imgOne!),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            flex: 7,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${item.product!.brand} - ${item.product!.name}"),
                                  Text(
                                      "${item.package!.name} X ${item.quantity}")
                                ])),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    controller.deleteItem(item.id)))
                      ],
                    ),
                  );
                }).toList())));
  }
}

class DeliveryInstructionContainer extends StatelessWidget {
  final List<DeliveryInstructionModel> items;
  DeliveryInstructionContainer({super.key, required this.items});
  final controller = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: p10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Delivery Instructions"),
              SizedBox(height: 10),
              Row(
                  children: items.map<Widget>((item) {
                return Expanded(
                    flex: items.length,
                    child: GestureDetector(
                        child: Container(
                            padding: p5,
                            margin: pr5,
                            alignment: Alignment.center,
                            decoration: boxRadius.copyWith(
                                color: controller
                                            .activeDeliveryInstruction.value ==
                                        item.id
                                    ? pinkColor
                                    : whiteColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: item.icon!, height: 40),
                                SizedBox(height: 5),
                                Text(
                                  "${item.title}",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                        onTap: () {
                          controller.activeDeliveryInstruction.value != item.id
                              ? controller.activeDeliveryInstruction(item.id)
                              : controller.activeDeliveryInstruction(0);
                          controller.activeDeliveryInstructionText(item.title);
                        }));
              }).toList())
            ],
          ),
        ));
  }
}
