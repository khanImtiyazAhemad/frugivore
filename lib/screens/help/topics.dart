import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/screens/utils.dart';
import 'package:frugivore/screens/order/myOrder.dart';

import 'package:frugivore/controllers/help/topics.dart';

import 'package:frugivore/connectivity.dart';

class HelpTopicsPage extends StatelessWidget {
  const HelpTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopicsController());
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
                                          title: "Help", search: false),
                                      if (controller.data.lastOrder != null)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: plr10,
                                                child: Text("Your last order",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            OrderCard(
                                                item:
                                                    controller.data.lastOrder),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      AllTopics(),
                                      SizedBox(height: 80)
                                    ]));
                    })))));
  }
}

class AllTopics extends StatelessWidget {
  const AllTopics({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopicsController());
    return Column(
      children: [
        TitleCard(title: "All Topics"),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Card(
                    margin: plr10,
                    shape: roundedCircularRadius,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.data.data!.map<Widget>((item) {
                        return GestureDetector(
                          child: Container(
                            padding: ptlr10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Expanded(
                                    //     flex: 2,
                                    //     child: CachedNetworkImage(
                                    //         imageUrl: item.icon)),
                                    // SizedBox(width: 10),
                                    Expanded(flex: 7, child: Text(item.topic)),
                                    Expanded(
                                        flex: 1,
                                        child: Image.asset(
                                            'assets/images/blackBackArrow.png',
                                            height: 12))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(height: 1, color: Colors.black)
                              ],
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, item.redirection.toString(),
                              arguments: [item.topic]),
                        );
                      }).toList(),
                    )),
                    ComplaintsHistorySection(ongoing:controller.ongoing!, past:controller.past!)
              ],
            ))
      ],
    );
  }
}
