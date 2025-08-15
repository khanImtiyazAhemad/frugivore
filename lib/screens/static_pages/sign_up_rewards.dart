import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/controllers/staticPages/signUpRewards.dart';

import 'package:frugivore/connectivity.dart';


class SignUpRewardsPage extends StatelessWidget {
  const SignUpRewardsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpRewardsController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child:  NetworkSensitive(
              child:Container(
                color: bodyColor,
                height : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: controller.isLoader.value
                          ? Loader()
                          : Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Card(
                                  margin: plr10,
                                  shape: roundedCircularRadius,
                                  child: Padding(
                                      padding: p20,
                                      child: Column(children: [
                                        CachedNetworkImage(imageUrl:
                                          controller.data.banner ?? "",
                                          fit: BoxFit.cover
                                        ),
                                        Html(data: controller.data.content)
                                      ])))));
                })))));
  }
}
