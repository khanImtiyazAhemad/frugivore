import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/notification.dart';
import 'package:frugivore/controllers/notification.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/connectivity.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
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
                                      title: "Alerts & Notifications",
                                      search: false),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: controller
                                                      .data.results!.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: controller.results
                                                      .map<Widget>((item) {
                                                    return NotificationsCard(
                                                        item: item);
                                                  }).toList())
                                              : Container(
                                                  padding: p20,
                                                  child: Text(
                                                      "No Alerts & Notification Found at this Moment",
                                                      textAlign:
                                                          TextAlign.center)))),
                                  SizedBox(height: 10),
                                  controller.wait.value
                                      ? CircularProgressIndicator()
                                      : Obx(() => Text(
                                          "Page ${controller.data.page}/${controller.data.maxPage}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class NotificationsCard extends StatelessWidget {
  final Result item;
  const NotificationsCard({super.key, required  this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    return GestureDetector(
        child: Column(
          children: [
            if (item.image != null && item.image != "")
              CachedNetworkImage(
                  imageUrl: item.image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
            Container(
                padding: p10,
                decoration: BoxDecoration(
                    color: item.isRead! ? whiteColor : Color(0xffE6B0AA),
                    border: Border(
                      bottom: BorderSide(color: borderColor, width: 1),
                    )),
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: whiteColor),
                          padding: p5,
                          child: notificationLogo(item.notificationType))),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(utf8convert(item.title!),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(utf8convert(item.message!.replaceAll("\n", "")),
                            style: TextStyle(fontSize: 12)),
                        Text(item.createdAt!, style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: FaIcon(getIconFromCss('fat fa-trash-can'), color: primaryColor, size: 24),
                      onPressed: () => controller.deleteNotification(item.id),
                    ),
                  )
                ])),
          ],
        ),
        onTap: () => controller.readNotification(item.id, item.redirect));
  }
}
