import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/utils.dart';
import 'package:frugivore/services/utils.dart';
import 'package:frugivore/models/order/myOrder.dart';
import 'package:frugivore/services/order/myOrder.dart';
import 'package:frugivore/controllers/home.dart';

class MyOrderController extends GetxController {
  var rate = 0.obs;
  var deliveryBoyRating = 0.obs;
  var isLoader = true.obs;
  String? qsp;
  var selectedCancelOrder = globals.cancelOrder[0].toString().obs;

  var wait = false.obs;

  TextEditingController cancellationReason = TextEditingController();
  TextEditingController comment = TextEditingController();

  Widget textElement(text, size) {
    return Text(text, style: TextStyle(fontSize: size));
  }

  Widget trainLine(flex) {
    return Expanded(
        flex: flex, child: Divider(thickness: 1, color: Colors.black));
  }

  Widget trainElements(flex, content) {
    return Expanded(
      flex: flex,
      child: Column(children: [
        Text(content.text,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 11)),
        if (content.time != null)
          Column(children: [
            if (content.text == "Order Cancelled")
              Icon(Icons.cancel, color: Colors.red, size: 36)
            else
              Icon(Icons.check_box, color: Colors.green, size: 36),
            textElement(content.time, 10.0),
            SizedBox(height: 3),
            textElement(content.date, 11.0)
          ])
        else
          Column(children: [
            Icon(Icons.crop_din, color: Colors.grey, size: 36),
            SizedBox(height: 24)
          ])
      ]),
    );
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _orders = MyOrderModel().obs;
  MyOrderModel get orders => _orders.value;
  set orders(value) => _orders.value = value;

  final results = List<Result>.empty(growable: true).obs;

  void apicall(qsp) async {
    try {
      isLoader(true);
      var response = await Services.fetchOrders(qsp);
      if (response != null) {
        _orders.value = response;
        results.assignAll(response.results!);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    qsp = "-created_date";
    apicall(qsp);
    super.onInit();
  }

  void cancelOrder(uuid) async {
    if (selectedCancelOrder.value == "Select Reason for Cancellation") {
      globals.toast("Please select the cancellation Reason to cancel Order");
    } else {
      Map data = {
        'cancel_subject': selectedCancelOrder.value,
        'cancellation_reason': cancellationReason.text
      };
      var response = await Services.cancelOrder(uuid, data);
      if (response != null) {
        Get.close(1);
        if (Get.currentRoute == "/") {
          HomeController.lastUndeliveredOrderCheck(false);
        } else {
          apicall(qsp);
        }
      }
    }
  }

  void feedback(uuid) async {
    if (rate.value <= 0) {
      globals.toast("Please rate your Order");
    } else if (deliveryBoyRating.value <= 0) {
      globals.toast("Please rate your Delivery Boy");
    } else {
      Map data = {
        'rate': rate.value.toString(),
        'delivery_rating': deliveryBoyRating.value.toString(),
        'comment': comment.text
      };
      var response = await Services.feedback(uuid, data);
      if (response != null) {
        Get.close(1);
        apicall(qsp);
      }
    }
  }

  void repeatOrder(uuid) {
    isLoader(true);
    UtilsServices.repeatOrder(uuid).then((response) async {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        CartRouting().routing();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void loadMore(dataObserver) async {
    try {
      var response = await Services.loadMore(dataObserver.next);
      if (response != null) {
        dataObserver.page = response.page;
        dataObserver.next = response.next;
        dataObserver.previous = response.previous;
        results.addAll(response.results!);
      }
    } finally {
      wait(false);
    }
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
    if (orders.page != orders.maxPage && !wait.value) {
      wait(true);
      loadMore(orders);
      refreshController.loadComplete();
    }
  }
}
