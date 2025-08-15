import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/screens/utils.dart';

import 'package:frugivore/controllers/help/subsubTopics.dart';

import 'package:frugivore/connectivity.dart';

class HelpSubSubTopicsPage extends StatelessWidget {
  const HelpSubSubTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubSubTopicsController());
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
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: controller.title!, search: false),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: controller.data
                                                .map<Widget>((item) {
                                              return GestureDetector(
                                                child: Container(
                                                  padding: ptlr10,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(flex:9,child: Text(item.subSubTopic!)),
                                                          Expanded(flex:1,child: Image.asset('assets/images/blackBackArrow.png', height: 12)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Divider(
                                                          height: 1,
                                                          color: Colors.black)
                                                    ],
                                                  ),
                                                ),
                                                onTap: () => Navigator.pushNamed(
                                                      context,
                                                      "/help-subtopic-detail/${item.uuid}", arguments: [true, controller.orderId]),
                                              );
                                            }).toList(),
                                          ))),
                                          ComplaintsHistorySection(ongoing:controller.ongoing!, past:controller.past!)
                                ]));
                    })))));
  }
}
