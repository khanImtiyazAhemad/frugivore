import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/wallet/addMoney.dart';
import 'package:frugivore/models/wallet/addMoney.dart';

class AddMoneyController extends GetxController {
  var isLoader = true.obs;

  var selectedAmount = "0".obs;
  var recommendedPromotion = 0.obs;
  var selectedCode = "".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _razorpay = Razorpay();

  final TextEditingController money = TextEditingController(text: "0");

  final _data = AddMoneyModel().obs;
  AddMoneyModel get data => _data.value;
  set data(value) => _data.value = value;

  final offers = List<WalletOffersModel>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchDetail();
      if (response != null) {
        _data.value = response;
      }
      var promotions = await Services.fetchWalletOffers();
      if (promotions != null) {
        offers.assignAll(promotions);
        for (int i = 0; i < promotions.length; i++) {
          if (promotions[i].recommended) {
            selectedAmount(promotions[i].amount.toString());
            selectedCode(promotions[i].code);
            money.text = promotions[i].amount.toString();
            recommendedPromotion(promotions[i].id);
          }
        }
      }
    } finally {
      isLoader(false);
    }
  }

  void addMoney() {
    if (money.text == "") {
      globals.toast("Please enter amount to add into your Wallet");
    } else if (int.parse(money.text) < 1000 || int.parse(money.text) > 20000) {
      globals.toast(
          "You can't charge your wallet with less than Rs 1000 or more than Rs 20000");
    } else {
      var options = {
        'key': globals.razorApiKey,
        'amount': int.parse(money.text) * 100,
        "name": "Frugviore India Pvt Ltd",
        "description": "Secure Payment Page",
        "theme": {"color": "#787878"},
        'prefill': {
          'name': globals.payload['name'],
          'contact': globals.payload['phone'],
          'email': globals.payload['email'],
        }
      };
      // print("OPTION $options");
      try {
        _razorpay.open(options);
      } catch (e) {
        throw Exception(e.toString());
      }
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Services.walletRecharge(response.paymentId, selectedCode.value).then((response) async {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        Get.back();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    apicall();
  }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  //   Services.walletRecharge(response).then((response) async {
  //     if (response.containsKey('error')) {
  //       globals.toast(response['error']);
  //     } else {
  //       Get.back();
  //     }
  //   }).catchError((onError) {
  //     globals.toast(onError.toString());
  //   });
  // }

  @override
  void onInit() {
    apicall();
    super.onInit();
  }

  void changeMoney(amount) {
    selectedAmount(amount);
    money.text = (int.parse(money.text) + int.parse(amount)).toString();
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
