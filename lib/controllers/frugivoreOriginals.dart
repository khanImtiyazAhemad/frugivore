import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/frugivoreOriginals.dart';
import 'package:frugivore/services/frugivoreOriginals.dart';

class FrugivoreOriginalsController extends GetxController {
  var isLoader = true.obs;
  var querySubmitted = false.obs;
  var loggedIn = false.obs;

  String? pattern;
  String? qsp;

  var wait = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  final _data = FrugivoreOriginalsModel().obs;
  FrugivoreOriginalsModel get data => _data.value;
  set data(value) => _data.value = value;

  final results = List<GlobalProductModel>.empty().obs;

  Future<void> apicall(qsp) async {
    try {
      isLoader(true);
      var response = await Services.fetchFrugivoreOriginals(qsp);
      if (response != null) {
        _data.value = response;
        results.assignAll(response.results!);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    qsp = "";

    loggedIn(true);

    apicall(qsp);
    super.onInit();
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
    apicall(qsp);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    if (data.page != data.maxPage && !wait.value) {
      wait(true);
      loadMore(data);
      refreshController.loadComplete();
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()

  }
}
