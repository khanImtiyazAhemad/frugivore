import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/controllers/help/archives.dart';

import 'package:frugivore/connectivity.dart';

class ArchivesPage extends StatelessWidget {
  const ArchivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArchivesController());
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
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      CustomTitleBar(
                                          title: "Archive", search: false),
                                      Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: controller.data.results
                                                  !.map<Widget>((item) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      item.unreadCount = 0;
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/help-detail/${item.complaintId}");
                                                    },
                                                    child: Container(
                                                        padding: ptlr10,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 8,
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text("#${item.issueId}",
                                                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            Text(item.topic ?? ""),
                                                                            Text(
                                                                              item.dateOfComplaint ?? "",
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: item.unreadCount! >
                                                                              0
                                                                          ? Container(
                                                                              height: 20,
                                                                              width: 20,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: skyBlueColor, shape: BoxShape.circle),
                                                                              child: Text(item.unreadCount.toString(), textAlign: TextAlign.center, style: TextStyle(color: whiteColor, fontSize: 11)),
                                                                            )
                                                                          : SizedBox()),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: Image.asset(
                                                                          'assets/images/blackBackArrow.png',
                                                                          height:
                                                                              12)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Divider(
                                                                  height: 1,
                                                                  color: Colors
                                                                      .black)
                                                            ])));
                                              }).toList())),
                                      SizedBox(height: 80)
                                    ]));
                    })))));
  }
}
