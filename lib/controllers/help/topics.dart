import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/services/help/topics.dart';
import 'package:frugivore/models/help/topics.dart';

class TopicsController extends GetxController {
  var isLoader = true.obs;
  int? ongoing, past = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = HelpTopicsModel().obs;
  HelpTopicsModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchHelpTopics();
      if (response != null) {
        _data.value = response;
      }
      var unreadResponse = await UtilsServices.unreadCount();
      ongoing = unreadResponse['on_going'];
      past = unreadResponse['past'];
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
    refreshController.loadComplete();
  }

}
