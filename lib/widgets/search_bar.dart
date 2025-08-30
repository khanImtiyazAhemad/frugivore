import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'custom.dart';

import 'package:frugivore/models/searchBar.dart';
import 'package:frugivore/controllers/searchBar.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  final SearchBarController controller = Get.put(SearchBarController());
  final GlobalKey<AutoCompleteTextFieldState<ProductAutocompleteModel>> _key =
      GlobalKey<AutoCompleteTextFieldState<ProductAutocompleteModel>>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color(0xff5b5959),
      padding: p5,
      child: Container(
        decoration: ShapeDecoration(
          color: whiteColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: FaIcon(getIconFromCss('fat fa-magnifying-glass'),
                  color: primaryColor, size: 18),
            ),
          ),
          Expanded(
            flex: 8,
            child: AutoCompleteTextField<ProductAutocompleteModel>(
              key: _key,
              decoration:
                  InputDecoration.collapsed(hintText: "I'm looking for..."),
              controller: controller.searchField,
              suggestions: controller.suggestions,
              suggestionsAmount: 20,
              minLength: 3,
              style: TextStyle(fontSize: 12),
              // keyboardType: TextInputType.text,
              textChanged: (text) => controller.changeType(text),
              textSubmitted: (text) => controller.textSubmitted(text),
              itemSubmitted: (text) => controller.itemClicked(text),
              itemBuilder: (context, suggestion) {
                final index = controller.suggestions.indexOf(suggestion);
                return index == 0 && suggestion.recentPurchase != null
                    ? Container(
                        padding: plr15,
                        decoration: boxDecorationBottomBorder.copyWith(color: whiteColor),
                        child: ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: CachedNetworkImage(
                                        imageUrl: suggestion
                                            .recentPurchase!.imageUrl!)),
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
                                            overflow: TextOverflow.ellipsis),
                                        Text(suggestion.name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: FaIcon(
                                      getIconFromCss('fat fa-arrow-right'),
                                      color: primaryColor,
                                      size: 18),
                                )
                              ]),
                        ))
                    : Container(
                        padding: plr15,
                        decoration: boxDecorationBottomBorder.copyWith(color: whiteColor),
                        child: ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FaIcon(
                                      getIconFromCss('fat fa-magnifying-glass'),
                                      color: primaryColor,
                                      size: 18),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Text(suggestion.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                                Expanded(
                                  flex: 1,
                                  child: FaIcon(
                                      getIconFromCss('fat fa-arrow-right'),
                                      color: primaryColor,
                                      size: 18),
                                )
                              ]),
                        ));
              },
              itemSorter: (a, b) => -1,
              itemFilter: (suggestion, input) => suggestion.name!
                  .toLowerCase()
                  .contains(suggestion.name!.toLowerCase()),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: FaIcon(getIconFromCss('fat fa-circle-xmark'),
                    color: primaryColor, size: 18),
                onPressed: () => controller.clearSearchField()),
          ),
        ]),
      ),
    );
  }
}
