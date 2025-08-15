import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/notification.dart';
import 'package:frugivore/services/notification.dart';

import 'package:frugivore/utils.dart';

class NotificationsController extends GetxController {
  var isLoader = true.obs;
  var wait = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = NotificationModel().obs;
  NotificationModel get data => _data.value;
  set data(value) => _data.value = value;

  final results = List<Result>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchNotifications();
      if (response != null) {
        _data.value = response;
        globals.payload['notification'] = response.count.toString();
        globals.payload.refresh();
        results.assignAll(response.results!);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    apicall();
    super.onInit();
  }

  void readNotification(pk, url) async {
    isLoader(true);
    var response = await Services.readNotification(pk);
    if (response != null) {
      int count = int.parse(globals.payload['notification']);
      if (count > 0) {
        globals.payload['notification'] = (count - 1).toString();
        globals.payload.refresh();
      }
      PromotionBannerRouting(url: url).routing();
    }
  }

  void deleteNotification(pk) {
    Services.deleteNotification(pk).then((response) {
      apicall();
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
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
    if (data.page != data.maxPage && !wait.value) {
      wait(true);
      loadMore(data);
      refreshController.loadComplete();
    }
  }
}
