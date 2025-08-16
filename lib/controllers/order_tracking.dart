import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/models/order/orderDetail.dart';
import 'package:frugivore/services/order/orderDetail.dart';
import 'package:frugivore/globals.dart' as globals;

class OrderTrackingController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final _data = OrderDetailModel().obs;
  OrderDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  final _activeNormalDateRecord = DateRecord().obs;
  DateRecord get activeNormalDateRecord => _activeNormalDateRecord.value;
  set activeNormalDateRecord(value) => _activeNormalDateRecord.value = value;

  final activeNormalTimeRecord = List<Time>.empty(growable: true).obs;

  var selectedNormalTimeSlot = "".obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchOrderDetail(uuid);
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void changeDeliverySlotDateTime() async {
    if (selectedNormalTimeSlot.value == "") {
      globals.toast(
        "Please select valid date and time to update the delivery date and time",
      );
    } else {
      Map data = {
        "delivery_date": activeNormalDateRecord.value,
        "delivery_time": selectedNormalTimeSlot.value,
      };
      var response = await Services.changeDeliverySlotDateTime(uuid, data);
      if (response != null) {
        apicall(uuid);
        Get.close(1);
      }
    }
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
    apicall(uuid);
    refreshController.loadComplete();
  }
}
