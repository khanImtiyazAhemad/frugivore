import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderTrackingController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  void apicall() async {
    try {
      isLoader(true);
      uuid = Get.parameters['uuid'];
      // apicall(uuid);
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    apicall();
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
