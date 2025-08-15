import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_card.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/models/offers/deals.dart';
import 'package:frugivore/controllers/offers/deals.dart';

import 'package:frugivore/connectivity.dart';


class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DealsController());
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
                child:Container(
                color: bodyColor,
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: controller.isLoader.value
                          ? Loader()
                          : Column(children: [
                              CustomTitleBar(title: "Deals", search: true),
                              Column(
                                children: controller.data.map<Widget>((item) {
                                  return OfferContainer(item: item);
                                }).toList(),
                              ),
                              SizedBox(height: 80)
                            ]));
                })))));
  }
}

class OfferContainer extends StatelessWidget {
  final DealsModel item;
  const OfferContainer({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleCard(title: item.title!),
        Card(
            margin: plr10,
            shape: shapeRoundedRectangleBorderBLTL,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.image != null)
                        CachedNetworkImage(imageUrl: item.image!),
                      Padding(
                          padding: plr10,
                          child: Column(
                            children: item.products!.map<Widget>((item) {
                              return ProductCard(
                                item: item,
                                activePackage: SelectDefaultPackage(
                                        items: item.productPackage!)
                                    .defaultPackage(),
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 10),
                    ])))
      ],
    );
  }
}
