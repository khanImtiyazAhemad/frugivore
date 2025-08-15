import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:frugivore/models/searchBar.dart';
import 'package:frugivore/services/searchBar.dart';

class SearchBarController extends GetxController {
  String currentText = "";

  TextEditingController searchField = TextEditingController();
  
  final suggestions = List<ProductAutocompleteModel>.empty(growable: true).obs;

  void changeType(text) {
    currentText = text;
    Services.fetchProductAutoCompleteResults(text).then((response) {
      suggestions.clear();
      suggestions.assignAll(response);
    }).catchError((onError) {});
  }

  void itemClicked(item) {
    Navigator.pushNamed(Get.context!, "/product-details/${item.slug}");
  }

  void textSubmitted(text) {
    // Get.reset();
    Navigator.pushNamedAndRemoveUntil(Get.context!, '/search?qf=$text', (route) => false);
  }

  void clearSearchField() {
    searchField.text = "";
  }
}

class TitleBarSearchBarController extends GetxController {
  String currentText = "";

  final TextEditingController titleBarSearchField = TextEditingController();

  final suggestions = List<ProductAutocompleteModel>.empty(growable: true).obs;

  void changeType(text) {
    currentText = text;
    Services.fetchProductAutoCompleteResults(text).then((response) {
      suggestions.clear();
      suggestions.assignAll(response);
    }).catchError((onError) {});
  }

  void itemClicked(item) {
    Navigator.pushNamed(Get.context!, "/product-details/${item.slug}");
  }

  void textSubmitted(text) {
    titleBarSearchField.text = text;
    String currentRoute = Get.currentRoute;
    // Get.reset();
    if (currentRoute.contains("/search")) {
      Navigator.pushNamedAndRemoveUntil(Get.context!, '/search?qf=$text', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(Get.context!, '/search?qf=$text', (route) => false);
    }
  }

  void clearSearchField() {
    titleBarSearchField.text = "";
  }
}
