import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/filter.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_card.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/controllers/frugivoreOriginals.dart';

import 'package:frugivore/connectivity.dart';

class FrugivoreOriginalsPage extends StatelessWidget {
  const FrugivoreOriginalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrugivoreOriginalsController());
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(),
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
                                      title: "Frugivore Originals",
                                      search: true),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TitleCard(
                                            title: "Frugivore Originals"),
                                        Card(
                                            shadowColor: Colors.transparent,
                                            margin: plr10,
                                            shape:
                                                shapeRoundedRectangleBorderBLR,
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomFilterContainer(
                                                          count: controller
                                                              .data.count,
                                                          text: "Products",
                                                          categories: controller
                                                              .data.categories,
                                                          subcategories:
                                                              controller.data
                                                                  .subCategories,
                                                          brands: controller.data.brands,
                                                          callback: controller.apicall,
                                                          ),
                                                      Column(
                                                        children: controller
                                                            .results
                                                            .map((item) {
                                                          return ProductCard(
                                                            item: item,
                                                            activePackage: SelectDefaultPackage(
                                                                    items: item
                                                                        .productPackage!)
                                                                .defaultPackage(),
                                                          );
                                                        }).toList(),
                                                      )
                                                    ]))),
                                      ]),
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
