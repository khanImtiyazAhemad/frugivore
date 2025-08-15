import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/help/archives.dart';
import 'package:frugivore/models/help/archives.dart';

class ArchivesController extends GetxController {
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = ArchiveModel().obs;
  ArchiveModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchArchive();
      if (response != null) {
        _data.value = response;
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
    refreshController.loadComplete();
  }

}
