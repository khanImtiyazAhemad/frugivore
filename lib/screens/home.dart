import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/widgets/stars.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/pincode.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/search_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_card.dart';
import 'package:frugivore/widgets/promotional_banner.dart';
import 'package:frugivore/widgets/custom_timer.dart';
import 'package:frugivore/widgets/theme.dart';

import 'package:frugivore/models/home.dart';
import 'package:frugivore/models/utils.dart';
import 'package:frugivore/controllers/home.dart';
import 'package:frugivore/controllers/pincode.dart';

import 'package:frugivore/screens/order/myOrder.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/connectivity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(),
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
                  controller: controller.scrollController,
                  scrollDirection: Axis.vertical,
                  child: controller.isLoader.value
                      ? Loader()
                      : Column(
                          children: [
                            hasInformationData(),
                            CustomSearchBar(),
                            if (controller.banners.isNotEmpty)
                              BannerContainer(item: controller.banners[0]),
                            if (PinCodeController.message.value != "")
                              Container(
                                padding: pt5,
                                child: Text(
                                  PinCodeController.message.value,
                                  style: TextStyle(
                                    color: PinCodeController.color,
                                  ),
                                ),
                              ),
                            Card(
                              shadowColor: Colors.transparent,
                              margin: p10,
                              shape: roundedCircularRadius,
                              child: Padding(
                                padding: p10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.loggedUser.value)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order by: ${controller.earliestDeliverySlot.cutOffTime}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            "Get it by: ${controller.earliestDeliverySlot.endTime}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${controller.earliestDeliverySlot.addressType}: ${controller.earliestDeliverySlot.address}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                child: FaIcon(
                                                  getIconFromCss(
                                                    'fat fa-angle-down',
                                                  ),
                                                  color: primaryColor,
                                                  size: 18,
                                                ),
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/address-list',
                                                    ).then(
                                                      (value) =>
                                                          controller.apicall(),
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: FaIcon(
                                            getIconFromCss(
                                              'fat fa-location-dot',
                                            ),
                                            color: primaryColor,
                                            size: 24,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: CitiesDropDown(),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: PinCodeContainer(key: key),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ThemeStrip(),
                            SizedBox(height: 10),
                            if (controller.tiles.isNotEmpty)
                              Column(
                                children: [
                                  SliderTiles(items: controller.tiles),
                                ],
                              ),
                            if (controller.homepage.flashSaleSection != null &&
                                controller.homepage.flashSaleSection! &&
                                controller.homepage.flashSales!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["lighting_deals"]["title"],
                                    heading: globals
                                        .titles["lighting_deals"]["heading"],
                                  ),
                                  FlashSaleSliderProducts(
                                    items: controller.homepage.flashSales!,
                                  ),
                                ],
                              ),
                            if (controller.recentOrderFeedbackCheck.value)
                              RateUsOrder(),
                            SizedBox(height: 20),
                            if (HomeController.lastUndeliveredOrderCheck.value)
                              OrderCard(
                                item: controller.lastUndeliveredOrder.data,
                              ),
                            if (controller.banners.length > 1)
                              BannerContainer(item: controller.banners[1]),
                            SizedBox(height: 10),
                            if (controller.categories.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title:
                                        globals.titles["categories"]["title"],
                                    heading:
                                        globals.titles["categories"]["heading"],
                                  ),
                                  CategoryContainer(
                                    items: controller.categories,
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 2)
                              BannerContainer(item: controller.banners[2]),
                            SizedBox(height: 10),
                            if (controller.purchaseHistoryOrders.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["past_purchases"]["title"],
                                    heading: globals
                                        .titles["past_purchases"]["heading"],
                                  ),
                                  SizedBox(height: 10),
                                  Card(
                                    shadowColor: Colors.transparent,
                                    margin: plr10,
                                    shape: shapeRoundedRectangleBorderBLR,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/pastPurchases.jpg",
                                        ),
                                        Column(
                                          children: controller
                                              .purchaseHistoryOrders
                                              .map<Widget>((item) {
                                                return PurchaseHistoryCard(
                                                  item: item,
                                                );
                                              })
                                              .toList(),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ElevatedButton(
                                            style:
                                                customElevatedButton(
                                                  primaryColor,
                                                  whiteColor,
                                                ).copyWith(
                                                  shape:
                                                      WidgetStateProperty.all<
                                                        RoundedRectangleBorder
                                                      >(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                        ),
                                                      ),
                                                ),
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                  context,
                                                  "/purchase-items",
                                                ),
                                            child: Text(
                                              "Go to Purchased Items",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 10),
                            if (controller.homepage.newArrivals != null &&
                                controller.homepage.newArrivals!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title:
                                        globals.titles["new_arrivals"]["title"],
                                    heading: globals
                                        .titles["new_arrivals"]["heading"],
                                  ),
                                  SliderProducts(
                                    items: controller.homepage.newArrivals!,
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 3)
                              BannerContainer(item: controller.banners[3]),
                            SizedBox(height: 10),
                            if (controller.homepage.frugivoreOriginals !=
                                    null &&
                                controller
                                    .homepage
                                    .frugivoreOriginals!
                                    .isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["frugivore_originals"]["title"],
                                    heading: globals
                                        .titles["frugivore_originals"]["heading"],
                                  ),
                                  SliderProducts(
                                    items:
                                        controller.homepage.frugivoreOriginals!,
                                  ),
                                ],
                              ),
                            SizedBox(height: 10),
                            if (controller.banners.length > 4)
                              BannerContainer(item: controller.banners[4]),
                            SizedBox(height: 10),
                            if (controller.homepage.bestdeal != null &&
                                controller.homepage.bestdeal!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title:
                                        globals.titles["best_deals"]["title"],
                                    heading:
                                        globals.titles["best_deals"]["heading"],
                                  ),
                                  SizedBox(height: 10),
                                  DisplayProductSection(
                                    items: controller.homepage.bestdeal!,
                                    promotional: HomePromotion(
                                      items: controller.homepage.promotional!,
                                    ).promotionalSubList(0, 2),
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 5)
                              BannerContainer(item: controller.banners[5]),
                            if (controller.subCategories.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["subcategories"]["title"],
                                    heading: globals
                                        .titles["subcategories"]["heading"],
                                  ),
                                  SubCategoryContainer(
                                    items: controller.subCategories,
                                  ),
                                ],
                              ),
                            if (controller.mySection.length > 5)
                              Padding(
                                padding: p10,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                  ),
                                  items: controller.mySection.map<Widget>((
                                    item,
                                  ) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          child: CachedNetworkImage(
                                            imageUrl: item.banner!,
                                            fit: BoxFit.fill,
                                          ),
                                          onTap: () => MySectionBannerRouting(
                                            item: item,
                                            callback: controller.apicall,
                                          ).routing(),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            if (controller.banners.length > 6)
                              BannerContainer(item: controller.banners[6]),
                            SizedBox(height: 10),
                            if (controller.homepage.products != null &&
                                controller.homepage.products!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["fresh_products"]["title"],
                                    heading: globals
                                        .titles["fresh_products"]["heading"],
                                  ),
                                  SizedBox(height: 10),
                                  ProductSection(
                                    items: controller.homepage.products!,
                                    promotional: HomePromotion(
                                      items: controller.homepage.promotional!,
                                    ).promotionalSubList(2, 4),
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 7)
                              BannerContainer(item: controller.banners[7]),
                            SizedBox(height: 10),
                            if (controller.homepage.externalProducts != null &&
                                controller
                                    .homepage
                                    .externalProducts!
                                    .isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["grocery_products"]["title"],
                                    heading: globals
                                        .titles["grocery_products"]["heading"],
                                  ),
                                  SizedBox(height: 10),
                                  ProductSection(
                                    items:
                                        controller.homepage.externalProducts!,
                                    promotional: HomePromotion(
                                      items: controller.homepage.promotional!,
                                    ).promotionalSubList(4, 6),
                                  ),
                                ],
                              ),
                            if (controller.seasonBest.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(title: "Season's Best"),
                                  SeasonBestContainer(
                                    items: controller.seasonBest,
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 8)
                              BannerContainer(item: controller.banners[8]),
                            SizedBox(height: 10),
                            if (controller.homepage.suggested != null &&
                                controller.homepage.suggested!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title: globals
                                        .titles["suggested_for_you"]["title"],
                                    heading: globals
                                        .titles["suggested_for_you"]["heading"],
                                  ),
                                  SizedBox(height: 10),
                                  SliderProducts(
                                    items: controller.homepage.suggested!,
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 9)
                              BannerContainer(item: controller.banners[9]),
                            SizedBox(height: 10),
                            if (controller.homepage.exploremore != null &&
                                controller.homepage.exploremore!.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(
                                    title:
                                        globals.titles["explore_more"]["title"],
                                    heading: globals
                                        .titles["explore_more"]["heading"],
                                  ),
                                  DisplaySliderProducts(
                                    items: controller.homepage.exploremore!,
                                  ),
                                ],
                              ),
                            if (controller.banners.length > 10)
                              BannerContainer(item: controller.banners[10]),
                            SizedBox(height: 10),
                            if (controller.banners.length > 11)
                              BannerContainer(item: controller.banners[11]),
                            SizedBox(height: 10),
                            if (controller.blogs.isNotEmpty)
                              Column(
                                children: [
                                  TitleCard(title: "Engage"),
                                  Card(
                                    shadowColor: Colors.transparent,
                                    margin: p10,
                                    shape: shapeRoundedRectangleBorderBLR,
                                    child: BlogContainer(
                                      items: controller.blogs,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Like What You See? You'll Like Us Even More Here:",
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: FaIcon(
                                            getIconFromCss('fab fa-facebook'),
                                            color: primaryColor,
                                            size: 40,
                                          ),
                                          onTap: () => controller.launchCustomUrl(
                                            'https://www.facebook.com/frugivoreindia/',
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        GestureDetector(
                                          child: FaIcon(
                                            getIconFromCss('fab fa-instagram'),
                                            color: primaryColor,
                                            size: 40,
                                          ),
                                          onTap: () => controller.launchCustomUrl(
                                            'https://instagram.com/frugivoreindia?igshid=MzRlODBiNWFlZA==',
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        GestureDetector(
                                          child: FaIcon(
                                            getIconFromCss(
                                              'fab fa-linkedin-in',
                                            ),
                                            color: primaryColor,
                                            size: 40,
                                          ),
                                          onTap: () => controller.launchCustomUrl(
                                            'https://www.linkedin.com/company/frugivore.in/',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Image.asset("assets/images/FeelGoodFoodFooter.jpg"),
                            SizedBox(height: 80),
                          ],
                        ),
                );
              }),
            ),
          ),
        ),
        // floatingActionButton: controller.isLoader.value
        //     ? FloatingActionButton(
        //         child: Icon(Icons.arrow_upward_outlined),
        //         onPressed: () async {
        //           if (controller.scrollController.hasClients) {
        //             await controller.scrollController.animateTo(controller.scrollController.position.maxScrollExtent,
        //                 duration: Duration(milliseconds: 200),
        //                 curve: Curves.easeInOut);
        //           }
        //         },
        //       )
        //     : SizedBox()
      ),
    );
  }
}

class RateUsOrder extends StatefulWidget {
  const RateUsOrder({super.key});

  @override
  RateUsOrderState createState() => RateUsOrderState();
}

class RateUsOrderState extends State<RateUsOrder> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => Card(
        shadowColor: Colors.transparent,
        margin: ptlr10,
        shape: roundedCircularRadius,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: ptb10,
              color: pinkColor,
              child: Text(
                "Rate your last Order",
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor),
              ),
            ),
            Padding(
              padding: p10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rate your Order"),
                  StarRating(
                    value: controller.rating.value,
                    filledStar: Icon(Icons.star, color: yellowColor),
                    unfilledStar: Icon(Icons.star, color: Color(0xff525252)),
                    color: yellowColor,
                    onChanged: (index) => setState(() {
                      controller.rating(index);
                    }),
                  ),
                  SizedBox(height: 10),
                  Text("Rate your Delivery Boy"),
                  StarRating(
                    value: controller.deliveryBoyRating.value,
                    filledStar: Icon(Icons.star, color: yellowColor),
                    unfilledStar: Icon(Icons.star, color: Color(0xff525252)),
                    color: yellowColor,
                    onChanged: (index) => setState(() {
                      controller.deliveryBoyRating(index);
                    }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: p10,
                    decoration: shapeDecoration,
                    child: TextField(
                      maxLines: 3,
                      controller: controller.comment,
                      decoration: InputDecoration.collapsed(
                        hintText: "Comment",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor),
                      onPressed: () => controller.rateUsOrder(),
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerContainer extends StatelessWidget {
  final BannersModel item;
  const BannerContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: item.banner!,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      onTap: () =>
          BannerRouting(item: item, callback: controller.apicall).routing(),
    );
  }
}

class DisplayProductSection extends StatelessWidget {
  final List<Bestdeal> items;
  final List<Promotional> promotional;
  const DisplayProductSection({
    super.key,
    required this.items,
    required this.promotional,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: plbr10,
      shape: shapeRoundedRectangleBorderBLR,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: items.map<Widget>((item) {
            return Column(
              children: [
                ProductCard(
                  item: item.product!,
                  activePackage: SelectDefaultPackage(
                    items: item.product!.productPackage!,
                  ).defaultPackage(),
                ),
                HomePromotion(
                          items: promotional,
                        ).validation(items.indexOf(item)) !=
                        0
                    ? HomePromotionalContainer(
                        item:
                            HomePromotion(
                                  items: promotional,
                                ).validation(items.indexOf(item))
                                as Promotional,
                      )
                    : SizedBox(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final List<GlobalProductModel> items;
  final List<Promotional> promotional;
  const ProductSection({
    super.key,
    required this.items,
    required this.promotional,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: plbr10,
      shape: shapeRoundedRectangleBorderBLR,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: items.map<Widget>((item) {
            return Column(
              children: [
                ProductCard(
                  item: item,
                  activePackage: SelectDefaultPackage(
                    items: item.productPackage!,
                  ).defaultPackage(),
                ),
                HomePromotion(
                          items: promotional,
                        ).validation(items.indexOf(item)) !=
                        0
                    ? HomePromotionalContainer(
                        item:
                            HomePromotion(
                                  items: promotional,
                                ).validation(items.indexOf(item))
                                as Promotional,
                      )
                    : SizedBox(),
              ],
            ); // this won't update
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final List<CategoryList> items;
  const CategoryContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: plbr10,
      shape: shapeRoundedRectangleBorderBLR,
      child: Obx(
        () => GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          children: List.generate(controller.categoryStaticLength, (index) {
            return index == (controller.categoryStaticLength - 1)
                ? Padding(
                    padding: p5,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: controller.showAllCategories.value
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "View Less",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  FaIcon(
                                    getIconFromCss('fat fa-angles-up'),
                                    color: packageColor,
                                    size: 18,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  FaIcon(
                                    getIconFromCss('fat fa-angles-down'),
                                    color: packageColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                      ),
                      onTap: () => controller.categoriesList(),
                    ),
                  )
                : Padding(
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
                              child: Text(
                                items[index].name!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => "${items[index].id}" == "0"
                          ? Navigator.pushNamed(context, "/frugivore-originals")
                          : Navigator.pushNamed(
                              context,
                              "/subcategory/${items[index].slug}/${items[index].subcategorySlug}",
                            ).then((value) => controller.apicall()),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}

class SubCategoryContainer extends StatelessWidget {
  final List<SubCategoriesModel> items;
  const SubCategoryContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: plbr10,
      shape: shapeRoundedRectangleBorderBLR,
      child: Obx(
        () => GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          children: List.generate(controller.subCategoryStaticLength, (index) {
            return index == (controller.subCategoryStaticLength - 1)
                ? Padding(
                    padding: p5,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: controller.showAllSubCategories.value
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "View Less",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  FaIcon(
                                    getIconFromCss('fat fa-angles-up'),
                                    color: packageColor,
                                    size: 18,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  FaIcon(
                                    getIconFromCss('fat fa-angles-down'),
                                    color: packageColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                      ),
                      onTap: () => controller.subCategoriesList(),
                    ),
                  )
                : Padding(
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
                              padding: plr5,
                              child: Text(
                                items[index].name!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        "/subcategory/${items[index].categorySlug}/${items[index].slug}",
                      ).then((value) => controller.apicall()),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}

class PurchaseHistoryCard extends StatelessWidget {
  final PurchaseHistoryModel item;
  const PurchaseHistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Container(
      padding: p15,
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Invoice Number: #${item.invoiceNumber}",
                  style: TextStyle(color: packageColor),
                ),
                Text("Shop On: ${item.createdDate}"),
                Text("Delivered On: ${item.deliveryDate}"),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: customElevatedButton(primaryColor, whiteColor),
                    child: Text("Repeat Order", style: TextStyle(fontSize: 12)),
                    onPressed: () => controller.repeatOrder(item.orderId),
                  ),
                ),
                if (item.canConvertToShoppingList!)
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor),
                      child: Text(
                        "Convert to Shopping List",
                        style: TextStyle(fontSize: 9),
                      ),
                      onPressed: () =>
                          controller.convertToShoppingList(item.orderId),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestimonialsContainer extends StatelessWidget {
  final List<TestimonialsModel> items;
  const TestimonialsContainer({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: items.map((TestimonialsModel item) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: p10,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.banner!,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: p20,
                        margin: p10,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.text!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${item.name} (${item.location}, ${item.date})",
                              style: TextStyle(
                                color: pinkColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class BlogContainer extends StatelessWidget {
  final List<BlogsModel> items;
  const BlogContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: items.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => controller.blogsRouting(item.title),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.image!,
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: p5,
                            height: 70,
                            width: 50,
                            decoration: BoxDecoration(
                              color: orangeColor,
                              border: Border.all(color: pinkColor, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                item.createdAt!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title!,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 60,
                              child: Html(
                                data: item.description!.substring(0, 100),
                              ),
                            ),
                            ElevatedButton(
                              style: customElevatedButton(
                                orangeColor,
                                whiteColor,
                              ),
                              onPressed: () =>
                                  controller.blogsRouting(item.title),
                              child: Text("More"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class SeasonBestContainer extends StatelessWidget {
  final List<SeasonBestModel> items;
  const SeasonBestContainer({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: items.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: plr10,
                  child: CachedNetworkImage(
                    imageUrl: item.image!,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              onTap: () => SeasonBannerRouting(
                item: item,
                callback: controller.apicall,
              ).routing(),
            );
          },
        );
      }).toList(),
    );
  }
}

class FlashSaleSliderProducts extends StatelessWidget {
  final List<FlashSale> items;
  const FlashSaleSliderProducts({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: CustomTimer(item: items[0]),
        ),
        Padding(
          padding: plr10,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map<Widget>((item) {
                return FlashSaleSliderProductCard(
                  item: item,
                  activePackage: item.package!,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
class FlashSaleSliderProductCard extends StatefulWidget {
  final FlashSale item;
  Package activePackage;
  FlashSaleSliderProductCard({
    super.key,
    required this.item,
    required this.activePackage,
  });

  @override
  FlashSaleSliderProductCardState createState() =>
      FlashSaleSliderProductCardState();
}

class FlashSaleSliderProductCardState
    extends State<FlashSaleSliderProductCard> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final quantityController = TextEditingController(
      text: "${widget.activePackage.userQuantity}",
    );
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .40,
      ),
      margin: EdgeInsets.only(right: 5),
      decoration: boxDecorationWithBorder.copyWith(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [CachedNetworkImage(imageUrl: widget.item.banner!)],
          ),
          SizedBox(height: 10),
          Container(
            padding: plbr10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.product!.brand!,
                  style: TextStyle(color: packageColor),
                ),
                Text(
                  widget.item.product!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Container(
                  height: 26,
                  width: 50,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: packageColor, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.activePackage.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: packageColor),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MRP: Rs ${widget.activePackage.price}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              "Rs: ${widget.activePackage.flashSalePrice}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: widget.activePackage.userQuantity! > 0
                          ? Container(
                              width: MediaQuery.of(context).size.width * .15,
                              color: whiteColor,
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        padding: ptb10,
                                        decoration: cartLeftButton,
                                        child: Icon(
                                          Icons.remove,
                                          color: whiteColor,
                                          size: 18,
                                        ),
                                      ),
                                      onTap: () {
                                        controller.flashRemoveCartItem(
                                          widget.item.product!.id,
                                          widget.activePackage,
                                          quantityController,
                                        );
                                        setState(() {
                                          widget.activePackage.userQuantity =
                                              int.parse(
                                                quantityController.text,
                                              );
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: ptb10,
                                      color: pinkColor,
                                      child: TextField(
                                        enableInteractiveSelection: false,
                                        style: TextStyle(color: whiteColor),
                                        textAlign: TextAlign.center,
                                        readOnly: true,
                                        controller: quantityController,
                                        decoration: InputDecoration.collapsed(
                                          hintText: "1",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        padding: ptb10,
                                        decoration: cartRightButton,
                                        child: Icon(
                                          Icons.add,
                                          color: whiteColor,
                                          size: 18,
                                        ),
                                      ),
                                      onTap: () {
                                        controller.flashAddCartItem(
                                          widget.item.product!.id,
                                          widget.activePackage,
                                          quantityController,
                                        );
                                        setState(() {
                                          widget.activePackage.userQuantity =
                                              int.parse(
                                                quantityController.text,
                                              );
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * .15,
                              color: whiteColor,
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: customElevatedButton(
                                  pinkColor,
                                  whiteColor,
                                ),
                                child: Text(
                                  "ADD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  controller.flashAddCartItem(
                                    widget.item.product!.id,
                                    widget.activePackage,
                                    quantityController,
                                  );
                                  setState(() {
                                    widget.activePackage.userQuantity =
                                        int.parse(quantityController.text);
                                  });
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliderProducts extends StatelessWidget {
  final List<GlobalProductModel> items;
  const SliderProducts({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: plr10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map<Widget>((item) {
            return SliderProductCard(
              item: item,
              activePackage: SelectDefaultPackage(
                items: item.productPackage!,
              ).defaultPackage(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SliderTiles extends StatelessWidget {
  final List<MarketingTilesModel> items;
  const SliderTiles({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: plr10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map<Widget>((item) {
            return GestureDetector(
              child: Padding(
                padding: pr10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: CachedNetworkImage(imageUrl: item.banner!),
                ),
              ),
              onTap: () => TileRouting(
                item: item,
                callback: controller.apicall,
              ).routing(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DisplaySliderProducts extends StatelessWidget {
  final List<Bestdeal> items;
  const DisplaySliderProducts({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: p10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map<Widget>((item) {
            return SliderProductCard(
              item: item.product!,
              activePackage: SelectDefaultPackage(
                items: item.product!.productPackage!,
              ).defaultPackage(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
