import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/address/addressList.dart';
import 'package:frugivore/models/address/addressList.dart';

class AddressListController extends GetxController {
  var isLoader = true.obs;
  late String previousRoute;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _addresslist = AddressListModel().obs;
  AddressListModel get addresslist => _addresslist.value;
  set addresslist(value) => _addresslist.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchAddressList();
      _addresslist.value = response;
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    apicall();
    previousRoute = Get.previousRoute;
    super.onInit();
  }

  void deleteAddress(uuid) async {
    Services.deleteAddress(uuid);
    Get.close(1);
    apicall();
  }

  void makeDeliverHere(pk) async {
    dynamic response;
    if (previousRoute.contains("/order-detail")) {
      String orderId = previousRoute.replaceAll("/order-detail/", "");
      response = await Services.makeOrderDeliveryHere(pk, orderId);
      if (response != null) {
        apicall();
        Get.back();
      }
    } else {
      response = await Services.makeDeliverHere(pk);
      if (response != null) {
        apicall();
      }
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
