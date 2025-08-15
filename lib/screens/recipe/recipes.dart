import 'package:frugivore/models/recipe/recipes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/controllers/recipe/recipes.dart';

import 'package:frugivore/connectivity.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipesController());
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
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(children: [
                                    TitleCard(
                                        title:
                                            "${controller.name} Recipe's List"),
                                    Column(
                                      children: controller.data.map((item) {
                                        return RecipeCard(item: item);
                                      }).toList(),
                                    ),
                                    SizedBox(height: 120),
                                  ])));
                    })))));
  }
}

class RecipeCard extends StatelessWidget {
  final RecipesModel item;
  const RecipeCard({super.key, required  this.item});
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipesController());
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Card(
                elevation: 0.1,
                margin: plr10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Column(children: [
                  Padding(
                      padding: p20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.image != null)
                            CachedNetworkImage(imageUrl: item.image!),
                          SizedBox(height: 10),
                          Text(
                            "Name: ${item.name}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text("Cuisine: ${item.cuisine}"),
                          SizedBox(height: 5),
                          Text("Preparation: ${item.preparation} Mins"),
                          SizedBox(height: 5),
                          Text("Serving: ${item.serving} Adults"),
                        ],
                      )),
                  Row(
                                      children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          style: customElevatedButton(pinkColor, whiteColor)
                              .copyWith(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.zero))),
                          onPressed: () => Navigator.pushNamed(
                                  context, "/recipe-detail/${item.uuid}")
                              .then(
                                  (value) => controller.apicall(controller.name)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove_red_eye,
                                    color: whiteColor),
                                SizedBox(width: 10),
                                Text("View Recipe")
                              ])),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: customElevatedButton(
                                packageColor, whiteColor)
                            .copyWith(
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                        onPressed: () => Navigator.pushNamed(
                                context, "/recipe-shopping/${item.uuid}")
                            .then((value) =>
                                controller.apicall(controller.name)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart, color: whiteColor),
                              SizedBox(width: 10),
                              Text("Shop from Recipe")
                            ]),
                      ),
                    ),
                  )
                                      ],
                                    )
                ])),
            SizedBox(height: 10)
          ],
        ));
  }
}
