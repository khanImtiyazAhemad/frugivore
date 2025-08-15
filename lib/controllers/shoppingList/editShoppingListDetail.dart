import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/utils.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/models/shoppingList/editShoppingListDetail.dart';
import 'package:frugivore/services/shoppingList/editShoppingListDetail.dart';

class EditShoppingListDetailController extends GetxController {
  String? uuid;
  var isLoader = true.obs;
  String currentText = "";

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController searchField = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  final _data = ShoppingListDetailModel().obs;
  ShoppingListDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  final suggestions =
      List<ShoppingListAutocompleteModel>.empty(growable: true).obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchShoppingListDetail(uuid);
      if (response != null) {
        _data.value = response;
        name.text = response.name!;
        description.text = response.description!;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void changeType(text) async {
    currentText = text;
    var response = await Services.fetchAutoCompleteResults(uuid, text);
    if (response != null) {
      suggestions.assignAll(response);
    }
  }

  void clearSearchField() {
    searchField.text = "";
    suggestions.assignAll([]);
    apicall(uuid);
  }

  void updateShoppingList() async {
    if (name.text == "") {
      globals.toast("Please enter the name of your Shopping list");
    } else {
      Map data = {"name": name.text, "description": description.text};
      var response = await Services.updateShoppingList(uuid, data);
      if (response != null) {
        Get.close(1);
        apicall(uuid);
      }
    }
  }

  void addToCart() async {
    isLoader(true);
    var response = await UtilsServices.convertToCart(uuid);
    if (response != null) {
      CartRouting().routing();
    }
  }

  void deleteItem(itemUuid) async {
    var response = await Services.deleteItem(itemUuid);
    if (response != null) {
      apicall(uuid);
    }
  }

  void updateShoppingListItem(product, package, quantity, type) async {
    if (type == "ADD") {
      quantity.text = (int.parse(quantity.text) + 1).toString();
    } else {
      quantity.text = max((int.parse(quantity.text) - 1), 0).toString();
    }
    Map data = {
      "product": product.toString(),
      "package": package.toString(),
      "quantity": quantity.text
    };
    var response = await Services.updateShoppingListItem(uuid, data);
    if (response != null) {
      if (int.parse(quantity.text) <= 0) {
        apicall(uuid);
      } else {
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(uuid);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(uuid);
    refreshController.loadComplete();
  }

}
