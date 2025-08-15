import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/childOrder/cart.dart';
import 'package:frugivore/models/childOrder/cart.dart';
import 'package:frugivore/screens/childOrder/cart.dart';

import 'package:frugivore/services/utils.dart';

class ChildCartController extends GetxController {
  var isLoader = true.obs;
  String? uuid;
  var vendor = false.obs;

  var saved = "".obs;
  var deliveryFee = "".obs;
  var subTotal = "".obs;
  var total = "".obs;
  var canEndorse = true.obs;
  var canChildOrder = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _cart = ChildCartModel().obs;
  ChildCartModel get cart => _cart.value;
  set cart(value) => _cart.value = value;

  void emptyCart() async {
    await Services.emptyCart();
    Get.close(1);
    apicall(uuid);
  }

  void deleteItem(id) async {
    await UtilsServices.deleteItem(id);
    Get.close(1);
    apicall(uuid);
  }

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchCartDetail(uuid);
      if (response != null) {
        _cart.value = response;
        vendor(response.vendor);
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
  void onInit() async {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void removeCartItem(product, package, quantity) async {
    quantity.text = (int.parse(quantity.text) - 1).toString();
  
    var response = await UtilsServices.updateCart(
        product, package.id.toString(), quantity.text);
    if (response != null) {
      if (response['apicall']) {
        apicall(uuid);
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

  void addEndoreProductItem(product, package) async {
    var response = await UtilsServices.updateCart(product, package, "1");
    if (response != null) {
      Get.close(1);
      apicall(uuid);
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
        apicall(uuid);
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
    var response = await Services.cartValidation(uuid);
    isLoader(false);
    if (response.containsKey('popup')) {
      if (response['popup'] == "Empty Cart") {
        apicall(uuid);
        showDialog(
          context: Get.context!,
          builder: (_) => EmptyCartValidation(),
          barrierDismissible: false,
        );
      } else if (response['popup'] == "Minimum Amount") {
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
      if (vendor.value) {
        Navigator.pushNamed(Get.context!, '/vendors',
            arguments: ['/child-order-review/$uuid']);
      } else {
        Navigator.pushNamed(Get.context!, '/child-order-review/$uuid');
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
