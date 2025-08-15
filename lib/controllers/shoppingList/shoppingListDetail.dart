import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/screens/utils.dart';
import 'package:frugivore/services/utils.dart';

import 'package:frugivore/services/shoppingList/shoppingListDetail.dart';
import 'package:frugivore/models/shoppingList/shoppingListDetail.dart';

class ShoppingListDetailController extends GetxController {
  String? uuid;
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = ShoppingListDetailModel().obs;
  ShoppingListDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchShoppingListDetail(uuid);
      if (response != null) {
        _data.value = response;
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

  void addToCart() async {
    isLoader(true);
    var response = await UtilsServices.convertToCart(uuid);
    if (response != null) {
      CartRouting().routing();
    }
  }

    void subscribeList(uuid) async {
    var response = await UtilsServices.subscriptionValidation(uuid);
    if (response != null) {
      if (response.containsKey('error')) {
        showDialog(
          context: Get.context!,
          builder: (_) => DynamicPopUp(message: response['error']),
          barrierDismissible: true,
        );
      } else {
        Navigator.pushNamed(Get.context!, "/subscribe-shopping-list/$uuid");
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
