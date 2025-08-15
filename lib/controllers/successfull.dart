import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/successfull.dart';
import 'package:frugivore/models/successfull.dart';

class SuccessfullController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _successfullPage = SuccessfullDetailModel().obs;
  SuccessfullDetailModel get successfullPage => _successfullPage.value;
  set successfullPage(value) => _successfullPage.value = value;

  final data = List<OrderItemDetail>.empty(growable: true).obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchSuccessfullOrderDetail(uuid);
      if (response != null) {
        _successfullPage.value = response;
        data.assignAll(response.result!);
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
    HapticFeedback.heavyImpact();
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
