import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/preOrder/preOrder.dart';
import 'package:frugivore/models/preOrder/preOrder.dart';

class PreOrderController extends GetxController {
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = PreOrderModel().obs;
  PreOrderModel get data => _data.value;
  set data(value) => _data.value = value;

  // void emptyCart() async {
  //   await Services.emptyCart();
  //   Get.close(1);
  //   apicall();
  // }

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchPreOrder();
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
    apicall();
    refreshController.loadComplete();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    // closeStream();
    super.onClose();
  }
}
