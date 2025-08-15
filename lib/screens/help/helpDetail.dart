import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/picker.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/help/helpDetail.dart';
import 'package:frugivore/controllers/help/helpDetail.dart';

import 'package:frugivore/connectivity.dart';
import 'dart:convert' show utf8;


class HelpDetailPage extends StatelessWidget {
  const HelpDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpDetailController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Container(
        color: whiteColor,
        child: Stack(children: [
          SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: NetworkSensitive(
              child: Container(
                color: whiteColor,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                    controller: controller.scrollController,
                    scrollDirection: Axis.vertical,
                    child: controller.isLoader.value
                        ? Loader()
                        : Column(children: [
                            CustomTitleBar(
                                title: "Complaint Detail", search: false),
                            Container(
                                color: whiteColor,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                    padding: plbr20,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: controller.data.data
                                                                !.image !=
                                                            null &&
                                                        controller.data.data
                                                                !.image !=
                                                            ""
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                controller
                                                                    .data
                                                                    .data
                                                                    !.image ?? ""),
                                                        radius: 30.0)
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        child: Text(
                                                            controller.data.data!.topic![0],
                                                            style: TextStyle(
                                                                fontSize: 40.0,
                                                                color: Colors
                                                                    .white)),
                                                      )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      controller
                                                          .data.data!.topic ?? "",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Text(
                                                      "Current Status: ${controller.data.data!.issueStatus}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Column(
                                          children: controller
                                              .data.data!.complaints
                                              !.map<Widget>((item) {
                                            return item.isSender!
                                                ? SenderMessageContainer(
                                                    item: item)
                                                : ReceiverMessageContainer(
                                                    item: item);
                                          }).toList(),
                                        ),
                                        SizedBox(height: 10),
                                        if (controller.data.message != null)
                                          Center(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                padding: p10,
                                                color: yellowColor,
                                                child: Text(
                                                  controller.data.message ?? "",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: whiteColor,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),
                                          )
                                      ],
                                    ))),
                            SizedBox(height: 60)
                          ]),
                  );
                }),
              ),
            ),
          ),
          Obx(() {
            return controller.isLoader.value
                ? SizedBox()
                : Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: MessageContainer());
          })
        ]),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpDetailController());
    return Obx(() => Container(
        child: controller.data.data!.issueStatus == "CLOSURE"
            ? GestureDetector(
                child: Container(
                  padding: p10,
                  color: pinkColor,
                  child: Text("NOT SATISFIED ? ESCALATED",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: whiteColor, fontWeight: FontWeight.w600)),
                ),
                onTap: () => showDialog(
                      context: context,
                      builder: (_) => EscalationReason(),
                      barrierDismissible: true,
                    ))
            : controller.data.data!.issueStatus == "ESCLATED AND RESOLVED"
                ? GestureDetector(
                    child: Container(
                      padding: p10,
                      color: pinkColor,
                      child: Text("NOT SATISFY RAISE TO HIGHER AUTHORITY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    onTap: () => showDialog(
                          context: context,
                          builder: (_) => EscalationToHigherAuthority(),
                          barrierDismissible: true,
                        ))
                : Container(
                    padding: p10,
                    color: bodyColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.photo_camera,
                                    color: primaryColor),
                                onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) =>
                                          Picker(image: controller.image!),
                                      barrierDismissible: true,
                                    ).then((_) {
                                      controller
                                          .apicall(HelpDetailController.uuid);
                                    }))),
                        SizedBox(width: 10),
                        Expanded(
                            flex: 8,
                            child: TextField(
                                minLines: 1,
                                maxLines: 3,
                                controller: controller.message,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Type your message..."))),
                        SizedBox(width: 10),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.near_me, color: primaryColor),
                                onPressed: () => controller.sendMessage()))
                      ],
                    ),
                  )));
  }
}


class SenderMessageContainer extends StatelessWidget {
  final Complaint item;
  const SenderMessageContainer({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: ptb5,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.attachment != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: CachedNetworkImage(
                          imageUrl: item.attachment,
                        ))
                    : Container(
                        padding: p10,
                        decoration:
                            boxRadius.copyWith(color: Color(0xffCD6155)),
                        child: Text(utf8.decode(item.message!.trim().codeUnits),
                            style: TextStyle(color: whiteColor)),
                      ),
                SizedBox(height: 5),
                Text(item.createdAt!, style: TextStyle(fontSize: 12))
              ],
            )));
  }
}

class ReceiverMessageContainer extends StatelessWidget {
  final Complaint item;
  const ReceiverMessageContainer({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: ptb5,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                item.attachment != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: CachedNetworkImage(
                          imageUrl: item.attachment,
                        ))
                    : Container(
                        padding: p10,
                        color: Color(0xffF0F3F4),
                        child: Text(utf8.decode(item.message!.trim().codeUnits), textAlign: TextAlign.end),
                      ),
                SizedBox(height: 5),
                Text(item.createdAt!, style: TextStyle(fontSize: 12))
              ],
            )));
  }
}

class EscalationReason extends StatelessWidget {
  const EscalationReason({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpDetailController());
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        actionsPadding: EdgeInsets.all(10),
        title: Text('Escalation Reason', textAlign: TextAlign.center),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              padding: p10,
              decoration: shapeDecoration,
              child: TextField(
                  maxLines: 3,
                  controller: controller.reason,
                  decoration: InputDecoration.collapsed(
                      hintText: "Escalation Reason"))),
          SizedBox(height: 10),
          SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text('SUBMIT'),
                  onPressed: () => controller.escalateIssue()))
        ]));
  }
}

class EscalationToHigherAuthority extends StatelessWidget {
  const EscalationToHigherAuthority({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        actionsPadding: EdgeInsets.all(10),
        title:
            Image.asset("assets/images/logo.png", height: 50),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Write to our CEO at mk@frugivore.in",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop()))
        ]));
  }
}
