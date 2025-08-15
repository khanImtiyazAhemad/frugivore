import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/controllers/offers/cashback.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/screens/utils.dart';

import 'package:frugivore/connectivity.dart';

class CashbackPage extends StatelessWidget {
  const CashbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CashbackController());
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
                                  CustomTitleBar(
                                      title: "Cashback", search: false),
                                  controller.data.isNotEmpty
                                      ? Column(
                                          children: controller.data
                                              .map<Widget>((item) {
                                            return OfferContainer(item: item);
                                          }).toList(),
                                        )
                                      : Padding(
                                        padding: plr10,
                                        child: Image.asset(
                                            'assets/images/welcome.jpeg'),
                                      ),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}
