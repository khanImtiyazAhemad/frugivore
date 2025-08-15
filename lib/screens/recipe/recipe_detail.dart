import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/recipe/recipeDetail.dart';
import 'package:frugivore/controllers/recipe/recipeDetail.dart';

import 'package:frugivore/connectivity.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeDetailController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: ShopFromRecipeButton(),
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
                                  TitleCard(title: controller.data.name ?? ""),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: shapeRoundedRectangleBorderBLR,
                                          child: Padding(
                                              padding: plr10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (controller.data.image !=
                                                      null)
                                                    CachedNetworkImage(
                                                        imageUrl: controller
                                                            .data.image ?? ""),
                                                  controller.staticText(
                                                      "Description"),
                                                  Text(controller
                                                      .data.description ?? ""),
                                                  controller.staticText(
                                                      "Cooking Steps"),
                                                  Html(
                                                      data: controller
                                                          .data.steps),
                                                  controller
                                                      .staticText("Cuisine"),
                                                  Text(
                                                      "${controller.data.cuisine}"),
                                                  controller
                                                      .staticText("Cooking"),
                                                  Text(
                                                      "${controller.data.cooking} Minutes"),
                                                  controller.staticText(
                                                      "Preparation"),
                                                  Text(
                                                      "${controller.data.preparation} Minutes"),
                                                  controller
                                                      .staticText("Serving"),
                                                  Text(
                                                      "${controller.data.serving} Adults"),
                                                  controller.staticText(
                                                      "Ingredients List"),
                                                  Column(
                                                    children: controller
                                                        .data.recipe
                                                        !.map<Widget>((item) {
                                                      return Column(children: [
                                                        IngredientCard(
                                                            item: item),
                                                        Divider(
                                                            color: borderColor)
                                                      ]);
                                                    }).toList(),
                                                  )
                                                ],
                                              )))),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class IngredientCard extends StatelessWidget {
  final Recipe item;
  const IngredientCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 2, child: CachedNetworkImage(imageUrl: item.package!.imgOne!)),
      SizedBox(width: 5),
      Expanded(
        flex: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${item.product!.brand} - ${item.product!.name}"),
            Text("${item.package!.name} X ${item.quantity}")
          ],
        ),
      ),
    ]);
  }
}

class ShopFromRecipeButton extends StatelessWidget {
  const ShopFromRecipeButton({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeDetailController());
    return GestureDetector(
      child: Container(
        padding: p10,
        color: packageColor,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, color: whiteColor),
            SizedBox(width: 10),
            Text("Shop from Recipe",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(
              context, "/recipe-shopping/${controller.data.uuid}")
          .then((value) => controller.apicall(controller.uuid)),
    );
  }
}
