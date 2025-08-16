import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/bottom_bar.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/preOrder/preOrderCart.dart';
import 'package:frugivore/controllers/preOrder/preOrderCart.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/connectivity.dart';


class PreOrderCartPage extends StatelessWidget {
  const PreOrderCartPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderCartController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: Obx(() =>
            controller.cart.data != null && controller.cart.data!.isNotEmpty
                ? CustomOrderNavigationBar(
                    amount: controller.total.value,
                    text: "CHECKOUT",
                    offer: false,
                    controller: controller)
                :  CustomConditionalBottomBar(
            controller: controller)),
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
                          : Column(children: [
                              CustomTitleBar(
                                  title: "Pre Order Cart", search: true),
                              Card(
                                  margin: plr10,
                                  shape: roundedCircularRadius,
                                  child: Column(children: [
                                    Padding(
                                        padding: p10,
                                        child: Column(children: [
                                          Padding(
                                              padding: ptb20,
                                              child: Text("Pre Order Cart",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          if (controller.cart.address != null)
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Icon(Icons
                                                      .location_on_rounded),
                                                ),
                                                Expanded(
                                                  flex: 8,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${controller.cart.address!.address}, ${controller.cart.address!.area} ${controller.cart.address!.city}-${controller.cart.address!.pinCode}",
                                                          textAlign:
                                                              TextAlign.left),
                                                      Text(
                                                          "${controller.cart.address!.name} - ${controller.cart.address!.phone}",
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/address-list'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: ElevatedButton(
                                                  style: customElevatedButton(
                                                      yellowColor,
                                                      whiteColor),
                                                  onPressed: () =>
                                                      Navigator.pushNamed(
                                                          context, "/"),
                                                  child: Text("ADD MORE"),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 2,
                                                child: ElevatedButton(
                                                  style: customElevatedButton(
                                                      darkGrey, whiteColor),
                                                  onPressed: () => showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        EmptyCart(),
                                                    barrierDismissible: false,
                                                  ),
                                                  child: Text("EMPTY CART"),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          ProductSection(
                                              items: controller.cart.data!)
                                        ])),
                                    Container(
                                      color: darkGrey,
                                      child: Padding(
                                          padding: p10,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "Saved Rs ${controller.saved.value}",
                                                      style: TextStyle(
                                                          color: yellowColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Image.asset(
                                                        "assets/images/piggy.png")),
                                                VerticalDivider(
                                                    width: 5,
                                                    thickness: 1,
                                                    color: whiteColor),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Sub Total: ${controller.subTotal.value}",
                                                          style: TextStyle(
                                                              color:
                                                                  whiteColor,
                                                              fontSize: 18)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "Delivery Fee: ${controller.deliveryFee.value}",
                                                          style: TextStyle(
                                                              color:
                                                                  whiteColor,
                                                              fontSize: 18))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                        padding: p5,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${controller.cart.message}",
                                              textAlign: TextAlign.start,
                                              style:
                                                  TextStyle(color: pinkColor),
                                            )))
                                  ])),
                              SizedBox(height: 80)
                            ]));
                })))));
  }
}

class ProductSection extends StatelessWidget {
  final List<Datum> items;
  const ProductSection({super.key, required  this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: p10,
                color: backgroundGrey,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  data.name!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )),
            Column(
                children: data.items!.map((product) {
              return CartProductCard(item: product);
            }).toList())
          ],
        );
      }).toList(),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final Item item;
  const CartProductCard({super.key, required  this.item});
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderCartController());
    final quantityController =
        TextEditingController(text: "${item.quantity}");
    return Container(
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        padding: p5,
        width: double.infinity,
        child: Row(children: <Widget>[
          Expanded(
              flex: 3,
              child: Stack(
                // alignment : AlignmentDirectional.topEnd,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CachedNetworkImage(
                      imageUrl: item.package!.imgOne!,
                    ),
                  ),
                  if (item.package!.displayDiscount != null)
                    Container(
                      padding: p10,
                      decoration: BoxDecoration(
                        color: pinkColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        item.package!.displayDiscount!.replaceAll(" ", "\n"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    )
                ],
              )),
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
                                  Text(item.freeDescription!,
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                Text(item.product!.brand!,
                                    style: TextStyle(
                                        color: packageColor, fontSize: 14)),
                                Text(item.product!.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ]),
                        ),
                        item.extra!
                            ? SizedBox(width: 1)
                            : Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon:
                                            Icon(Icons.delete, color: darkGrey),
                                        onPressed: () => showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  DeleteItem(item: item),
                                              barrierDismissible: false,
                                            ))),
                              ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 35,
                      width: 60,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: packageColor, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          item.package!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: packageColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    item.extra!
                        ? Text("Added : ${item.quantity} Free Qty",
                            style: TextStyle(fontSize: 20, color: pinkColor))
                        : Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    if (item.package!.displayDiscount != null)
                                      Text(
                                        "MRP: ${item.package!.price}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    Text(
                                      "Rs: ${item.package!.displayPrice}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
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
                                                    decoration:
                                                        preOrderLeftButton,
                                                    child: Icon(Icons.remove,
                                                        color: whiteColor,
                                                        size: 15)),
                                                onTap: () =>
                                                    controller.removeCartItem(
                                                        item.product!.id,
                                                        item.package,
                                                        quantityController)),
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: 38,
                                            padding: ptb10,
                                            color: packageColor,
                                            child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    color: whiteColor),
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                controller: quantityController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText: "1")),
                                          )),
                                          Expanded(
                                            child: GestureDetector(
                                                child: Container(
                                                    height: 38,
                                                    padding: ptb10,
                                                    decoration:
                                                        preOrderRightButton,
                                                    child: Icon(Icons.add,
                                                        color: whiteColor,
                                                        size: 15)),
                                                onTap: () =>
                                                    controller.addCartItem(
                                                        item.product!.id,
                                                        item.package,
                                                        quantityController)),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                  ],
                ),
              ))
        ]));
  }
}

class DeleteItem extends StatelessWidget {
  final Item item;
  const DeleteItem({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderCartController());
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
                onPressed: () => controller.deleteItem(item.id))),
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                child: Text('NO'),
                onPressed: () => Navigator.of(context).pop())),
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreOrderCartController());
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
                onPressed: () => controller.emptyCart())),
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                child: Text('NO'),
                onPressed: () => Navigator.of(context).pop())),
      ],
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
                  onPressed: () =>
                      Navigator.pushNamed(context, "/"))),
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
    final controller = Get.put(PreOrderCartController());
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
                    Navigator.pushNamed(context, "/add-address").then((_){controller.apicall();});
                  })),
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
          Text(
            '${data['message']}',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop())),
        ],
      ),
    );
  }
}
