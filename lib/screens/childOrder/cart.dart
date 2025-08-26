import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/childOrder/cart.dart';

import 'package:frugivore/controllers/childOrder/cart.dart';

import 'package:frugivore/connectivity.dart';

class ChildCartPage extends StatelessWidget {
  const ChildCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChildCartController());
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: Obx(
        () => controller.cart.data != null && controller.cart.data!.isNotEmpty
            ? CustomOrderNavigationBar(
                amount: controller.total.value,
                text: "CHECKOUT",
                offer: false,
                controller: controller,
              )
            : CustomConditionalBottomBar(controller: controller),
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
                    : controller.cart.data != null &&
                          controller.cart.data!.isEmpty
                    ? Column(
                      children: [
                        CustomTitleBar(title: "Cart", search: true),
                        Padding(
                            padding: p10,
                            child: Column(
                              children: [
                                Image.asset("assets/images/cart.jpeg"),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: buttonHeight,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: customElevatedButton(
                                      pinkColor,
                                      whiteColor,
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      "/",
                                    ).then((value) => controller.apicall(controller.uuid)),
                                    child: Text("Shop"),
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: buttonHeight,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: customElevatedButton(
                                      pinkColor,
                                      whiteColor,
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      "/my-shopping-lists",
                                      arguments: [],
                                    ).then((value) => controller.apicall(controller.uuid)),
                                    child: Text("Shop from Shopping List"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                    : Column(
                        children: [
                          CustomTitleBar(title: "Cart", search: true),
                          Card(
                            margin: plr10,
                            color: whiteColor,
                            shape: roundedHalfCircularRadius,
                            child: Container(
                              padding: p10,
                              child: Column(
                                children: [
                                  Row(
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
                                        flex: 10,
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
                                            controller
                                                        .activeNormalDateRecord
                                                        .value !=
                                                    ""
                                                ? Text(
                                                    "${controller.parseDateTime(controller.activeNormalDateRecord.value)} at ${controller.selectedTimeSlotTitle.value}",
                                                    style: TextStyle(
                                                      height: 1,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ],
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
                            child: Padding(
                              padding: p10,
                              child: ProductSection(
                                items: controller.cart.data!,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          SavedCardContainer(),
                          SizedBox(height: 15),
                          int.parse(controller.total.value) > 0
                              ? Card(
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
                                          style:
                                              cartRechargeNowCustomElevatedButton(
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
                                )
                              : SizedBox(),
   
 

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
    final controller = Get.put(ChildCartController());
    return Obx(
      () => Card(
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
                  Expanded(
                    flex: 2,
                    child: Text("Rs.${controller.deliveryFee}"),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 10,
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
            ],
          ),
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

class CartProductCard extends StatelessWidget {
  final Item item;
  const CartProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChildCartController());
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
                            padding: EdgeInsets.only(
                              top: 7,
                              left: 5,
                              bottom: 7,
                              right: 5,
                            ),
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
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                                height: 1,
                                              ),
                                            ),
                                          if (item.flashSale!)
                                            Text(
                                              "Rs: ${item.package!.flashSalePrice}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                height: 1,
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
    final controller = Get.put(ChildCartController());
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
            onPressed: () => controller.deleteItem(item.id),
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
    final controller = Get.put(ChildCartController());
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
              onPressed: () => Navigator.pushNamed(context, "/"),
            ),
          ),
        ],
      ),
    );
  }
}

class MinimumAmount extends StatelessWidget {
  final Map data;
  const MinimumAmount({super.key, required this.data});
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
            'Minimum cart amount must be ${data['min_amount']}',
            textAlign: TextAlign.center,
          ),
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
    final controller = Get.put(ChildCartController());
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
                Navigator.pushNamed(context, "/add-address").then((_) {
                  controller.apicall(controller.uuid);
                });
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}