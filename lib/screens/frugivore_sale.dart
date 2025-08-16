import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_card.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/controllers/frugivoreSale.dart';

import 'package:frugivore/connectivity.dart';

class FrugivoreSalePage extends StatelessWidget {
  const FrugivoreSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrugivoreSaleController());
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(
            controller: controller),
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
                                      title: controller.data.title, search: true),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TitleCard(
                                            title: controller.data.title ?? ""),
                                        Card(
                                            shadowColor: Colors.transparent,
                                            margin: plr10,
                                            shape:
                                                shapeRoundedRectangleBorderBLR,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: controller
                                                                .data
                                                                .banners
                                                                !.isNotEmpty
                                                        ? CarouselSlider(
                                                            options:
                                                                CarouselOptions(
                                                                    autoPlay:
                                                                        true,
                                                                    viewportFraction:
                                                                        1),
                                                            items: controller
                                                                .data.banners
                                                                !.map<Widget>(
                                                                    (item) {
                                                              return Builder(builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return CachedNetworkImage(
                                                                    imageUrl:
                                                                        item,
                                                                    fit: BoxFit
                                                                        .fill);
                                                              });
                                                            }).toList())
                                                        : Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            child: Text(
                                                              "No Sale is running at this moment",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                SizedBox(height: 10),
                                                if (controller
                                                        .data.titles!.isNotEmpty)
                                                  ScrollableCategory(),
                                                controller.data.data!.products!.isNotEmpty
                                                    ? Column(
                                                        children: controller.data.data!.products!.map<Widget>((item) {
                                                        return ProductCard(
                                                            item: item,
                                                            activePackage: SelectDefaultPackage(
                                                                    items: item
                                                                        .productPackage!)
                                                                .defaultPackage());
                                                      }).toList(),
                                                      )
                                                    : Container(
                                                      padding: EdgeInsets.all(20),
                                                        child: Text(
                                                            "No Product Available at this Moment"),
                                                      ),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class ScrollableCategory extends StatelessWidget {
  const ScrollableCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrugivoreSaleController());
    return SingleChildScrollView(
        controller: controller.horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: Padding(
            padding: plr10,
            child: Row(
                children: controller.data.titles!.map<Widget>((item) {
              return GestureDetector(
                  child: Container(
                    padding: p10,
                    decoration: controller.data.data!.title == item.title
                        ? BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: primaryColor)))
                        : null,
                    child: Text(item.title!),
                  ),
                  onTap: () => controller.apicall(item.slug));
            }).toList())));
  }
}
