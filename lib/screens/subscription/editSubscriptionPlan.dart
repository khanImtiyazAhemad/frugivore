import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/controllers/subscription/editSubscriptionPlan.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/connectivity.dart';

class EditSubscriptionPlanPage extends StatelessWidget {
  const EditSubscriptionPlanPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomBarButton(),
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
                              : Column(children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TitleCard(
                                                title:
                                                    "Edit Subscription Plan"),
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
                                                          Padding(
                                                            padding: p10,
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Your Wallet Money Balance:"),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    "Rs ${controller.data.moneyBalance}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            primaryColor,
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ]),
                                                          )
                                                        ]))),
                                            OccuranceCard(),
                                            if (controller
                                                    .orderOccurance.value ==
                                                "Custom")
                                              CustomOccuranceCard(),
                                            StartsOnCard(),
                                            EndsOnCard(),
                                            TimeSlotCard(),
                                            DeliveryAddressCard(),
                                            SizedBox(height: 80)
                                          ]))
                                ]));
                    })))));
  }
}

class OccuranceCard extends StatelessWidget {
  const OccuranceCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Obx(() => Card(
          margin: p10,
          shape: roundedCircularRadius,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: p10,
                color: primaryColor,
                child: Text("Order Occurance",
                    style: TextStyle(color: whiteColor, fontSize: 16)),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text("DAILY", style: TextStyle(fontSize: 16)),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "Daily",
                      groupValue: controller.orderOccurance.value,
                      onChanged: (value) {
                        controller.orderOccurance(value.toString());
                      }),
                ),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text("WEEKLY ON ${controller.data.day}",
                      style: TextStyle(fontSize: 16)),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "Weekly",
                      groupValue: controller.orderOccurance.value,
                      onChanged: (value) {
                        controller.orderOccurance(value.toString());
                      }),
                ),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text("MONTHLY ON ${controller.data.dateString}",
                      style: TextStyle(fontSize: 16)),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "Monthly",
                      groupValue: controller.orderOccurance.value,
                      onChanged: (value) {
                        controller.orderOccurance(value.toString());
                      }),
                ),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text("CUSTOM", style: TextStyle(fontSize: 16)),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "Custom",
                      groupValue: controller.orderOccurance.value,
                      onChanged: (value) {
                        controller.orderOccurance(value.toString());
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

class CustomOccuranceCard extends StatelessWidget {
  const CustomOccuranceCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Obx(() => Card(
          margin: p10,
          shape: roundedCircularRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: p10,
                color: primaryColor,
                child: Text("Custom Occurance",
                    style: TextStyle(color: whiteColor, fontSize: 16)),
              ),
              Padding(
                  padding: p10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Repeats Every"),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: p10,
                                  width: 50,
                                  decoration: shapeDecoration,
                                  child: TextField(
                                    controller: controller.repeatsCount,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "1"),
                                  ),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                                flex: 8,
                                child: Container(
                                    height: 40,
                                    decoration: shapeDecoration,
                                    child: Padding(
                                      padding: plr10,
                                      child: DropdownButton(
                                          value: controller
                                              .defaultCustomOccurance.value,
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
                                          underline: Container(height: 0),
                                          iconSize: 30,
                                          items: globals
                                              .subscriptionCustomOccurance
                                              .map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value,
                                                  style: TextStyle(
                                                      fontSize: 14.0)),
                                            );
                                          }).toList(),
                                          onChanged: (val) => controller
                                              .defaultCustomOccurance(val.toString())),
                                    ))),
                          ],
                        ),
                        if (controller.defaultCustomOccurance.value == "Weeks")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text("Repeats on"),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    controller.data.weeks!.map<Widget>((item) {
                                  return GestureDetector(
                                    child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 10),
                                        height: 40,
                                        width: 40,
                                        padding: p10,
                                        decoration: BoxDecoration(
                                          color: controller.selectedWeekDays
                                                  .contains(controller
                                                      .data.weeks
                                                      !.indexOf(item)
                                                      .toString())
                                              ? pinkColor
                                              : Color(0xffd3d3d3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(item[0],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: controller
                                                        .selectedWeekDays
                                                        .contains(controller
                                                            .data.weeks
                                                            !.indexOf(item)
                                                            .toString())
                                                    ? whiteColor
                                                    : null))),
                                    onTap: () =>
                                        controller.changeWeekDays(item),
                                  );
                                }).toList(),
                              )
                            ],
                          )
                        else if (controller.defaultCustomOccurance.value ==
                            "Months")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text("Repeats on", textAlign: TextAlign.start),
                              SizedBox(height: 10),
                              Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: globals.subscriptionCustomMonth
                                    .map<Widget>((item) {
                                  return GestureDetector(
                                    child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        height: 40,
                                        width: 40,
                                        padding: p10,
                                        decoration: BoxDecoration(
                                          color: controller.selectedMonthDate
                                                  .contains(item)
                                              ? pinkColor
                                              : Color(0xffd3d3d3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(item,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: controller
                                                        .selectedMonthDate
                                                        .contains(item)
                                                    ? whiteColor
                                                    : null))),
                                    onTap: () =>
                                        controller.changeMonthDate(item),
                                  );
                                }).toList(),
                              )
                            ],
                          )
                      ]))
            ],
          ),
        ));
  }
}

class StartsOnCard extends StatelessWidget {
  const StartsOnCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Card(
      margin: p10,
      shape: roundedCircularRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: p10,
            color: primaryColor,
            child: Text("Starts On",
                style: TextStyle(color: whiteColor, fontSize: 16)),
          ),
          Padding(
            padding: p10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please select your Order Occurance Start Date"),
                SizedBox(height: 10),
                Container(
                    padding: p10,
                    decoration: shapeDecoration,
                    child: DateTimeField(
                      decoration: InputDecoration.collapsed(
                          hintText: "dd-mm-yyyy(optional)"),
                      mode: DateTimeFieldPickerMode.date,
                      firstDate: controller.startDate,
                      onChanged: (DateTime? value) {
                        controller.startDate = value;
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EndsOnCard extends StatelessWidget {
  const EndsOnCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Obx(() => Card(
          margin: p10,
          shape: roundedCircularRadius,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: p10,
                color: primaryColor,
                child: Text("Ends On",
                    style: TextStyle(color: whiteColor, fontSize: 16)),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text("NEVER", style: TextStyle(fontSize: 16)),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "Never",
                      groupValue: controller.orderEndsOn.value,
                      onChanged: (value) {
                        controller.orderEndsOn(value.toString());
                      }),
                ),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Text("ON", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Container(
                          padding: p10,
                          width: MediaQuery.of(context).size.width * .6,
                          decoration: shapeDecoration,
                          child: DateTimeField(
                            decoration: InputDecoration.collapsed(
                                hintText: "dd-mm-yyyy(optional)"),
                            mode: DateTimeFieldPickerMode.date,
                            firstDate: controller.endsOnDate,
                            onChanged: (DateTime? value) {
                              controller.endsOnDate = value;
                            },
                          )),
                    ],
                  ),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "On",
                      groupValue: controller.orderEndsOn.value,
                      onChanged: (value) {
                        controller.orderEndsOn(value.toString());
                      }),
                ),
              ),
              Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Text("AFTER", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Container(
                        padding: p10,
                        width: 50,
                        decoration: shapeDecoration,
                        child: TextField(
                          // controller: controller,
                          decoration: InputDecoration.collapsed(hintText: "1"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("OCCURANCE", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  leading: Radio(
                      activeColor: pinkColor,
                      value: "After",
                      groupValue: controller.orderEndsOn.value,
                      onChanged: (value) {
                        controller.orderEndsOn(value.toString());
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

class TimeSlotCard extends StatelessWidget {
  const TimeSlotCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Obx(() => Card(
          margin: p10,
          shape: roundedCircularRadius,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: p10,
                color: primaryColor,
                child: Text("Time Slot",
                    style: TextStyle(color: whiteColor, fontSize: 16)),
              ),
              Column(
                children: controller.data.slots!.map<Widget>((item) {
                  return Container(
                    padding: ptb5,
                    decoration: boxDecorationBottomBorder,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.title ?? "", style: TextStyle(fontSize: 16)),
                      leading: Radio(
                          activeColor: pinkColor,
                          value: item.id.toString(),
                          groupValue: controller.orderTimeSlot.value,
                          onChanged: (value) {
                            controller.orderTimeSlot(value.toString());
                          }),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }
}

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Card(
      margin: p10,
      shape: roundedCircularRadius,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: p10,
            color: primaryColor,
            child: Text("Delivery Address",
                style: TextStyle(color: whiteColor, fontSize: 16)),
          ),
          Padding(
            padding: p10,
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Text(controller.data.subscription!.completeAddress ?? ""),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/address-list").then(
                              (value) => controller.apicall(controller.uuid))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomBottomBarButton extends StatelessWidget {
  const CustomBottomBarButton({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(EditSubscriptionPlanController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: customElevatedButton(pinkColor, whiteColor).copyWith(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text("Update Plan"),
                  ],
                ),
                onPressed: () => controller.updateSubscriptionPlan(),
              ),
            )),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: customElevatedButton(packageColor, whiteColor)
                          .copyWith(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money),
                          SizedBox(width: 5),
                          Text("Make Payment")
                        ],
                      ),
                      onPressed: () => Navigator.pushNamed(context,
                              "/recharge/${controller.data.minimumWalletRequirement}")
                          .then(
                              (value) => controller.apicall(controller.uuid)))),
            ),
          ],
        ),
      ],
    );
  }
}
