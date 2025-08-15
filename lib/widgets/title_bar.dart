import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:frugivore/screens/payment.dart';
import 'package:frugivore/models/searchBar.dart';
import 'package:frugivore/controllers/searchBar.dart';

import 'package:frugivore/widgets/custom.dart';

class CustomTitleBar extends StatefulWidget {
  final String? title;
  final bool? search;
  final bool? bottom;
  const CustomTitleBar({
    super.key,
    required this.title,
    required this.search,
    this.bottom = false,
  });

  @override
  CustomTitleBarState createState() => CustomTitleBarState();
}

class CustomTitleBarState extends State<CustomTitleBar> {
  final TitleBarSearchBarController controller = Get.put(
    TitleBarSearchBarController(),
  );
  final GlobalKey<AutoCompleteTextFieldState<ProductAutocompleteModel>> key =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottom! ? 0 : 10),
      color: Color(0xff787878),
      padding: plr10,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              color: whiteColor,
              alignment: Alignment.centerLeft,
              icon: FaIcon(
                getIconFromCss('fat fa-angle-left'),
                color: whiteColor,
                size: 24,
              ),
              onPressed: () {
                String currentRoute = Get.currentRoute;
                if (currentRoute.contains("/payment")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, "/");
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: widget.search!
                ? Container(
                    margin: ptb5,
                    padding: p10,
                    decoration: boxDecoration.copyWith(color: whiteColor),
                    child: AutoCompleteTextField<ProductAutocompleteModel>(
                      key: key,
                      decoration: InputDecoration.collapsed(
                        hintText: "I'm looking for...",
                      ),
                      controller: controller.titleBarSearchField,
                      suggestions: controller.suggestions,
                      style: TextStyle(fontSize: 12),
                      suggestionsAmount: 20,
                      minLength: 3,
                      textChanged: (text) => controller.changeType(text),
                      textSubmitted: (text) => controller.textSubmitted(text),
                      itemSubmitted: (text) => controller.itemClicked(text),
                      itemBuilder: (context, suggestion) {
                        final index = controller.suggestions.indexOf(
                          suggestion,
                        );
                        return index == 0 && suggestion.recentPurchase != null
                            ? Container(
                                padding: plr15,
                                decoration: boxDecorationBottomBorder,
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                    horizontal: 0,
                                    vertical: -4,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: CachedNetworkImage(
                                          imageUrl: suggestion
                                              .recentPurchase!
                                              .imageUrl!,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Purchase on ${suggestion.recentPurchase!.purchased}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              suggestion.name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FaIcon(
                                          getIconFromCss('fat fa-arrow-right'),
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: plr15,
                                decoration: boxDecorationBottomBorder,
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                    horizontal: 0,
                                    vertical: -4,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FaIcon(
                                          getIconFromCss(
                                            'fat fa-magnifying-glass',
                                          ),
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          suggestion.name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FaIcon(
                                          getIconFromCss('fat fa-arrow-right'),
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                      itemSorter: (a, b) => -1,
                      itemFilter: (suggestion, input) => suggestion.name!
                          .toLowerCase()
                          .contains(suggestion.name!.toLowerCase()),
                    ),
                  )
                : Text(
                    "${widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              color: whiteColor,
              alignment: Alignment.centerRight,
              icon: FaIcon(
                getIconFromCss('fat fa-house'),
                color: whiteColor,
                size: 24,
              ),
              onPressed: () {
                String currentRoute = Get.currentRoute;
                if (currentRoute.contains("/payment")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else if (currentRoute.contains("/order-otp")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTrackingTitleBar extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final bool? search;
  final bool? bottom;
  const OrderTrackingTitleBar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.search,
    this.bottom = false,
  });

  @override
  OrderTrackingTitleBarState createState() => OrderTrackingTitleBarState();
}

class OrderTrackingTitleBarState extends State<OrderTrackingTitleBar> {
  final TitleBarSearchBarController controller = Get.put(
    TitleBarSearchBarController(),
  );
  final GlobalKey<AutoCompleteTextFieldState<ProductAutocompleteModel>> key =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottom! ? 0 : 10),
      color: primaryColor,
      padding: plr10,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              color: whiteColor,
              alignment: Alignment.centerLeft,
              icon: FaIcon(
                getIconFromCss('fat fa-angle-left'),
                color: whiteColor,
                size: 24,
              ),
              onPressed: () {
                String currentRoute = Get.currentRoute;
                if (currentRoute.contains("/payment")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, "/");
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: ptb10,
              child: Column(
                children: [
                  Text(
                    "${widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${widget.subTitle}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              color: whiteColor,
              alignment: Alignment.centerRight,
              icon: FaIcon(
                getIconFromCss('fat fa-house'),
                color: whiteColor,
                size: 24,
              ),
              onPressed: () {
                String currentRoute = Get.currentRoute;
                if (currentRoute.contains("/payment")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else if (currentRoute.contains("/order-otp")) {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => CancelOrderPopUp(),
                    barrierDismissible: true,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
