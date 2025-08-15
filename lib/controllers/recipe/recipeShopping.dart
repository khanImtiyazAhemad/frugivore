import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/models/recipe/recipeShopping.dart';
import 'package:frugivore/services/recipe/recipeShopping.dart';

class RecipeShoppingController extends GetxController {
  GetStorage box = GetStorage();
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = RecipeShoppingModel().obs;
  RecipeShoppingModel get data => _data.value;
  set data(value) => _data.value = value;

  List<Recipe>? ingredients;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchIngredients(uuid);
      if (response != null) {
        _data.value = response;
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

  void onChangeCheckBox(val, item) {
    item.checkboxValue = val;
  }

  void moveToCart() async {
    List ingredient = [];
    for (var item in data.recipe!) {
      if (item.checkboxValue!) ingredient.add(item.id);
    }
    if (ingredient.isNotEmpty) {
      Map data = {"ingredients": ingredient.join(",")};
      var response = await Services.moveToCart(uuid, data);
      if (response != null) {
        globals.payload['cart'] = ingredient.length.toString();
        globals.payload.refresh();
        Navigator.pushNamed(Get.context!, '/cart').then((_) {
          apicall(uuid);
        });
      }
    } else {
      globals.toast("Please atleast 1 Ingredient to move to cart",
          color: packageColor);
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
