// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/product_image.dart';
import 'package:frugivore/widgets/bread_crumbs.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/models/utils.dart';

import 'package:frugivore/controllers/productDetail.dart';
import 'package:frugivore/controllers/productCard.dart';

import 'package:frugivore/connectivity.dart';

class ProductDetailPage extends StatelessWidget {
  final List? arguments;
  const ProductDetailPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomConditionalBottomBar(
            controller: controller),
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
                                  hasInformationData(),
                                  CustomTitleBar(
                                      title: "Search Result",
                                      search: true,
                                      bottom: true),
                                  BreadCrumbsBar(
                                    category:
                                        controller.detail.product!.category,
                                    subcategory:
                                        controller.detail.product!.subcategory,
                                    product: controller.detail.product!.name,
                                  ),
                                  if (controller.detail.recentPurchase != null)
                                    Column(
                                      children: [
                                        Card(
                                          color: whiteColor,
                                            margin: plr10,
                                            shape: roundedCircularRadius,
                                            child: Padding(
                                                padding: p10,
                                                child: Container(
                                                  padding: ptlr10,
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Purchased ${controller.detail.recentPurchase!.totalItems} Items"),
                                                      Text(
                                                          "Last Purchased on ${controller.detail.recentPurchase!.purchased}"),
                                                      Text(
                                                          "${controller.detail.recentPurchase!.packageName}(Quantity:${controller.detail.recentPurchase!.quantity})"),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        padding: pt10,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color:
                                                                        borderColor))),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  height: 30,
                                                                  child: ElevatedButton(
                                                                      style: recentPurchaseCustomElevatedButton(
                                                                          whiteColor,
                                                                          Color(
                                                                              0xff3498db)),
                                                                      onPressed: () => Navigator.pushNamed(
                                                                          context,
                                                                          "/order-detail/${controller.detail.recentPurchase!.orderId}"),
                                                                      child: Text(
                                                                          "View this Order",
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  16))),
                                                                )),
                                                            if (controller
                                                                .detail
                                                                .recentPurchase
                                                                !.canGiveFeedback!)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        left: BorderSide(
                                                                            color:
                                                                                borderColor,
                                                                            width:
                                                                                1), // Right border
                                                                      ),
                                                                    ),
                                                                    child: ElevatedButton(
                                                                        style: recentPurchaseCustomElevatedButton(
                                                                            whiteColor,
                                                                            Color(
                                                                                0xff3498db)),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pushNamed(
                                                                          context,
                                                                          "/order-detail/${controller.detail.recentPurchase!.orderId}"),
                                                                        child: Text(
                                                                            "Order Review",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    16))),
                                                                  ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  Card(
                                      margin: plr10,
                                      shape: roundedCircularRadius,
                                      child: Padding(
                                          padding: p10,
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (controller.activePackage
                                                                .offerTitle !=
                                                            null &&
                                                        controller.activePackage
                                                                .offerTitle !=
                                                            "")
                                                      Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          padding: p5,
                                                          color: backgroundGrey,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  controller
                                                                      .activePackage
                                                                      .offerTitle,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          pinkColor)),
                                                              if (controller
                                                                      .activePackage
                                                                      .offerDescription !=
                                                                  "")
                                                                Text(
                                                                  controller
                                                                      .activePackage
                                                                      .offerDescription,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                            ],
                                                          )),
                                                    Row(children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .detail
                                                                  .product
                                                                  !.brand ?? "",
                                                              style: TextStyle(
                                                                  color:
                                                                      packageColor),
                                                            ),
                                                            Text(
                                                              controller.detail
                                                                  .product!.name ?? "",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                IconButton(
                                                                    iconSize:
                                                                        20,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                0),
                                                                    visualDensity: VisualDensity(
                                                                        horizontal:
                                                                            -4,
                                                                        vertical:
                                                                            -4),
                                                                    icon: Icon(
                                                                        Icons
                                                                            .share,
                                                                        color:
                                                                            primaryColor),
                                                                    onPressed: () => SharePlus.instance.share(ShareParams(text:controller.link))),
                                                                Text("Share",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12))
                                                              ]))
                                                    ]),
                                                    Wrap(
                                                      children: controller
                                                          .detail
                                                          .product
                                                          !.productPackage
                                                          !.map<Widget>((item) {
                                                        return GestureDetector(
                                                            child: Container(
                                                              height: 30,
                                                              width: 50,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: controller.activePackage.id ==
                                                                            item.id
                                                                        ? packageColor
                                                                        : borderColor,
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  item.name ?? "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: controller.activePackage.id ==
                                                                              item.id
                                                                          ? packageColor
                                                                          : borderColor),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              controller
                                                                      .activePackage =
                                                                  item;

                                                              if (controller
                                                                      .activePackage
                                                                      .userQuantity! >
                                                                  0) {
                                                                controller
                                                                    .addButton(
                                                                        false);
                                                              } else {
                                                                controller
                                                                    .addButton(
                                                                        true);
                                                              }
                                                              controller
                                                                      .quantity
                                                                      .text =
                                                                  item.userQuantity
                                                                      .toString();
                                                            });
                                                      }).toList(),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(children: [
                                                      Expanded(
                                                        flex: 7,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (controller
                                                                    .activePackage
                                                                    .displayDiscount !=
                                                                null)
                                                              Row(children: [
                                                                Text(
                                                                    "MRP: Rs ${controller.activePackage.price}",
                                                                    style:
                                                                        TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                    )),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                    "${controller.activePackage.displayDiscount}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            pinkColor)),
                                                              ]),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "Rs. ${controller.activePackage.displayPrice}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16)),
                                                                Text(
                                                                    " (inclusive of all taxes)")
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      controller.detail.product
                                                              !.isPromotional!
                                                          ? Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                  decoration:
                                                                      boxDecoration,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                      "NOT FOR SALE",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              pinkColor))))
                                                          : controller.activePackage
                                                                      .stock! <=
                                                                  0
                                                              ? Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      GestureDetector(
                                                                    child: Container(
                                                                        height:
                                                                            40,
                                                                        decoration:
                                                                            boxDecoration,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child: Text(
                                                                            "NOTIFY ME",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(fontSize: 10, color: pinkColor))),
                                                                    onTap: () =>
                                                                        showDialog(
                                                                      context: Get
                                                                          .context!,
                                                                      builder: (_) =>
                                                                          NotifyMe(
                                                                              package: controller.activePackage as Package),
                                                                      barrierDismissible:
                                                                          true,
                                                                    ),
                                                                  ))
                                                              : controller
                                                                          .detail
                                                                          .product
                                                                          !.deliveryType ==
                                                                      "PRE ORDER"
                                                                  ? controller
                                                                          .addButton
                                                                          .value
                                                                      ? Expanded(
                                                                          flex:
                                                                              3,
                                                                          child: Container(
                                                                              color: whiteColor,
                                                                              alignment: Alignment.centerRight,
                                                                              child: ElevatedButton(
                                                                                style: customElevatedButton(packageColor, whiteColor),
                                                                                child: Text(
                                                                                  "PRE ORDER",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                                                                ),
                                                                                onPressed: () => controller.addItem(),
                                                                              )),
                                                                        )
                                                                      : Expanded(
                                                                          flex:
                                                                              3,
                                                                          child: Container(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: GestureDetector(child: Container(padding: ptb10, height: 38, decoration: cartLeftButton, child: Icon(Icons.remove, color: whiteColor, size: 15)), onTap: () => controller.removeItem()),
                                                                                  ),
                                                                                  Expanded(
                                                                                      child: Container(
                                                                                    padding: ptb10,
                                                                                    height: 38,
                                                                                    color: pinkColor,
                                                                                    child: TextField(
                                                                                        enableInteractiveSelection: false,
                                                                                        style: TextStyle(color: whiteColor),
                                                                                        textAlign: TextAlign.center,
                                                                                        readOnly: true,
                                                                                        controller: controller.quantity,
                                                                                        decoration: InputDecoration.collapsed(
                                                                                          hintText: "1",
                                                                                        )),
                                                                                  )),
                                                                                  Expanded(
                                                                                    child: GestureDetector(child: Container(padding: ptb10, height: 38, decoration: cartRightButton, child: Icon(Icons.add, color: whiteColor, size: 15)), onTap: () => controller.addItem()),
                                                                                  ),
                                                                                ],
                                                                              )))
                                                                  : controller.addButton.value
                                                                      ? Expanded(
                                                                          flex:
                                                                              3,
                                                                          child: Container(
                                                                              color: whiteColor,
                                                                              alignment: Alignment.centerRight,
                                                                              child: ElevatedButton(
                                                                                style: customElevatedButton(pinkColor, whiteColor),
                                                                                child: Text(
                                                                                  "ADD",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                                                                ),
                                                                                onPressed: () => controller.addItem(),
                                                                              )),
                                                                        )
                                                                      : Expanded(
                                                                          flex: 3,
                                                                          child: Container(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Row(children: [
                                                                                Expanded(
                                                                                  child: GestureDetector(child: Container(padding: ptb10, height: 38, decoration: cartLeftButton, child: Icon(Icons.remove, color: whiteColor, size: 15)), onTap: () => controller.removeItem()),
                                                                                ),
                                                                                Expanded(
                                                                                    child: Container(
                                                                                  padding: ptb10,
                                                                                  height: 38,
                                                                                  color: pinkColor,
                                                                                  child: TextField(
                                                                                      enableInteractiveSelection: false,
                                                                                      style: TextStyle(color: whiteColor),
                                                                                      textAlign: TextAlign.center,
                                                                                      readOnly: true,
                                                                                      controller: controller.quantity,
                                                                                      decoration: InputDecoration.collapsed(
                                                                                        hintText: "1",
                                                                                      )),
                                                                                )),
                                                                                Expanded(
                                                                                  child: GestureDetector(child: Container(padding: ptb10, height: 38, decoration: cartRightButton, child: Icon(Icons.add, color: whiteColor, size: 15)), onTap: () => controller.addItem()),
                                                                                )
                                                                              ])))
                                                    ]),
                                                    ProductImageContainer(),
                                                    if (controller
                                                            .detail
                                                            .product
                                                            !.deliveryType ==
                                                        "SAME DAY")
                                                      Column(
                                                        children: [
                                                          Divider(
                                                              color:
                                                                  borderColor),
                                                          Row(children: [
                                                            Expanded(
                                                                flex: 9,
                                                                child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Expected Delivery: "),
                                                                      Text(
                                                                          "Today or Tomorrow",
                                                                          style:
                                                                              TextStyle(color: packageColor))
                                                                    ])),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Image.asset(
                                                                    'assets/images/sameDayIcon.png'))
                                                          ])
                                                        ],
                                                      ),
                                                    Divider(color: borderColor),
                                                    ProductIconsContainer(),
                                                    Divider(color: borderColor),
                                                    ProductDetailTabsContainer(),
                                                    Divider(
                                                        color: borderColor,
                                                        height: 0),
                                                    Container(
                                                        padding: ptb10,
                                                        child: Center(
                                                            child: Text(controller
                                                                .textForTab(controller
                                                                    .selectedTab
                                                                    .value)))),
                                                  ])))),
                                  SizedBox(height: 5),
                                  if (controller.detail.boughtTogtherItems !=
                                          null &&
                                      controller.detail.boughtTogtherItems
                                              !.isNotEmpty)
                                    Column(children: [
                                      TitleCard(
                                          title: "Frequently Bought Together"),
                                      SliderProducts(
                                          items: controller
                                              .detail.boughtTogtherItems!),
                                      SizedBox(height: 5),
                                    ]),
                                  if (controller.detail.similarItems != null &&
                                      controller.detail.similarItems!.isNotEmpty)
                                    Column(children: [
                                      TitleCard(title: "Similar Products"),
                                      SliderProducts(
                                          items:
                                              controller.detail.similarItems!),
                                    ]),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class ProductDetailTabsContainer extends StatelessWidget {
  const ProductDetailTabsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());

    return Obx(() => Row(
            children: controller.descriptionTabs.map<Widget>((item) {
          return Expanded(
              flex: controller.selectedTab.value == item ? 4 : 3,
              child: GestureDetector(
                  child: Container(
                    padding: p10,
                    decoration: controller.selectedTab.value == item
                        ? BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: primaryColor)))
                        : null,
                    child: Text(item,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                  ),
                  onTap: () => controller.selectedTab(item)));
        }).toList()));
  }
}

class ProductIconsContainer extends StatelessWidget {
  const ProductIconsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        shrinkWrap: true,
        children:
            List.generate(controller.detail.productIcons!.length, (index) {
          return Container(
            padding: p5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: controller.detail.productIcons![index].image!,
                  height: 60,
                ),
                SizedBox(height: 5),
                Text(controller.detail.productIcons![index].name ?? "",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10),
                    maxLines: 1),
              ],
            ),
          );
        }));
  }
}

class ProductImageContainer extends StatelessWidget {
  ProductImageContainer({super.key});
  final _current = "0".obs;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.09,
            child: controller.detail.product!.veg!
                ? Image.asset('assets/images/veg.png',
                    height: 10, alignment: Alignment.topLeft)
                : Image.asset('assets/images/nonVeg.png',
                    height: 10, alignment: Alignment.topLeft)),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 220.0,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          _current(index.toString())),
                  items: controller.activePackage.images!.map<Widget>((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => ZoomImageContainer(
                                item: item,
                                images: controller.activePackage.images!),
                            barrierDismissible: false,
                          ),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                              child: Padding(
                                  padding: p10,
                                  child: CachedNetworkImage(
                                      imageUrl: item, fit: BoxFit.fitHeight))),
                        );
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.activePackage.images
                      !.asMap()
                      .entries
                      .map<Widget>((entry) {
                    return GestureDetector(
                      onTap: () => _controller.jumpTo(entry.key.toDouble()),
                      child: Obx(() => Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current.value == entry.key.toString()
                                    ? primaryColor
                                    : Colors.black),
                          )),
                    );
                  }).toList(),
                ),
              ],
            )),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.09,
            child:
                CachedNetworkImage(imageUrl: controller.detail.product!.flag ?? "")),
      ],
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
                  activePackage:
                      SelectDefaultPackage(items: item.productPackage!)
                          .defaultPackage());
            }).toList())));
  }
}

class SliderProductCard extends StatefulWidget {
  final GlobalProductModel item;
  Package? activePackage;
  SliderProductCard({super.key, required this.item, this.activePackage});

  @override
  SliderProductCardState createState() => SliderProductCardState();
}

class SliderProductCardState extends State<SliderProductCard> {
  @override
  Widget build(BuildContext context) {
    final ProductCardController controller = Get.put(ProductCardController());
    final parentController = Get.put(ProductDetailController());
    final quantityController =
        TextEditingController(text: "${widget.activePackage!.userQuantity}");
    return GestureDetector(
        child: Container(
          padding: plbr10,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .40),
          margin: EdgeInsets.only(right: 5),
          decoration:
              circularBoxDecorationWithBorder.copyWith(color: whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Stack(children: [
                CachedNetworkImage(
                    imageUrl: widget.activePackage!.imgOne!, width: 150),
                if (widget.activePackage!.displayDiscount != null)
                  Container(
                      padding: p10,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                          widget.activePackage!.displayDiscount!
                              .replaceAll(" ", "\n"),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(color: Colors.white, fontSize: 8))),
              ]),
              SizedBox(height: 10),
              Text(widget.item.brand!, style: TextStyle(color: packageColor)),
              SizedBox(
                  width: 120,
                  child: Text(widget.item.name!,
                      maxLines: 1, overflow: TextOverflow.ellipsis)),
              SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 5,
                children: widget.item.productPackage!.map<Widget>((item) {
                  return GestureDetector(
                    child: Container(
                        height: 24,
                        width: 50,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.activePackage!.id == item.id
                                    ? packageColor
                                    : borderColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(item.name!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: widget.activePackage!.id == item.id
                                      ? packageColor
                                      : borderColor)),
                        )),
                    onTap: () {
                      setState(() {
                        widget.activePackage = item;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MRP: Rs ${widget.activePackage!.price}",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            "Rs: ${widget.activePackage!.displayPrice}",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: widget.activePackage!.userQuantity! > 0
                        ? Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * .15,
                            color: whiteColor,
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                        child: Container(
                                            padding: ptb5,
                                            decoration: cartLeftButton,
                                            child: Icon(Icons.remove,
                                                color: whiteColor, size: 18)),
                                        onTap: () {
                                          controller.removeCartItem(
                                              widget.item.id,
                                              widget.activePackage,
                                              quantityController);
                                          setState(() {
                                            widget.activePackage!.userQuantity =
                                                int.parse(
                                                    quantityController.text);
                                          });
                                        })),
                                Expanded(
                                    child: Container(
                                        padding: ptb5,
                                        color: pinkColor,
                                        child: TextField(
                                            enableInteractiveSelection: false,
                                            style: TextStyle(color: whiteColor),
                                            textAlign: TextAlign.center,
                                            readOnly: true,
                                            controller: quantityController,
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText: "1",
                                            )))),
                                Expanded(
                                    child: GestureDetector(
                                        child: Container(
                                            padding: ptb5,
                                            decoration: cartRightButton,
                                            child: Icon(Icons.add,
                                                color: whiteColor, size: 18)),
                                        onTap: () {
                                          controller.addCartItem(
                                              widget.item.id,
                                              widget.activePackage,
                                              quantityController);
                                          setState(() {
                                            widget.activePackage!.userQuantity =
                                                int.parse(
                                                    quantityController.text);
                                          });
                                        }))
                              ],
                            ))
                        : Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * .15,
                            color: whiteColor,
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style:
                                  customElevatedButton(pinkColor, whiteColor),
                              child: Text("ADD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              onPressed: () {
                                controller.addCartItem(widget.item.id,
                                    widget.activePackage, quantityController);
                                setState(() {
                                  widget.activePackage!.userQuantity =
                                      int.parse(quantityController.text);
                                });
                              },
                            )),
                  ),
                ],
              )
            ],
          ),
        ),
        onTap: () => parentController.apicall(widget.item.slug));
  }
}

class NotifyMe extends StatelessWidget {
  final Package package;
  const NotifyMe({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductCardController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/orderPlaced.png', height: 60),
          SizedBox(height: 20),
          package.notified!
              ? Text(
                  'Request taken already! Will notify you on availability',
                  textAlign: TextAlign.center,
                )
              : Column(
                  children: [
                    Text(
                      'Thanks for your interest. We will inform you via Email/SMS, once the item is back in stock!',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: customElevatedButton(pinkColor, whiteColor),
                            child: Text('OK'),
                            onPressed: () => controller.notifyItem(package)))
                  ],
                ),
        ],
      ),
    );
  }
}
