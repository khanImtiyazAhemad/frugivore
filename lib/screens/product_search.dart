import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/filter.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_card.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/controllers/productSearch.dart';

import 'package:frugivore/connectivity.dart';

class ProductSearchPage extends StatelessWidget {
  const ProductSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSearchController());
    return Scaffold(
        appBar: CustomAppBar(),
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
                                      title: "Search Result", search: true),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        
                                        TitleCard(title: "Search Results"),
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
                                                          arguments: [
                                                            controller.pattern
                                                          ]),
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
                                        if (controller.loggedIn.value &&
                                            controller.data.page ==
                                                controller.data.maxPage &&
                                            !controller.querySubmitted.value)
                                          LookingFor(),
                                        if (controller.querySubmitted.value)
                                          QueryResponse()
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

class QueryResponse extends StatelessWidget {
  const QueryResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.transparent,
        margin: p10,
        shape: shapeRoundedRectangleBorderBLR,
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: p10,
            child: Text(
                "Your Query is submitted with us will look into it and update you",
                textAlign: TextAlign.center)));
  }
}

class LookingFor extends StatelessWidget {
  const LookingFor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSearchController());
    return Card(
        shadowColor: Colors.transparent,
        margin: p10,
        shape: shapeRoundedRectangleBorderBLR,
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: p10,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Didn't find what you are looking for? Please let us know"),
                  SizedBox(height: 10),
                  Container(
                      padding: p10,
                      decoration: shapeDecoration,
                      child: TextField(
                          controller: controller.name,
                          decoration: InputDecoration.collapsed(
                              hintText: "Please enter your Product Name"))),
                  SizedBox(height: 10),
                  Container(
                      padding: p10,
                      decoration: shapeDecoration,
                      child: TextField(
                          controller: controller.description,
                          maxLines: 3,
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  "Please provide product description(optional)"))),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: customElevatedButton(pinkColor, whiteColor),
                        onPressed: () => controller.lookingFor(),
                        child: Text("SUBMIT")),
                  )
                ])));
  }
}
