import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/subscription/subscriptionDetail.dart';
import 'package:frugivore/models/subscription/subscriptionDetail.dart';

class SubscriptionDetailController extends GetxController {
  var isLoader = true.obs;
  String? uuid;
  var upcomingSelectedCard = "".obs;
  var previousSelectedCard = "".obs;
  var selectedTab = "Upcoming Occurance".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = SubscriptionDetailModel().obs;
  SubscriptionDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchSubscriptionDetail(uuid);
      if (response != null) {
        _data.value = response;
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
  }

  void skipDate(date, active) {
    isLoader(true);
    Map data = {"skip_date": date, "active": active.toString()};
    Services.skipDate(uuid,data).then((response) async {
      apicall(uuid);
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
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
