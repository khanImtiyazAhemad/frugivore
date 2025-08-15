// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/controllers/productCard.dart';

class ProductCard extends StatefulWidget {
  final GlobalProductModel item;
  Package activePackage;
  ProductCard({super.key, required this.item, required this.activePackage});

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  final ProductCardController controller = Get.put(ProductCardController());

  @override
  Widget build(BuildContext context) {
    final quantityController = TextEditingController(
      text: "${widget.activePackage.userQuantity}",
    );

    return GestureDetector(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border(top: BorderSide(color: borderColor)),
            ),
            padding: widget.item.recentPurchase != null ? ptlr10 : p10,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              SizedBox(
                                // width:
                                //     MediaQuery.of(context).size.width * 0.3,
                                child: widget.activePackage.imgOne != null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.activePackage.imgOne!,
                                      )
                                    : Image.asset('assets/images/logo.png'),
                              ),
                              if (widget.activePackage.displayDiscount != null)
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: pinkColor,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Text(
                                    widget.activePackage.displayDiscount!
                                        .replaceAll(" ", "\n"),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontFamily: 'Chantal',
                                      height: 0.8,
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (widget.activePackage.offerTitle != null)
                                  Text(
                                    widget.activePackage.offerTitle,
                                    style: TextStyle(
                                      color: pinkColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                Text(
                                  widget.item.brand!,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: Text(
                                    widget.item.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xff525252),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (widget.item.productIcons!.isNotEmpty)
                                  UnconstrainedBox(
                                    child: Padding(
                                      padding: pt5,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                          color: primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                getIconFromCss('fat fa-stars'),
                                                color: whiteColor,
                                                size: 14,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${widget.item.productIcons![0].name}",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 10),
                                Wrap(
                                  children: widget.item.productPackage!
                                      .map<Widget>((packageItem) {
                                        return GestureDetector(
                                          child: Container(
                                            height: 24,
                                            width: 50,
                                            margin: EdgeInsets.only(
                                              right: 5,
                                              bottom: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    widget.activePackage.id ==
                                                        packageItem.id
                                                    ? packageColor
                                                    : borderColor,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                packageItem.name!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      widget.activePackage.id ==
                                                          packageItem.id
                                                      ? packageColor
                                                      : borderColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              widget.activePackage =
                                                  packageItem;
                                            });
                                          },
                                        );
                                      })
                                      .toList(),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (widget
                                                  .activePackage
                                                  .displayDiscount !=
                                              null)
                                            Text(
                                              "MRP: Rs ${widget.activePackage.price}",
                                              style: TextStyle(
                                                color: darkGrey,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          Text(
                                            "Rs: ${widget.activePackage.displayPrice}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    widget.item.isPromotional!
                                        ? Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: 40,
                                              decoration: boxDecoration,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "NOT FOR SALE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: pinkColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : widget.activePackage.stock! <= 0
                                        ? Expanded(
                                            flex: 5,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                style:
                                                    notifyMeCustomElevatedButton(
                                                      whiteColor,
                                                      pinkColor,
                                                      backgroundGrey,
                                                    ),
                                                child: Text(
                                                  "NOTIFY ME",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                onPressed: () => showDialog(
                                                  context: Get.context!,
                                                  builder: (_) => NotifyMe(
                                                    activePackage:
                                                        widget.activePackage,
                                                  ),
                                                  barrierDismissible: true,
                                                ),
                                              ),
                                            ),
                                          )
                                        : widget.item.deliveryType ==
                                              "PRE ORDER"
                                        ? widget.activePackage.userQuantity! > 0
                                              ? Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: GestureDetector(
                                                            child: Container(
                                                              height: 38,
                                                              padding: p10,
                                                              decoration:
                                                                  preOrderLeftButton,
                                                              child: Icon(
                                                                Icons.remove,
                                                                color:
                                                                    whiteColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              controller.removeCartItem(
                                                                widget.item.id,
                                                                widget
                                                                    .activePackage,
                                                                quantityController,
                                                              );
                                                              setState(() {
                                                                widget
                                                                    .activePackage
                                                                    .userQuantity = int.parse(
                                                                  quantityController
                                                                      .text,
                                                                );
                                                              });
                                                            },
                                                          ),
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
                                                                color:
                                                                    whiteColor,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              readOnly: true,
                                                              controller:
                                                                  quantityController,
                                                              decoration:
                                                                  InputDecoration.collapsed(
                                                                    hintText:
                                                                        "1",
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: GestureDetector(
                                                            child: Container(
                                                              height: 38,
                                                              padding: p10,
                                                              decoration:
                                                                  preOrderRightButton,
                                                              child: Icon(
                                                                Icons.add,
                                                                color:
                                                                    whiteColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              controller.addCartItem(
                                                                widget.item.id,
                                                                widget
                                                                    .activePackage,
                                                                quantityController,
                                                              );
                                                              setState(() {
                                                                widget
                                                                    .activePackage
                                                                    .userQuantity = int.parse(
                                                                  quantityController
                                                                      .text,
                                                                );
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton(
                                                      style:
                                                          customElevatedButton(
                                                            packageColor,
                                                            whiteColor,
                                                          ),
                                                      child: Text(
                                                        "PRE ORDER",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10,
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
                                                          widget
                                                                  .activePackage
                                                                  .userQuantity =
                                                              int.parse(
                                                                quantityController
                                                                    .text,
                                                              );
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )
                                        : widget.activePackage.userQuantity! > 0
                                        ? Expanded(
                                            flex: 5,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Container(
                                                        padding: ptb10,
                                                        height: 38,
                                                        decoration:
                                                            cartLeftButton,
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: whiteColor,
                                                          size: 15,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        controller.removeCartItem(
                                                          widget.item.id,
                                                          widget.activePackage,
                                                          quantityController,
                                                        );
                                                        setState(() {
                                                          widget
                                                                  .activePackage
                                                                  .userQuantity =
                                                              int.parse(
                                                                quantityController
                                                                    .text,
                                                              );
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: ptb10,
                                                      height: 38,
                                                      color: pinkColor,
                                                      child: TextField(
                                                        enableInteractiveSelection:
                                                            false,
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                        decoration:
                                                            cartRightButton,
                                                        child: Icon(
                                                          Icons.add,
                                                          color: whiteColor,
                                                          size: 15,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        controller.addCartItem(
                                                          widget.item.id,
                                                          widget.activePackage,
                                                          quantityController,
                                                        );
                                                        setState(() {
                                                          widget
                                                                  .activePackage
                                                                  .userQuantity =
                                                              int.parse(
                                                                quantityController
                                                                    .text,
                                                              );
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            flex: 5,
                                            child: Container(
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
                                                    fontSize: 11,
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
                                                    widget
                                                            .activePackage
                                                            .userQuantity =
                                                        int.parse(
                                                          quantityController
                                                              .text,
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
                        ),
                      ],
                    ),
                    if (widget.item.recentPurchase != null)
                      Container(
                        padding: p10,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Purchased ${widget.item.recentPurchase!.totalItems} Items",
                              style: TextStyle(height: 1),
                            ),
                            Text(
                              "Last Purchased on ${widget.item.recentPurchase!.purchased}",
                              style: TextStyle(height: 1),
                            ),
                            Text(
                              "${widget.item.recentPurchase!.packageName}(Quantity:${widget.item.recentPurchase!.quantity})",
                              style: TextStyle(height: 1),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: pt10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: borderColor),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      height: 20,
                                      child: ElevatedButton(
                                        style:
                                            recentPurchaseCustomElevatedButton(
                                              whiteColor,
                                              Color(0xff3498db),
                                            ),
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          "/order-detail/${widget.item.recentPurchase!.orderId}",
                                        ),
                                        child: Text(
                                          "View Order",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (widget
                                      .item
                                      .recentPurchase!
                                      .canGiveFeedback!)
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: borderColor,
                                              width: 1,
                                            ), // Right border
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          style:
                                              recentPurchaseCustomElevatedButton(
                                                whiteColor,
                                                Color(0xff3498db),
                                              ),
                                          onPressed: () => Navigator.pushNamed(
                                            context,
                                            "/order-detail/${widget.item.recentPurchase!.orderId}",
                                          ),
                                          child: Text(
                                            "Order Review",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  // Expanded(
                                  //     flex: 1,
                                  //     child: Container(
                                  //       height: 30,
                                  //       decoration: BoxDecoration(
                                  //         border: Border(
                                  //           left: BorderSide(
                                  //               color: borderColor,
                                  //               width: 1), // Right border
                                  //         ),
                                  //       ),
                                  //       child: ElevatedButton(
                                  //           child: Text("Product Review",
                                  //               textAlign: TextAlign.center,
                                  //               style:
                                  //                   TextStyle(fontSize: 12)),
                                  //           style:
                                  //               recentPurchaseCustomElevatedButton(
                                  //                   whiteColor,
                                  //                   Color(0xff3498db)),
                                  //           onPressed: () => Navigator.pushNamed(
                                  //               context,
                                  //               '/product-details/${widget.item.slug}')),
                                  //     ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                // Image.asset(
                //     item.veg ? 'assets/images/veg.png' : 'assets/images/nonVeg.png',
                //     height: 10)
              ],
            ),
          ),
        ],
      ),
      onTap: () =>
          Navigator.pushNamed(context, '/product-details/${widget.item.slug}'),
    );
  }
}

class NotifyMe extends StatelessWidget {
  final Package activePackage;
  NotifyMe({super.key, required this.activePackage});
  final ProductCardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/orderPlaced.png', height: 60),
          SizedBox(height: 20),
          activePackage.notified!
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
                        onPressed: () => controller.notifyItem(activePackage),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
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
  final ProductCardController controller = Get.put(ProductCardController());
  @override
  Widget build(BuildContext context) {
    final quantityController = TextEditingController(
      text: "${widget.activePackage!.userQuantity}",
    );
    return GestureDetector(
      child: Container(
        padding: plbr10,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .40,
        ),
        margin: EdgeInsets.only(right: 5),
        decoration: circularBoxDecorationWithBorder.copyWith(color: whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.activePackage!.imgOne!,
                  width: 150,
                ),
                if (widget.item.recentPurchase != null)
                  Row(
                    children: [
                      if (widget.activePackage!.displayDiscount != null)
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 7, left: 5, bottom: 7, right: 5),
                            decoration: BoxDecoration(
                              color: pinkColor,
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(
                              widget.activePackage!.displayDiscount!.replaceAll(
                                " ",
                                "\n",
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Chantal',
                                height: 0.8,
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Color(0xff808080),
                          padding: EdgeInsets.all(3),
                          child: Text(
                            "Purchased on ${widget.item.recentPurchase!.purchased}",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(color: whiteColor, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget.item.recentPurchase == null &&
                    widget.activePackage!.displayDiscount != null)
                  Container(
                    padding: p7,
                    decoration: BoxDecoration(
                      color: pinkColor,
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(
                      widget.activePackage!.displayDiscount!.replaceAll(
                        " ",
                        "\n",
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Chantal',
                        height: 0.8,
                        color: Colors.white,
                        fontSize: 10,
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
                    height: 24,
                    width: 50,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.activePackage!.id == item.id
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
                          fontSize: 10,
                          color: widget.activePackage!.id == item.id
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
                          "MRP: Rs ${widget.activePackage!.price}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "Rs: ${widget.activePackage!.displayPrice}",
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
                                      widget.activePackage!.userQuantity =
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
                                      widget.activePackage!.userQuantity =
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
                                widget.activePackage!.userQuantity = int.parse(
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
      onTap: () =>
          Navigator.pushNamed(context, '/product-details/${widget.item.slug}'),
    );
  }
}
