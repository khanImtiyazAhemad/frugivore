import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VendorController extends GetxController {
  var isLoader = true.obs;
  String? route;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void apicall() async {
    try {
      isLoader(true);
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    route = Get.arguments!.isNotEmpty ? Get.arguments[0] : "/order-review";
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
