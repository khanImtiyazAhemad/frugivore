import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/preOrder/preOrderCart.dart';
import 'package:frugivore/models/preOrder/preOrderCart.dart';
import 'package:frugivore/screens/preOrder/preOrderCart.dart';

import 'package:frugivore/services/utils.dart';

class PreOrderCartController extends GetxController {
  var isLoader = true.obs;

  var saved = "".obs;
  var deliveryFee = "".obs;
  var subTotal = "".obs;
  var total = "".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _cart = PreOrderCartModel().obs;
  PreOrderCartModel get cart => _cart.value;
  set cart(value) => _cart.value = value;

  void emptyCart() async {
    await Services.emptyCart();
    Get.close(1);
    apicall();
  }

  void deleteItem(id) async {
    await UtilsServices.deleteItem(id);
    Get.close(1);
    apicall();
  }

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchCartDetail();
      if (response != null) {
        _cart.value = response;
        saved(response.saved.toString());
        deliveryFee(response.deliveryFee.toString());
        subTotal(response.subTotal.toString());
        total(response.total.toString());
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    apicall();
    super.onInit();
  }

  void removeCartItem(product, package, quantity) async {
    quantity.text = (int.parse(quantity.text) - 1).toString();
    var response = await UtilsServices.updateCart(
        product, package.id.toString(), quantity.text);
    if (response != null) {
      if (response['apicall']) {
        apicall();
      } else {
        quantity.text = response['quantity'].toString();
        saved(response['saved'].toString());
        deliveryFee(response['delivery_fee'].toString());
        subTotal(response['sub_total'].toString());
        total(response['total'].toString());
        globals.toast(response['message']);
      }
    }
  }

  void addCartItem(product, package, quantity) async {
    int addQuantity = int.parse(quantity.text) + 1;
    if (addQuantity > package.maxQty) {
      globals.toast("You can't add more than ${package.maxQty} Quantity");
      return;
    }
    quantity.text = addQuantity.toString();
    var response = await UtilsServices.updateCart(
        product, package.id.toString(), quantity.text);
    if (response != null) {
      if (response['apicall']) {
        apicall();
      } else {
        quantity.text = response['quantity'].toString();
        saved(response['saved'].toString());
        deliveryFee(response['delivery_fee'].toString());
        subTotal(response['sub_total'].toString());
        total(response['total'].toString());
        globals.toast(response['message']);
      }
    }
  }

  void validation() async {
    isLoader(true);
    var response = await Services.cartValidation();
    isLoader(false);
    if (response.containsKey('popup')) {
      if (response['popup'] == "Minimum Amount") {
        showDialog(
          context: Get.context!,
          builder: (_) => MinimumAmount(data: response),
          barrierDismissible: false,
        );
      } else if (response['popup'] == "Maximum Amount") {
        showDialog(
          context: Get.context!,
          builder: (_) => MinimumAmount(data: response),
          barrierDismissible: false,
        );
      } else if (response['popup'] == "Address") {
        showDialog(
          context: Get.context!,
          builder: (_) => AddAddress(),
          barrierDismissible: false,
        );
      } else if (response['popup'] == "Inactive") {
        showDialog(
          context: Get.context!,
          builder: (_) => InactiveItems(data: response),
          barrierDismissible: false,
        );
      }
    } else {
      Navigator.pushNamed(Get.context!, '/pre-order-review');
    }
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall();
    refreshController.loadComplete();
  }

}
