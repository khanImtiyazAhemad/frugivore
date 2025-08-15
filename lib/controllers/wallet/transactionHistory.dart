import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/wallet/transactionHistory.dart';
import 'package:frugivore/models/wallet/transactionHistory.dart';

class TransactionHistoryController extends GetxController {
  var isLoader = true.obs;
  var clickedHistory = "".obs;
  String? qsp;

  List transactionPoints = ["Recharge", "Referral", "Rewards", "Expired"];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final chart1Data = List<Data>.empty(growable: true).obs;
  final chart2Data = List<Data>.empty(growable: true).obs;

  final _data = TransactionHistoryModel().obs;
  TransactionHistoryModel get data => _data.value;
  set data(value) => _data.value = value;

  Future<void> apicall(qsp) async {
    try {
      isLoader(true);
      var response = await Services.fetchDetail(qsp);
      if (response != null) {
        _data.value = response;
        chart1Data.assignAll(response.data1!);
        chart2Data.assignAll(response.data2!);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    String? qsp = Get.parameters['qsp'];
    apicall(qsp);
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(qsp);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(qsp);
    refreshController.loadComplete();
  }
}
