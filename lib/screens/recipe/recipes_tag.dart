import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/controllers/recipe/recipesTag.dart';

import 'package:frugivore/connectivity.dart';

class RecipesTagPage extends StatelessWidget {
  const RecipesTagPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipesTagController());
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
                                  TitleCard(title: "Recipe's Category"),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: shapeRoundedRectangleBorderBLR,
                                          child: GridView.count(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0,
                                              shrinkWrap: true,
                                              children: List.generate(
                                                  controller.data.length,
                                                  (index) {
                                                final item =
                                                    controller.data[index];
                                                return GestureDetector(
                                                  child: Container(
                                                    padding: p10,
                                                    child: Column(
                                                      children: [
                                                        CachedNetworkImage(
                                                            imageUrl:
                                                                item.image!, width: 70),
                                                        SizedBox(height: 5),
                                                        Text(item.name!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () => Navigator.pushNamed(
                                                          context,
                                                          "/recipes/${item.name}")
                                                      .then((value) =>
                                                          controller.apicall()),
                                                );
                                              }))))
                                ]));
                    })))));
  }
}
