import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/controllers/recipe/recipeShopping.dart';

import 'package:frugivore/connectivity.dart';


class RecipeShoppingPage extends StatelessWidget {
  const RecipeShoppingPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(RecipeShoppingController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: MoveToCartButton(),
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
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                TitleCard(title: "${controller.data.name}"),
                                Card(
                                    margin: plr10,
                                    shape: shapeRoundedRectangleBorderBLR,
                                    child: IngredientCard()),
                                    SizedBox(height:60)
                              ])));
                })))));
  }
}

class IngredientCard extends StatefulWidget {
  const IngredientCard({super.key});

  @override
  IngredientCardState createState() => IngredientCardState();
}

class IngredientCardState extends State<IngredientCard> {
  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(RecipeShoppingController());
    return Column(
        children: controller.data.recipe!.map<Widget>((item) {
      return Container(
          padding: p10,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: borderColor, width: 1))),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      checkColor: whiteColor,
                      activeColor: packageColor,
                      value: item.checkboxValue,
                      onChanged: (val) => setState(() {
                        item.checkboxValue = val;
                      }),
                    ))),
            Expanded(
                flex: 2,
                child: CachedNetworkImage(imageUrl: item.package!.imgOne ?? "")),
            SizedBox(width: 5),
            Expanded(
                flex: 7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${item.product!.brand ?? ""} - ${item.product!.name ?? ""}"),
                      Text("${item.package!.name ?? ""} X ${item.quantity}")
                    ]))
          ]));
    }).toList());
  }
}

class MoveToCartButton extends StatelessWidget {
  const MoveToCartButton({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(RecipeShoppingController());
    return GestureDetector(
      child: Container(
        padding: p10,
        color: packageColor,
        height: 40,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.shopping_cart, color: whiteColor),
          SizedBox(width: 10),
          Text("Move to Cart",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.w600))
        ]),
      ),
      onTap: () => controller.moveToCart(),
    );
  }
}
