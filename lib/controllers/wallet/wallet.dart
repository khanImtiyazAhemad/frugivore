import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/wallet/wallet.dart';
import 'package:frugivore/services/wallet/wallet.dart';

class WalletController extends GetxController {
  var isLoader = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final List<PointsBalance> chartData = [];

  final _data = WalletModel().obs;
  WalletModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchWalletDetails();
      if (response != null) {
        _data.value = response;
        chartData.assignAll([
          PointsBalance('Money Balance: Rs.${response.money}', double.parse(response.money!), Color(0xff7cb5ec), "?type=money"),
          PointsBalance('Credit Balance: Rs.${response.credit}', double.parse(response.credit!), Color(0xfff15c80), "?type=credit")
        ]);
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
}

class PointsBalance {
  final String type;
  final double points;
  Color colorval;
  final String qsp;

  PointsBalance(this.type, this.points, this.colorval, this.qsp);
}
