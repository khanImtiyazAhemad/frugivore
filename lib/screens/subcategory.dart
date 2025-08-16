import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/filter.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/product_card.dart';
import 'package:frugivore/widgets/promotional_banner.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bread_crumbs.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/subcategory.dart';
import 'package:frugivore/controllers/subcategory.dart';

import 'package:frugivore/connectivity.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubCategoryController());
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(
            controller: controller),
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
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomTitleBar(
                                      title: "Search Result",
                                      search: true,
                                      bottom: true),
                                  BreadCrumbsBar(
                                    category: controller.detail.categorytitle,
                                    subcategory: controller.detail.title,
                                    bottom: true,
                                  ),
                                      TitleCard(title: controller.detail.title ?? ""),
                                      Card(
                                          shadowColor: Colors.transparent,
                                          margin: plr10,
                                          shape: shapeRoundedRectangleBorderBLR,
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (controller
                                                            .detail.banner !=
                                                        null)
                                                      GestureDetector(
                                                        onTap: () => controller
                                                            .redirection(),
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    controller
                                                                        .detail
                                                                        .banner),
                                                      ),
                                                    CustomFilterContainer(
                                                        count: controller
                                                            .detail.count,
                                                        text: "Products",
                                                        categories: controller
                                                            .detail.categories,
                                                        subcategories:
                                                            controller.detail
                                                                .subCategories,
                                                        brands: controller
                                                            .detail.brands,
                                                        callback:
                                                            controller.apicall,
                                                        arguments: [
                                                          SubCategoryController
                                                              .category,
                                                          SubCategoryController
                                                              .subcategory
                                                        ]),
                                                    ScrollableSubCategory(),
                                                    ProductSection(
                                                      items: controller.results,
                                                      promotional: controller
                                                          .detail.promotional
                                                          !.sublist(
                                                              0,
                                                              controller
                                                                  .detail
                                                                  .promotional
                                                                  !.length),
                                                    ),
                                                  ]))),
                                      SizedBox(height: 10),
                                      controller.wait.value
                                          ? CircularProgressIndicator()
                                          : Obx(() => Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      "Page ${controller.detail.page}/${controller.detail.maxPage}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  controller.detail.page != controller.detail.maxPage && !controller.wait.value ? GestureDetector(
                                                    onTap: ()  {
                                                      controller.wait(true);
                                                      controller.loadMore(controller.detail);
                                                      controller.refreshController.loadComplete();
                                                    },
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 5),
                                                        Text("Load More",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        SizedBox(height: 2),
                                                        FaIcon(
                                                            getIconFromCss(
                                                                'fat fa-angle-down'),
                                                            color: primaryColor,
                                                            size: 24),
                                                      ],
                                                    ),
                                                  ) : SizedBox()
                                                ],
                                              )),
                                      SizedBox(height: 60)
                                    ]));
                    })))));
  }
}

class ScrollableSubCategory extends StatelessWidget {
  const ScrollableSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubCategoryController());
    return SingleChildScrollView(
        controller: controller.horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: Padding(
            padding: plr10,
            child: Row(
                children: controller.detail.subcategorylist!.map<Widget>((item) {
              return GestureDetector(
                  child: Container(
                    padding: p10,
                    decoration: controller.selectedTab == item.name
                        ? BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: primaryColor)))
                        : null,
                    child: Text(item.name ?? ""),
                  ),
                  onTap: () => controller.apicall(
                      controller.qsp, item.categorySlug, item.slug));
            }).toList())));
  }
}

class ProductSection extends StatelessWidget {
  final List<GlobalProductModel> items;
  final List<Promotional>? promotional;

  const ProductSection({super.key, required this.items, this.promotional});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SubCategoryController());
    return items.isNotEmpty
        ? SwipeTo(
            child: Column(
              children: items.map<Widget>((item) {
                return Column(
                  children: [
                    ProductCard(
                        item: item,
                        activePackage:
                            SelectDefaultPackage(items: item.productPackage!)
                                .defaultPackage()),
                    SubCategoryPromotion(items: promotional!)
                                .validation(items.indexOf(item)) !=
                            0
                        ? SubCategoryPromotionalContainer(
                            item: SubCategoryPromotion(items: promotional!)
                                .validation(items.indexOf(item)) as Promotional)
                        : SizedBox()
                  ],
                );
              }).toList(),
            ),
            // onLeftSwipe: () {
            //   print(controller.detail.subcategorylist);
            //   // controller.apicall(controller.qsp, SubCategoryController.category,
            //   //     SubCategoryController.subcategory);
            // },
            // onRightSwipe: () {
            //   print(controller.detail.subcategorylist);
            //   // controller.apicall(controller.qsp, SubCategoryController.category,
            //   //     SubCategoryController.subcategory);
            // },
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Text("No Products available!!!"),
          );
  }
}
