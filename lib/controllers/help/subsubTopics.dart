import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/services/help/subsubTopics.dart';
import 'package:frugivore/models/help/subsubTopics.dart';

class SubSubTopicsController extends GetxController {
  var isLoader = true.obs;
  int? ongoing, past = 0;
  String? uuid, title, orderId;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final data = List<HelpSubSubTopicsModel>.empty(growable: true).obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchHelpSubSubTopics(uuid);
      if (response != null) {
        data.assignAll(response);
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
    uuid = Get.parameters['uuid'];
    title = Get.arguments[0];
    if (Get.arguments.length == 2) {
      orderId = Get.arguments[1];
    }
    apicall(uuid);
    super.onInit();
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
    refreshController.loadComplete();
  }

}
