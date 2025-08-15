import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/staticPages/faq.dart';
import 'package:frugivore/controllers/staticPages/faq.dart';

import 'package:frugivore/connectivity.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FAQController());
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
                                  CustomTitleBar(title: "FAQs", search: false),
                                  Card(
                                      margin: plr10,
                                      shape: roundedCircularRadius,
                                      child: Padding(
                                          padding: p10,
                                          child: Column(children: [
                                            Image.asset(
                                                "assets/images/largeFaq.png",
                                                height: 40),
                                            SizedBox(height: 10),
                                            SizedBox(
                                                width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: controller
                                                      .faq.data
                                                      !.map<Widget>((item) {
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(item.name ?? "",
                                                              style: TextStyle(
                                                                  color:
                                                                      primaryColor)),
                                                          SizedBox(
                                                              height: 10),
                                                          ExpansionListCard(
                                                              items:
                                                                  item.tag!),
                                                          SizedBox(
                                                              height: 10),
                                                        ]);
                                                  }).toList(),
                                                ))
                                          ])))
                                ]));
                    })))));
  }
}

class ExpansionListCard extends StatelessWidget {
  final List<Tag> items;
  const ExpansionListCard({super.key, required  this.items});
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FAQController());
    return Column(
      children: items.map((item) {
        return Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: p10,
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(0xffe6e6e6),
                      child: Row(children: [
                        Expanded(flex: 9, child: Text(item.question!)),
                        Expanded(
                            flex: 1,
                            child: item.id.toString() ==
                                    controller.clickedQuestion.value
                                ? Icon(Icons.remove)
                                : Icon(Icons.add))
                      ]),
                    ),
                    onTap: () =>
                        item.id.toString() != controller.clickedQuestion.value
                            ? controller.clickedQuestion(item.id.toString())
                            : controller.clickedQuestion("")),
                Visibility(
                    visible:
                        item.id.toString() == controller.clickedQuestion.value,
                    child: Padding(padding: p10, child: Text(item.answer!)))
              ],
            ));
      }).toList(),
    );
  }
}
