import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/services/utils.dart';

class ProductCardController extends GetxController {
  GetStorage box = GetStorage();


  void notifyItem(package) async {
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, "/login");
    } else {
      var response = await UtilsServices.notifyItem(package.id);
      if (response != null) {
        package.notified = true;
        Get.close(1);
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void removeCartItem(product, package, quantity) async {
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, "/login");
    } else {
      quantity.text = (int.parse(quantity.text) - 1).toString();
      var response = await UtilsServices.updateCart(
          product, package.id.toString(), quantity.text);
      if (response != null) {
        quantity.text = response['quantity'].toString();
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void addCartItem(product, package, quantity) async {
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, "/login");
    } else {
      int addQuantity = int.parse(quantity.text) + 1;
      if (addQuantity > package.maxQty) {
        globals.toast("You can't add more than ${package.maxQty} Quantity");
        return;
      }
      quantity.text = addQuantity.toString();
      var response = await UtilsServices.updateCart(
          product, package.id.toString(), quantity.text);
      if (response != null) {
        quantity.text = response['quantity'].toString();
        globals.toast(response['message'], color: primaryColor);
        if (response['quantity'].toString() == "1") {
          HapticFeedback.heavyImpact();
        }
      }
    }
  }
}
