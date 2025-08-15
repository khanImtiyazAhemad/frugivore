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
import 'package:frugivore/models/home.dart';
import 'package:frugivore/controllers/categories.dart';

import 'package:frugivore/connectivity.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
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
                                  CustomTitleBar(title: '', search: true),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TitleCard(
                                                title: 'Shop By Category'),
                                            CategoryContainer(
                                                items: controller.categories)
                                          ])),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class CategoryContainer extends StatelessWidget {
  final List<CategoryList> items;
  const CategoryContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    return Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: plbr10,
        shape: shapeRoundedRectangleBorderBLR,
        child: Obx(() => GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            children: List.generate(controller.categories.length, (index) {
              return Padding(
                padding: p5,
                child: GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: items[index].image!,
                                height: 80,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Text(items[index].name!,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis))
                            ])),
                    onTap: () => "${items[index].id}" == "0"
                        ? Navigator.pushNamed(context, "/frugivore-originals")
                        : Navigator.pushNamed(context,
                                    "/subcategory/${items[index].slug}/${items[index].subcategorySlug}")
                            .then((value) => controller.apicall())),
              );
            }))));
  }
}
