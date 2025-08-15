import 'package:get/get.dart';
import 'package:frugivore/globals.dart' as globals;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/models/profile/privacy.dart';
import 'package:frugivore/services/profile/privacy.dart';

class PrivacyController extends GetxController {
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = PrivacyModel().obs;
  PrivacyModel get data => _data.value;
  set profile(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchPrivacyDetail();
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

  void updateProfile(Map? data) async {
    var response = await Services.updateProfile(data);
    // print("Response $response");
    if (response != null) {
      apicall();
      globals.toast("Profile Updated Successfully", color: primaryColor);
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
    apicall();
    refreshController.loadComplete();
  }
}
