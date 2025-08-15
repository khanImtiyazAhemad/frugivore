import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/screens/utils.dart';
import 'package:frugivore/services/utils.dart';

import 'package:frugivore/services/shoppingList/myShoppingLists.dart';
import 'package:frugivore/screens/shopping_list/myShoppingLists.dart';

import 'package:frugivore/models/shoppingList/myShoppingLists.dart';

class MyShoppingListsController extends GetxController {
  var isLoader = true.obs;

  var wait = false.obs;
  String? popup;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  final _shoppinglist = MyShoppingListModel().obs;
  MyShoppingListModel get shoppinglist => _shoppinglist.value;
  set shoppinglist(value) => _shoppinglist.value = value;

  final results = List<Result>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchShoppingLists();
      if (response != null) {
        _shoppinglist.value = response;
        results.assignAll(response.results!);
        if (popup == "new") {
          showDialog(
            context: Get.context!,
            builder: (_) => NewShoppingListPopUp(),
            barrierDismissible: false,
          ).then((value) => popup = "");
        }
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    if (Get.arguments!.isNotEmpty) popup = Get.arguments[0];
    apicall();
    super.onInit();
  }

  void createShoppingList() async {
    if (name.text == "") {
      globals.toast("Please enter the name of your Shopping list");
    } else {
      Map data = {"name": name.text, "description": description.text};
      var response = await Services.createShoppingList(data);
      if (response != null) {
        Get.close(1);
        Navigator.pushNamed(
                Get.context!, '/edit-shopping-list/${response['uuid']}')
            .then((value) => apicall());
      }
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
        Navigator.pushNamed(Get.context!, "/subscribe-shopping-list/$uuid")
            .then((value) => apicall());
      }
    }
  }

  void loadMore(dataObserver) async {
    try {
      var response = await Services.loadMore(dataObserver.next);
      if (response != null) {
        dataObserver.page = response.page;
        dataObserver.next = response.next;
        dataObserver.previous = response.previous;
        results.addAll(response.results!);
      }
    } finally {
      wait(false);
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
    if (shoppinglist.page != shoppinglist.maxPage && !wait.value) {
      wait(true);
      loadMore(shoppinglist);
      refreshController.loadComplete();
    }
  }
}
