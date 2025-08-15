import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/shoppingList/shoppingListDetail.dart';
import 'package:frugivore/controllers/shoppingList/shoppingListDetail.dart';

import 'package:frugivore/connectivity.dart';

class ShoppingListDetailPage extends StatelessWidget {
  const ShoppingListDetailPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(ShoppingListDetailController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: Obx(() => controller.isLoader.value
            ? SizedBox(height: 0)
            : CustomBottomBarButton()),
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
                                      title: "Shopping List Detail",
                                      search: false),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: shapeRoundedRectangleBorderBLR,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffB3B6B7),
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: whiteColor,
                                                          width: 1),
                                                    )),
                                                padding: p10,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Name: ${controller.data.name}",
                                                          style: TextStyle(
                                                              color: whiteColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      if (controller.data
                                                              .description !=
                                                          null)
                                                        Text(
                                                            "${controller.data.description}",
                                                            style: TextStyle(
                                                              color: whiteColor,
                                                            )),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          "Total no of Items: ${controller.data.totalItems}",
                                                          style: TextStyle(
                                                              color:
                                                                  whiteColor))
                                                    ]),
                                              ),
                                              Column(
                                                  children: controller
                                                      .data.shoppingListItems
                                                      !.map<Widget>((item) {
                                                return ShoppingListItemsContainer(
                                                    item: item);
                                              }).toList()),
                                            ],
                                          )))
                                ]));
                    })))));
  }
}

class ShoppingListItemsContainer extends StatelessWidget {
  final ShoppingListItem item;
  const ShoppingListItemsContainer({super.key, required  this.item});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: backgroundGrey,
        padding: p10,
        child: Text(item.name!),
      ),
      Padding(
          padding: ptlr10,
          child: Column(
            children: item.items!.map((item) {
              return Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CachedNetworkImage(
                        imageUrl: item.image!,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${item.brand} - ${item.name}"),
                          Text("${item.package} X ${item.quantity}")
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ))
    ]);
  }
}

class CustomBottomBarButton extends StatelessWidget {
  const CustomBottomBarButton({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller =
      Get.put(ShoppingListDetailController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                                        borderRadius: BorderRadius.zero))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 5),
                            Text("Edit Items")
                          ],
                        ),
                        onPressed: () => Navigator.pushNamed(context,
                                "/edit-shopping-list/${controller.uuid}")
                            .then((value) =>
                                controller.apicall(controller.uuid))))),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: customElevatedButton(packageColor, whiteColor)
                        .copyWith(
                            shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 5),
                        Text("Add to Cart")
                      ],
                    ),
                    onPressed: () => controller.addToCart(),
                  )),
            ),
          ],
        ),
        if (controller.data.canSubscribe!)
          GestureDetector(
            child: Container(
              padding: p10,
              color: skyBlueColor,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.subscriptions, color: whiteColor),
                  SizedBox(width: 10),
                  Text("Subscribe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            onTap: () => controller.subscribeList(controller.data.uuid),
          )
      ],
    );
  }
}
