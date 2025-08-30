import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;

Widget customBottomImage(image) {
  return Image.asset('assets/images/$image', height: 24);
}

Widget customText(text) {
  return Text(text, style: TextStyle(fontSize: 10));
}

BoxDecoration rightBorder() {
  return BoxDecoration(
    color: whiteColor,
    border: Border(right: BorderSide(color: borderColor)),
  );
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: IphoneHasNotch.hasNotch
          ? EdgeInsets.only(bottom: 22)
          : EdgeInsets.only(bottom: 0),
      color: whiteColor,
      height: 60,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              child: Container(
                decoration: rightBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      getIconFromCss('fat fa-list'),
                      color: primaryColor,
                      size: 24,
                    ),
                    customText("Categories"),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                "/shop-by-categories",
                (route) => false,
                arguments: [],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              child: Container(
                decoration: rightBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      getIconFromCss('fat fa-briefcase-blank'),
                      color: primaryColor,
                      size: 24,
                    ),
                    customText("My Orders"),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                "/my-order/''",
              ).then((value) => setState(() {})),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              child: Container(
                decoration: rightBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      getIconFromCss('fat fa-cart-shopping'),
                      color: primaryColor,
                      size: 24,
                    ),
                    customText("Cart"),
                  ],
                ),
              ),
              onTap: () => CartRouting().routing(),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              child: Container(
                decoration: rightBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      getIconFromCss('fat fa-repeat'),
                      color: primaryColor,
                      size: 24,
                    ),
                    customText("Order Again"),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                "/my-shopping-lists",
                arguments: [],
              ).then((value) => setState(() {})),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    getIconFromCss('fat fa-house'),
                    color: primaryColor,
                    size: 24,
                  ),
                  customText("Home"),
                ],
              ),
              onTap: () => Navigator.pushNamed(
                context,
                "/",
              ).then((value) => setState(() {})),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCartNavigationBar extends StatefulWidget {
  const CustomCartNavigationBar({super.key});

  @override
  CustomCartNavigationBarState createState() => CustomCartNavigationBarState();
}

class CustomCartNavigationBarState extends State<CustomCartNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
        color: Colors.transparent,
      ),
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (globals.payload['cart_message'] != "")
              Container(
                height: 95,
                padding: p5,
                width: double.infinity,
                decoration: topsemicircularBoxDecorationWithBorder.copyWith(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      getIconFromCss('fat fa-handshake'),
                      color: whiteColor,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${globals.payload['cart_message']}",
                      style: TextStyle(color: whiteColor, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            Container(
              decoration: topsemicircularBoxDecorationWithBorder.copyWith(
                color: whiteColor,
              ),
              height: 69,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (globals.payload['sticky_offer_content'] != null &&
                      globals.payload['sticky_offer_content'] != "")
                    Container(
                      padding: p5,
                      width: double.infinity,
                      color: yellowColor,
                      child: Text(
                        "${globals.payload['sticky_offer_content']}",
                        maxLines: 1,
                        style: TextStyle(color: whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${globals.payload['cart']} items",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FaIcon(
                                    getIconFromCss('fat fa-indian-rupee-sign'),
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${globals.payload['final_cart_amount']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                FaIcon(
                                  getIconFromCss('fat fa-piggy-bank'),
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Rs ${globals.payload['total_discounted_price']} Saved",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 30,
                              decoration: semicircularBoxDecorationWithBorder
                                  .copyWith(color: primaryColor),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "View Cart",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () => CartRouting().routing(),
      ),
    );
  }
}

class ActiveOrdersNavigation extends StatelessWidget {
  final dynamic controller;
  const ActiveOrdersNavigation({super.key, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.activeOrders.asMap().entries.map<Widget>((entry) {
            int index = entry.key + 1;       // index here
            var item = entry.value; 
            return GestureDetector(
              child: Container(
                padding: p5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor, // border color
                    width: 1, // border thickness
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.97,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: FaIcon(
                          getIconFromCss('fat fa-basket-shopping'),
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "#${item.invoiceNumber}",
                              style: TextStyle(fontSize: 12, height: 1),
                            ),
                            if (item.orderStatus == "Order Placed")
                              Text(
                                "Order is placed",
                                style: TextStyle(fontSize: 12, height: 1, color: orangeColor),
                              )
                            else if (item.orderStatus == "Order Processed")
                              Text(
                                  "Order is processed",
                                  style: TextStyle(fontSize: 12, height: 1, color: orangeColor),
                                )
                            else if (item.orderStatus == "Out for Delivery")
                              Text(
                                  "Out for Delivery",
                                  style: TextStyle(fontSize: 12, height: 1, color: orangeColor),
                                ),
                            Text(
                              "${item.orderItemText}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, height: 1),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: customViewElevatedButton(
                            primaryColor,
                            whiteColor,
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            "/order-detail/${item!.orderId}",
                          ),
                          child: Text("View", style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 10, // 🔹 Must give height
                        child: VerticalDivider(
                          color: primaryColor,
                          thickness: 1,
                          width: 5,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$index/${controller.activeOrdersLength}", style: TextStyle(fontSize: 10)),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller.activeOrdersLength,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 1,
                                  ),
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: 0 == index ? primaryColor : darkGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                "/order-tracking/${item!.orderId}",
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomConditionalBottomBar extends StatelessWidget {
  final dynamic controller;
  final bool show;
  const CustomConditionalBottomBar({super.key, this.controller, this.show=false});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (int.parse(globals.payload['cart']) > 0) CustomCartNavigationBar(),
          if (int.parse(globals.payload['cart']) == 0 &&
              show && controller.activeOrders != null &&
              controller.activeOrders!.isNotEmpty)
            ActiveOrdersNavigation(controller: controller),
          if (int.parse(globals.payload['cart']) == 0 &&
              globals.payload['sticky_offer_content'] != null &&
              globals.payload['sticky_offer_content'] != "")
            Container(
              padding: p5,
              width: double.infinity,
              color: yellowColor,
              child: Text(
                "${globals.payload['sticky_offer_content']}",
                maxLines: 1,
                style: TextStyle(color: whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          SafeArea(
            minimum: EdgeInsets.only(bottom: 8), // Optional extra space
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}

class CustomOrderNavigationBar extends StatelessWidget {
  final String? amount;
  final String? text;
  final bool? offer;
  final String? offerText;
  final dynamic controller;
  const CustomOrderNavigationBar({
    super.key,
    this.amount,
    this.text,
    this.offer,
    this.offerText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 8), // Optional extra space
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.cart.address != null)
              Container(
                padding: p10,
                color: whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FaIcon(
                        getIconFromCss('fat fa-house'),
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivering to ${controller.cart.address.addressType}",
                            textAlign: TextAlign.left,
                            style: TextStyle(height: 1),
                          ),
                          Text(
                            "${controller.cart.address.name}, ${controller.cart.address.address}, ${controller.cart.address.area} ${controller.cart.address.city}-${controller.cart.address.pinCode}",
                            textAlign: TextAlign.left,
                            style: TextStyle(height: 1),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Change",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: IphoneHasNotch.hasNotch
                  ? EdgeInsets.only(bottom: 22)
                  : EdgeInsets.only(bottom: 0),
              color: primaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (globals.payload['sticky_offer_content'] != null &&
                      globals.payload['sticky_offer_content'] != "")
                    Container(
                      padding: p5,
                      width: double.infinity,
                      color: yellowColor,
                      child: Text(
                        "${globals.payload['sticky_offer_content']}",
                        maxLines: 1,
                        style: TextStyle(color: whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Container(
                    padding: plr15,
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Rs $amount",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (offer!)
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "$offerText!",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                text!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/backArrow.png',
                                  height: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () => controller.validation(),
      ),
    );
  }
}
