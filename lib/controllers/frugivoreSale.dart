import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/frugivoreSale.dart';
import 'package:frugivore/services/frugivoreSale.dart';

class FrugivoreSaleController extends GetxController {
  var isLoader = true.obs;
  var selectedTab = "".obs;
  List<GlobalKey> key = [];
  String? slug;


  ScrollController horizontalScrollController = ScrollController();
  
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  final _data = FrugivoreSaleModel().obs;
  FrugivoreSaleModel get data => _data.value;
  set data(value) => _data.value = value;


  Future<void> apicall(slug) async {
    try {
      isLoader(true);
      var response = await Services.fetchFrugivoreSale(slug);
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    slug = Get.parameters['slug'];
    apicall(slug);
    super.onInit();
  }


  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(slug);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(slug);
    refreshController.loadComplete();
  }
}
