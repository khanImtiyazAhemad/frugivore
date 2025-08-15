import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/offers/deals.dart';
import 'package:frugivore/services/offers/deals.dart';

class DealsController extends GetxController {
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final data = List<DealsModel>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchDeals();
      if (response != null) {
        data.assignAll(response);
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
