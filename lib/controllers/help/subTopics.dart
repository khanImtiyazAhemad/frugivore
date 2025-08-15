import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/services/help/subTopics.dart';
import 'package:frugivore/models/help/subTopics.dart';

class SubTopicsController extends GetxController {
  var isLoader = true.obs;
  int? ongoing, past = 0;
  String? uuid, title;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final data = List<HelpSubTopicsModel>.empty(growable: true).obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchHelpSubTopics(uuid);
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
