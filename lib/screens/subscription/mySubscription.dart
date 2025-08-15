import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/subscription/mySubscription.dart';
import 'package:frugivore/controllers/subscription/mySubscription.dart';

import 'package:frugivore/connectivity.dart';

class MySubscriptionPage extends StatelessWidget {
  const MySubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MySubscriptionController());
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
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: "Subscribed Shopping Lists",
                                      search: false),
                                  Padding(
                                      padding: plr10,
                                      child: Image.asset(
                                          'assets/images/subscription.jpg')),
                                  if (controller.results.isEmpty)
                                    Padding(
                                      padding: p10,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: ElevatedButton(
                                              style:
                                                  customNonSlimmerElevatedButton(
                                                      pinkColor, whiteColor),
                                              child: Text(
                                                  '+ Create a new Shopping List'),
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      "/my-shopping-lists",
                                                      arguments: ['new']),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: 40,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: ElevatedButton(
                                              style:
                                                  customNonSlimmerElevatedButton(
                                                      pinkColor, whiteColor),
                                              child: Text(
                                                  'Subscribed from available Shopping List'),
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      "/my-shopping-lists",
                                                      arguments: []),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Column(
                                      children: [
                                        Column(
                                          children: controller.results
                                              .map<Widget>((item) {
                                            return SubscriptionCard(
                                                item: item);
                                          }).toList(),
                                        ),
                                        SizedBox(height: 10),
                                        controller.wait.value
                                            ? CircularProgressIndicator()
                                            : Obx(() => Text(
                                                "Page ${controller.subscription.page}/${controller.subscription.maxPage}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ],
                                    ),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class SubscriptionCard extends StatelessWidget {
  final Result item;
  const SubscriptionCard({super.key, required  this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MySubscriptionController());
    return Card(
        margin: p10,
        shape: roundedCircularRadius,
        child: Column(children: [
          Padding(
            padding: p20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.shoppinglistName!,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600)),
                    Text("Items Subscribed: ${item.totalItems}",
                        style: TextStyle(fontSize: 12)),
                    SizedBox(height: 15),
                    Text("Subscription Starts On: ${item.startsOn}",
                        style: TextStyle(fontSize: 12)),
                    Text("Occurance: ${item.occurance}",
                        style: TextStyle(fontSize: 12)),
                    Text(item.message!),
                    if (item.endsOn != null)
                      Text("Occurance: ${item.endsOn}",
                          style: TextStyle(fontSize: 12)),
                    SizedBox(height: 15),
                    Text("Created On: ${item.createdAt}",
                        style: TextStyle(fontSize: 12)),
                    Text("Last Updated On: ${item.updatedAt}",
                        style: TextStyle(fontSize: 12)),
                  ]),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          style: customElevatedButton(pinkColor, whiteColor)
                              .copyWith(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero))),
                          onPressed: () => controller.editValidation(
                              item.shoppinglistUuid, item.uuid),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: whiteColor),
                                SizedBox(width: 10),
                                Text("Edit Plan")
                              ])))),
              Expanded(
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          style: customElevatedButton(
                                  item.isActive! ? backgroundGrey : skyBlueColor,
                                  whiteColor)
                              .copyWith(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero))),
                          child: item.isActive!
                              ? Text("Deactivate Now")
                              : Text("Activate Now"),
                          onPressed: () =>
                              controller.validation(item.shoppinglistUuid, item))))
            ],
          ),
          SizedBox(
              height: 40,
              child: ElevatedButton(
                  style: customElevatedButton(orangeColor, whiteColor).copyWith(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  onPressed: () => Navigator.pushNamed(
                          context, "/subscription-detail/${item.uuid}")
                      .then((value) => controller.apicall()),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info, color: whiteColor),
                        SizedBox(width: 10),
                        Text("Subscription Details")
                      ])))
        ]));
  }
}

class ActivateSubscriptionPopUp extends StatelessWidget {
  final Result item;
  const ActivateSubscriptionPopUp({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MySubscriptionController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text('Activate Subscription',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 14))),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Do you want to Activate this Subscription Plan?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        style: customElevatedButton(pinkColor, whiteColor),
                        child: Text('ACTIVATE NOW'),
                        onPressed: () => controller.activatePlan(item.uuid))),
              ),
              SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        child: Text('CANCEL'),
                        onPressed: () => Navigator.of(context).pop())),
              ),
            ],
          )
        ]));
  }
}

class DeactivateSubscriptionPopUp extends StatelessWidget {
  final Result item;
  const DeactivateSubscriptionPopUp({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MySubscriptionController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text('Deactivate Subscription',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 14))),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Do you want to Deactivate this Subscription Plan?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        style: customElevatedButton(pinkColor, whiteColor),
                        child: Text('DEACTIVATE NOW'),
                        onPressed: () => controller.deactivatePlan(item.uuid))),
              ),
              SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        child: Text('CANCEL'),
                        onPressed: () => Navigator.of(context).pop())),
              ),
            ],
          )
        ]));
  }
}
