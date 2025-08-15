import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/utils.dart';

import 'package:frugivore/controllers/vendor.dart';

import 'package:frugivore/connectivity.dart';

class VendorPage extends StatelessWidget {
  const VendorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorController());
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
                                hasInformationData(),
                                CustomTitleBar(
                                    title: "Search Result", search: true),
                                Card(
                                  margin: plr10,
                                  shape: roundedCircularRadius,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/Zappfresh.jpeg'),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: p10,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                        Get.context!,
                                                        controller.route!)
                                                    .then((value) =>
                                                        controller
                                                            .apicall()),
                                            style: customElevatedButton(
                                                pinkColor, whiteColor),
                                            child: Text("OK")),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 80)
                              ]));
                    })))));
  }
}
