import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/models/staticPages/blogs.dart';
import 'package:frugivore/controllers/staticPages/blogs.dart';

import 'package:frugivore/connectivity.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogsController());
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
                              : Column(children: [
                                  SizedBox(height: 10),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Padding(
                                              padding: p10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Text(
                                                      controller
                                                          .data.latest!.title ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  SizedBox(height: 10),
                                                  Divider(color: borderColor),
                                                  CachedNetworkImage(
                                                      imageUrl: controller
                                                          .data.latest!.image ?? ""),
                                                  Html(
                                                      data: controller
                                                              .showLess.value
                                                          ? controller
                                                              .data
                                                              .latest
                                                              !.description ?? "".substring(0, 500)
                                                          : controller
                                                              .data
                                                              .latest
                                                              !.description ?? ""),
                                                  SizedBox(height: 5),
                                                  GestureDetector(
                                                    onTap: () => controller
                                                            .showLess.value
                                                        ? controller
                                                            .showLess(false)
                                                        : controller
                                                            .showLess(true),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            controller.showLess
                                                                    .value
                                                                ? "Show More"
                                                                : "Show Less",
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor)),
                                                        SizedBox(height: 5),
                                                        FaIcon(
                                                            controller.showLess
                                                                    .value
                                                                ? FontAwesomeIcons
                                                                    .anglesDown
                                                                : FontAwesomeIcons
                                                                    .anglesUp,
                                                            color: primaryColor,
                                                            size: 18)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  BlogCard(
                                                      blogs:
                                                          controller.data.blogs!)
                                                ],
                                              )))),
                                  SizedBox(height: 150)
                                ]));
                    })))));
  }
}

class BlogCard extends StatelessWidget {
  final List<Latest> blogs;
  const BlogCard({super.key, required  this.blogs});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogsController());
    return Column(
        children: blogs.map((item) {
      return GestureDetector(
        onTap: () => controller.apicall(item.title),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: CachedNetworkImage(imageUrl: item.image!),
            ),
            SizedBox(width: 10),
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title!,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                        height: 80,
                        child: Html(
                          data: item.description!.substring(0, 100),
                        )),
                    ElevatedButton(
                      style: customElevatedButton(orangeColor, whiteColor),
                      onPressed: () => controller.apicall(item.title),
                      child: Text("Read More"),
                    )
                  ],
                )),
          ],
        ),
      );
    }).toList());
  }
}
