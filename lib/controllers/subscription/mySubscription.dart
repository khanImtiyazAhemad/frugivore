import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/screens/utils.dart';
import 'package:frugivore/services/utils.dart';

import 'package:frugivore/screens/subscription/mySubscription.dart';
import 'package:frugivore/services/subscription/mySubscription.dart';
import 'package:frugivore/models/subscription/mySubscription.dart';

class MySubscriptionController extends GetxController {
  var isLoader = true.obs;

  var wait = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _subscription = MySubscriptionModel().obs;
  MySubscriptionModel get subscription => _subscription.value;
  set subscription(value) => _subscription.value = value;

  final results = List<Result>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchSubscription();
      if (response != null) {
        _subscription.value = response;
        results.assignAll(response.results!);
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

  void activatePlan(uuid) async {
    Get.close(1);
    var response = await UtilsServices.activateSubscription(uuid);
    if (response != null) {
      if (response.containsKey('error')) {
        showDialog(
          context: Get.context!,
          builder: (_) => DynamicPopUp(message: response['error']),
          barrierDismissible: true,
        );
      } else {
        apicall();
      }
    }
  }

  void deactivatePlan(uuid) async {
    Get.close(1);
    var response = await UtilsServices.deactiveSubscription(uuid);
    if (response != null) {
      if (response.containsKey('error')) {
        showDialog(
          context: Get.context!,
          builder: (_) => DynamicPopUp(message: response['error']),
          barrierDismissible: true,
        );
      } else {
        apicall();
      }
    }
  }

  void validation(shoppinglistuuid, item) async {
    var response = await UtilsServices.subscriptionValidation(shoppinglistuuid);
    if (response != null) {
      if (response.containsKey('error')) {
        showDialog(
          context: Get.context!,
          builder: (_) => DynamicPopUp(message: response['error']),
          barrierDismissible: true,
        );
      } else {
        showDialog(
          context: Get.context!,
          builder: (_) => item.isActive
              ? DeactivateSubscriptionPopUp(item: item)
              : ActivateSubscriptionPopUp(item: item),
          barrierDismissible: true,
        );
      }
    }
  }

  void editValidation(shoppinglistuuid, uuid) async {
    var response = await UtilsServices.subscriptionValidation(shoppinglistuuid);
    if (response != null) {
      if (response.containsKey('error')) {
        showDialog(
          context: Get.context!,
          builder: (_) => DynamicPopUp(message: response['error']),
          barrierDismissible: true,
        );
      } else {
        Navigator.pushNamed(Get.context!, '/edit-subscription-plan/$uuid');
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
          if (subscription.page != subscription.maxPage && !wait.value) {
        wait(true);
        loadMore(subscription);
    refreshController.loadComplete();
      }
  }
}
