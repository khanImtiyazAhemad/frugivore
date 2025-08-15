import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/models/offers/discounts.dart';
import 'package:frugivore/services/offers/discounts.dart';

class DiscountsController extends GetxController {
  var isLoader = true.obs;
  String? qsp;

  var wait = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = DiscountModel().obs;
  DiscountModel get data => _data.value;
  set data(value) => _data.value = value;

  final results = List<GlobalProductModel>.empty(growable: true).obs;

  void apicall(qsp) async {
    try {
      isLoader(true);
      var response = await Services.fetchDiscounts(qsp);
      if (response != null) {
        _data.value = response;
        results.assignAll(response.results!);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    qsp = "";
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
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (data.page != data.maxPage && !wait.value) {
      wait(true);
      loadMore(data);
      refreshController.loadComplete();
    }
  }
}
