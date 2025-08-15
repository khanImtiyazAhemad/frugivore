import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/bottom_bar.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/models/cart.dart';
import 'package:frugivore/models/utils.dart';

import 'package:frugivore/controllers/cart.dart';
import 'package:frugivore/controllers/productCard.dart';

import 'package:frugivore/connectivity.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: Obx(
        () => controller.cart.data != null && controller.cart.data!.isNotEmpty
            ? CustomOrderNavigationBar(
                amount: controller.total.value,
                text: "CHECKOUT",
                offer: controller.cart.offers!.isNotEmpty ? true : false,
                offerText: "OFFERS APPLIED",
                controller: controller,
              )
            : CustomConditionalBottomBar(),
      ),
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
                    : Column(
                        children: [
                          CustomTitleBar(title: "Cart", search: true),
                          Card(
                            margin: plr10,
                            color: whiteColor,
                            shape: roundedHalfCircularRadius,
                            child: Container(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      decoration: ShapeDecoration(
                                        color: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: borderColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: FaIcon(
                                        getIconFromCss('fat fa-clock'),
                                        color: whiteColor,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Order will be deliverer on:",
                                          style: TextStyle(
                                            height: 1,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "Aug 06,2025 at Morning Slot (11 am to 2 pm)",
                                          style: TextStyle(
                                            height: 1,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Change",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Card(
                            margin: plr10,
                            color: whiteColor,
                            shape: roundedHalfCircularRadius,
                            child: controller.cart.data!.isEmpty
                                ? Padding(
                                    padding: p10,
                                    child: Column(
                                      children: [
                                        Image.asset("assets/images/cart.jpeg"),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: buttonHeight,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ElevatedButton(
                                            style: customElevatedButton(
                                              pinkColor,
                                              whiteColor,
                                            ),
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                  context,
                                                  "/",
                                                ).then(
                                                  (value) =>
                                                      controller.apicall(),
                                                ),
                                            child: Text("Shop"),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: buttonHeight,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ElevatedButton(
                                            style: customElevatedButton(
                                              pinkColor,
                                              whiteColor,
                                            ),
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                  context,
                                                  "/my-shopping-lists",
                                                  arguments: [],
                                                ).then(
                                                  (value) =>
                                                      controller.apicall(),
                                                ),
                                            child: Text(
                                              "Shop from Shopping List",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: p10,
                                    child: ProductSection(
                                      items: controller.cart.data!,
                                    ),
                                  ),
                          ),
                          SizedBox(height: 15),
                          Card(
                            color: lightSkyBlueColor,
                            margin: plr10,
                            shape: roundedHalfCircularRadius,
                            child: Container(
                              padding: p10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: p10,
                                      decoration: ShapeDecoration(
                                        color: whiteColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: borderColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: FaIcon(
                                        getIconFromCss('fat fa-bicycle'),
                                        color: Colors.black,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      "${controller.cart.message}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: whiteColor,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          SavedCardContainer(),
                          SizedBox(height: 15),
                          Card(
                            color: lightRedColor,
                            margin: plr10,
                            shape: roundedHalfCircularRadius,
                            child: Container(
                              padding: p10,
                              child: Column(
                                children: [
                                  Text(
                                    "Recharge your wallet to get more savings",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                  SizedBox(height: 5),
                                  ElevatedButton(
                                    style: cartRechargeNowCustomElevatedButton(
                                      whiteColor,
                                      lightRedColor,
                                    ),
                                    child: Text(
                                      "RECHARGE NOW",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      "/recharge/''",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          if (controller.deliveryInstruction.isNotEmpty)
                            DeliveryInstructionContainer(
                              items: controller.deliveryInstruction,
                            ),
                          SizedBox(height: 5),
                          if (controller.cart.crossSellingsProducts != null &&
                              controller.cart.crossSellingsProducts!.isNotEmpty)
                            Column(
                              children: [
                                TitleCard(title: "You May Like"),
                                SliderProducts(
                                  items: controller.cart.crossSellingsProducts!,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          SizedBox(height: 5),
                          if (controller.cart.recommended != null &&
                              controller.cart.recommended!.isNotEmpty)
                            Column(
                              children: [
                                TitleCard(title: "Recommended For You"),
                                SliderProducts(
                                  items: controller.cart.recommended!,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          SizedBox(height: 15),
                          Text(
                            "**No Questions asked Refunds or Returns",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class SavedCardContainer extends StatelessWidget {
  const SavedCardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Card(
      color: whiteColor,
      margin: plr10,
      shape: roundedHalfCircularRadius,
      child: Container(
        padding: p15,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Billing Details", style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FaIcon(
                    getIconFromCss('fat fa-percent'),
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                Expanded(flex: 10, child: Text("Saved")),
                SizedBox(width: 5),
                Expanded(flex: 2, child: Text("Rs.${controller.saved}")),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FaIcon(
                    getIconFromCss('fat fa-memo-pad'),
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                Expanded(flex: 10, child: Text("Items Total")),
                SizedBox(width: 5),
                Expanded(flex: 2, child: Text("Rs.${controller.subTotal}")),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FaIcon(
                    getIconFromCss('fat fa-bicycle'),
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                Expanded(flex: 10, child: Text("Delivery Charge")),
                SizedBox(width: 5),
                Expanded(flex: 2, child: Text("Rs.${controller.deliveryFee}")),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: Text("Grand Total", style: TextStyle(fontSize: 15)),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Rs.${controller.total}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            controller.cart.cashbackMessage != "" &&
                    controller.cart.cashbackMessage != null
                ? Text(
                    "${controller.cart.cashbackMessage}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: yellowColor, fontSize: 12),
                  )
                : SizedBox(),
            controller.cart.cashbackSubmessage != "" &&
                    controller.cart.cashbackSubmessage != null
                ? Text(
                    "${controller.cart.cashbackSubmessage}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: yellowColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final List<Datum> items;
  const ProductSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: p5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundGrey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                data.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GravesendSans',
                ),
              ),
            ),
            Column(
              children: data.items!.map((product) {
                return CartProductCard(item: product);
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class DeliveryInstructionContainer extends StatelessWidget {
  final List<DeliveryInstructionModel> items;
  DeliveryInstructionContainer({super.key, required this.items});
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: whiteColor,
        margin: plr10,
        shape: roundedHalfCircularRadius,
        child: Container(
          padding: p10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Delivery Instructions"),
              SizedBox(height: 10),
              Row(
                children: items.map<Widget>((item) {
                  return Expanded(
                    flex: items.length,
                    child: GestureDetector(
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .28,
                        padding: EdgeInsets.only(
                          left: 10,
                          bottom: 5,
                          right: 10,
                          top: 5,
                        ),
                        margin: pr5,
                        alignment: Alignment.center,
                        decoration: boxRadius.copyWith(
                          color:
                              controller.activeDeliveryInstruction.value ==
                                  item.id
                              ? primaryColor
                              : backgroundGrey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: item.icon!,
                              height: 40,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${item.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(height: 1, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        controller.activeDeliveryInstruction.value != item.id
                            ? controller.activeDeliveryInstruction(item.id)
                            : controller.activeDeliveryInstruction(0);
                        controller.activeDeliveryInstructionText(item.title);
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final Item item;
  const CartProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final quantityController = TextEditingController(text: "${item.quantity}");
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        Get.context!,
        "/product-details/${item.product!.slug}",
      ),
      child: SwipeTo(
        child: Container(
          decoration: BoxDecoration(color: whiteColor),
          padding: p5,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        CachedNetworkImage(
                          imageUrl: item.package!.imgOne!,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        if (item.package!.displayDiscount != null)
                          Container(
                            padding: EdgeInsets.only(top: 7, left: 5, bottom: 7, right: 5),
                            decoration: BoxDecoration(
                              color: pinkColor,
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(
                              item.package!.displayDiscount!.replaceAll(
                                " ",
                                "\n",
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                height: 0.7,
                                fontFamily: 'Chantal',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (item.freeDescription != null)
                                      Text(
                                        item.freeDescription!,
                                        style: TextStyle(
                                          color: pinkColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    Text(
                                      item.product!.brand!,
                                      style: TextStyle(
                                        color: packageColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      item.product!.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1
                                      ),
                                    ),
                                    SizedBox(height: 5)
                                  ],
                                ),
                              ),
                              item.extra!
                                  ? SizedBox(width: 1)
                                  : Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: darkGrey,
                                          ),
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (_) =>
                                                DeleteItem(item: item),
                                            barrierDismissible: false,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
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
                                item.package!.name!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: packageColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          item.extra!
                              ? Text(
                                  "Added : ${item.quantity} Free Qty",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: pinkColor,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (item.package!.displayDiscount !=
                                              null)
                                            Text(
                                              "MRP: ${item.package!.price}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                    height: 1
                                              ),
                                            ),
                                          if (item.flashSale!)
                                            Text(
                                              "Rs: ${item.package!.flashSalePrice}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                height: 1
                                              ),
                                            )
                                          else
                                            Text(
                                              "Rs: ${item.package!.displayPrice}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                child: Container(
                                                  height: 38,
                                                  padding: ptb10,
                                                  decoration: cartLeftButton,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: whiteColor,
                                                    size: 15,
                                                  ),
                                                ),
                                                onTap: () =>
                                                    controller.removeCartItem(
                                                      item.product!.id,
                                                      item.package,
                                                      quantityController,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 38,
                                                padding: ptb10,
                                                color: pinkColor,
                                                child: TextField(
                                                  enableInteractiveSelection:
                                                      false,
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  readOnly: true,
                                                  controller:
                                                      quantityController,
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                        hintText: "1",
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                child: Container(
                                                  height: 38,
                                                  padding: ptb10,
                                                  decoration: cartRightButton,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: whiteColor,
                                                    size: 15,
                                                  ),
                                                ),
                                                onTap: () =>
                                                    controller.addCartItem(
                                                      item.product!.id,
                                                      item.package,
                                                      quantityController,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        onLeftSwipe: (DragUpdateDetails details) => showDialog(
          context: context,
          builder: (_) => DeleteItem(item: item),
          barrierDismissible: false,
        ),
      ),
    );
  }
}

class DeleteItem extends StatelessWidget {
  final Item item;
  const DeleteItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      title: Text('Delete Item', textAlign: TextAlign.center),
      content: Text(
        'Do you want to remove ${item.product!.name} from Cart?',
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: ElevatedButton(
            style: customElevatedButton(pinkColor, whiteColor),
            child: Text('YES'),
            onPressed: () => controller.deleteItem(item.id, item.package!.id),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: ElevatedButton(
            child: Text('NO'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      title: Text('Empty Cart', textAlign: TextAlign.center),
      content: Text(
        'Do you want to empty your Cart?',
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: ElevatedButton(
            style: customElevatedButton(pinkColor, whiteColor),
            child: Text('YES'),
            onPressed: () => controller.emptyCart(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: ElevatedButton(
            child: Text('NO'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class EmptyCartValidation extends StatelessWidget {
  const EmptyCartValidation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/exclamation.png', height: 60),
          SizedBox(height: 20),
          Text(
            'Your Cart is empty please add item into your cart to proceed',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor),
              child: Text('ADD ITEMS'),
              onPressed: () => Navigator.pushNamed(
                context,
                "/",
              ).then((value) => controller.apicall()),
            ),
          ),
        ],
      ),
    );
  }
}

class MinimumAmount extends StatelessWidget {
  final Map data;
  final String textData;
  const MinimumAmount({super.key, required this.data, required this.textData});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/exclamation.png', height: 60),
          SizedBox(height: 20),
          Text('$textData ${data['min_amount']}', textAlign: TextAlign.center),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor),
              child: Text('ADD ITEMS'),
              onPressed: () => Navigator.pushNamed(context, "/"),
            ),
          ),
          Text("*Excluding Delivery Fees", style: TextStyle(color: pinkColor)),
        ],
      ),
    );
  }
}

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/exclamation.png', height: 60),
          SizedBox(height: 20),
          Text(
            'Please add Delivery Address to Continue',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor),
              child: Text('OK'),
              onPressed: () {
                Get.close(1);
                Navigator.pushNamed(context, "/add-address");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InactiveItems extends StatelessWidget {
  final Map data;
  const InactiveItems({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/exclamation.png', height: 60),
          SizedBox(height: 20),
          Text('${data['message']}', textAlign: TextAlign.center),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor),
              child: Text('OK'),
              onPressed: () {
                controller.apicall();
                Get.close(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EndorseProduct extends StatelessWidget {
  final Endorse item;
  const EndorseProduct({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(item.image!),
          SizedBox(height: 10),
          Container(
            padding: plr20,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: customElevatedButton(pinkColor, whiteColor),
              child: Text('ADD MORE ITEMS'),
              onPressed: () => controller.addEndoreProductItem(
                item.product!.id,
                item.package!.id,
              ),
            ),
          ),
          GestureDetector(
            child: Text(
              "No, Thanks",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ChildOrder extends StatelessWidget {
  final Order item;
  const ChildOrder({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Text(
        "You have a pending order ${item.invoiceNumber}.",
        style: TextStyle(fontSize: 15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Date: ${item.deliveryDate}, Time: ${item.deliverySlot}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          Image.asset("assets/images/exclamation.png", height: 80),
          SizedBox(height: 10),
          Text("Do you want to merge this delivery?"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    "/child-cart/${item.orderId}",
                  ),
                  child: Text("YES"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: customElevatedButton(backgroundGrey, Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("NO"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscountApplied extends StatelessWidget {
  final String? discount;
  final List? offers;
  const DiscountApplied({super.key, required this.discount, this.offers});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png", height: 60),
            SizedBox(height: 10),
            Text(
              "\u{20B9} $discount",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text("Discount Applied", style: TextStyle(color: pinkColor)),
            SizedBox(height: 10),
            Column(
              children: offers!.map((title) {
                return Text(title);
              }).toList(),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: customElevatedButton(pinkColor, whiteColor),
                onPressed: () =>
                    Navigator.pushNamed(Get.context!, '/order-review'),
                child: Text("OK"),
              ),
            ),
          ],
        ),
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

@immutable
class SliderProductCard extends StatefulWidget {
  final GlobalProductModel item;
  Package activePackage;
  SliderProductCard({
    super.key,
    required this.item,
    required this.activePackage,
  });

  @override
  SliderProductCardState createState() => SliderProductCardState();
}

class SliderProductCardState extends State<SliderProductCard> {
  @override
  Widget build(BuildContext context) {
    final ProductCardController controller = Get.put(ProductCardController());
    final quantityController = TextEditingController(
      text: "${widget.activePackage.userQuantity}",
    );
    return GestureDetector(
      child: Container(
        padding: plbr10,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .40,
        ),
        margin: EdgeInsets.only(right: 10),
        decoration: circularBoxDecorationWithBorder.copyWith(color: whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.activePackage.imgOne!,
                  width: 150,
                ),
                if (widget.activePackage.displayDiscount != null)
                  Container(
                    padding: p5,
                    decoration: BoxDecoration(
                      color: pinkColor,
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(
                      widget.activePackage.displayDiscount!.replaceAll(
                        " ",
                        "\n",
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 10, 
                        height: 0.7, 
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Chantal',
                        ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.item.brand!, style: TextStyle(color: packageColor)),
            SizedBox(
              width: 120,
              child: Text(
                widget.item.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 5,
              children: widget.item.productPackage!.map<Widget>((item) {
                return GestureDetector(
                  child: Container(
                    height: 26,
                    width: 40,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.activePackage.id == item.id
                            ? packageColor
                            : borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        item.name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          color: widget.activePackage.id == item.id
                              ? packageColor
                              : borderColor,
                        ),
                      ),
                    ),
                  ),
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
                          "MRP: ${widget.activePackage.price}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                            height: 1
                          ),
                        ),
                        Text(
                          "Rs: ${widget.activePackage.displayPrice}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: widget.activePackage.userQuantity! > 0
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
                                    child: Icon(
                                      Icons.remove,
                                      color: whiteColor,
                                      size: 18,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.removeCartItem(
                                      widget.item.id,
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
                                    decoration: InputDecoration.collapsed(
                                      hintText: "1",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  child: Container(
                                    padding: ptb5,
                                    decoration: cartRightButton,
                                    child: Icon(
                                      Icons.add,
                                      color: whiteColor,
                                      size: 18,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.addCartItem(
                                      widget.item.id,
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
                            ],
                          ),
                        )
                      : Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * .15,
                          color: whiteColor,
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: customElevatedButton(pinkColor, whiteColor),
                            child: Text(
                              "ADD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              controller.addCartItem(
                                widget.item.id,
                                widget.activePackage,
                                quantityController,
                              );
                              setState(() {
                                widget.activePackage.userQuantity = int.parse(
                                  quantityController.text,
                                );
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
      onTap: () => Navigator.pushNamed(
        Get.context!,
        "/product-details/${widget.item.slug}",
      ),
    );
  }
}
