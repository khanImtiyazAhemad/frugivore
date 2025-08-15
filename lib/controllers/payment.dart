import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/utils.dart';
import 'package:frugivore/models/payment.dart';
import 'package:frugivore/services/payment.dart';

import 'package:frugivore/screens/payment.dart';

class PaymentController extends GetxController {
  var isLoader = true.obs;
  var wallet = true.obs;
  var netPayable = 0.obs;
  var walletAmount = 0.obs;
  var min = "15".obs;
  var sec = "00".obs;
  var selectedTab = "Exciting Offers".obs;

  String? uuid;
  final _razorpay = Razorpay();

  dynamic timer;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController promocode = TextEditingController();

  final _data = PaymentModel().obs;
  PaymentModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchPaymentDetails(uuid);
      if (response != null) {
        _data.value = response;
        walletAmount(int.parse(response.paymentWalletCalculation!));
        if (int.parse(response.paymentWalletCalculation!) != 0) {
          netPayable(int.parse(response.amountPayable!) -
              int.parse(response.paymentWalletCalculation!));
        } else {
          netPayable(int.parse(response.amountPayable!));
        }
        if (response.remainingTime! < 0) {
          cartRouting();
        }
        tickerRunning(response.remainingTime);
        if (response.cod! && paymentOptions.length == 5) {
          paymentOptions.addAll([
            {
              "title": "Pay by Card/Netbanking at Delivery",
              "leading": Image.asset("assets/images/pod.jpg"),
              "razorpay": false,
              "redirect": "/order-otp"
            },
            {
              "title": "Cash on Delivery(CoD)",
              "leading": Image.asset("assets/images/cod.jpg"),
              "razorpay": false,
              "redirect": "/order-otp"
            }
          ]);
        }
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    if (uuid == null) {
      Navigator.pushReplacementNamed(Get.context!, "/cart");
    } else {
      apicall(uuid);
      super.onInit();
    }
  }

  void changeWallet(val) {
    wallet(true);
    // if (val) {
    //   walletAmount(int.parse(data.paymentWalletCalculation));
    //   netPayable(
    //       int.parse(data.amountPayable) - int.parse(data.paymentWalletCalculation));
    // } else {
    //   walletAmount(0);
    //   netPayable(int.parse(data.amountPayable));
    // }
  }

  void placedWalletOrder() async {
    var response = await Services.placedWalletOrder(uuid!);
    if (response != null) {
      // Get.reset();
      Navigator.pushNamedAndRemoveUntil(
          Get.context!, "/successfull/${response['uuid']}", (route) => false);
    }
  }

  void createRazorPayOrder(method) async {
    Map payload = {'order_id': uuid, 'wallet': wallet.value.toString()};
    var response = await Services.razorpayOrder(payload);
    if (response != null) {
      var options = {
        'key': globals.RAZOR_API_KEY,
        'amount': netPayable.value * 100,
        "name": "Frugviore India Pvt Ltd",
        "description": "Secure Payment Page",
        "theme": {"color": "#787878"},
        'prefill': {
          'name': data.name,
          'contact': data.phone,
          'email': data.email,
          'method': method
        },
        "order_id": response['razorId']
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        throw Exception(e.toString());
      }
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse event) async {
    String qsp =
        "payment=${event.paymentId}&signature=${event.signature}&wallet=${wallet.value}";
    var response = await Services.onlinePayment(uuid, qsp);
    if (response.containsKey('error')) {
      globals.toast(response['error']);
    } else {
      // Get.reset();
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
          Get.context!, "/successfull/${response['uuid']}", (route) => false);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    apicall(uuid);
  }

  // void _handleExternalWalletSelected(ExternalWalletResponse response) {
  //   globals.toast("${response.walletName}");
  //   // showAlertDialog(
  //   //     context, "External Wallet Selected", "${response.walletName}");
  // }

  void tickerRunning(remainingTime) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      remainingTime -= 1000;
      int minValue = (remainingTime / (60 * 1000)).floor();
      min(minValue < 10 ? "0$minValue" : minValue.toString());

      int secValue = ((remainingTime - (minValue * 60 * 1000)) / 1000).floor();
      sec(secValue < 10 ? "0$secValue" : secValue.toString());

      if (remainingTime <= 1000) {
        timer.cancel();
        showDialog(
          context: Get.context!,
          builder: (_) => SessionTimeOutPopUp(),
          barrierDismissible: false,
        );
      }
    });
  }

  void removeOrder() {
    Get.close(1);
    isLoader(true);
    Services.removeOrder(uuid).then((response) {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        timer.cancel();
        Navigator.pushReplacementNamed(Get.context!, "/");
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void repeatOrderReview() async {
    Get.close(1);
    isLoader(true);
    Services.repeatOrderReview(uuid).then((response) {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        timer.cancel();
        // Get.reset();
        cartRouting();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void appliedDiscountCode(uuid, promocode) async {
    Services.appliedDiscountCode(uuid, promocode).then((response) {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        timer.cancel();
        apicall(uuid);
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void cartRouting() async {
    // Get.reset();
    timer.cancel();
    CartRouting().routing();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    timer.cancel();
    apicall(uuid);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    timer.cancel();
    apicall(uuid);
    refreshController.loadComplete();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  List paymentOptions = [
    {
      "title": "Credit Card",
      "leading": Image.asset("assets/images/creditCard.jpg", height: 20),
      "razorpay": true,
      "value": "card",
    },
    {
      "title": "Debit Card",
      "leading": Image.asset("assets/images/debitCard.jpg", height: 20),
      "razorpay": true,
      "value": "card",
    },
    {
      "title": "Netbanking",
      "leading": Image.asset("assets/images/netBanking.jpg", height: 20),
      "razorpay": true,
      "value": "netbanking",
    },
    {
      "title": "UPI",
      "leading": Image.asset("assets/images/upi.jpg", height: 20),
      "razorpay": true,
      "value": "upi",
    },
    {
      "title": "Third Party-Wallet",
      "leading": Image.asset("assets/images/thirdPartyWallet.png", height: 20),
      "razorpay": true,
      "value": "wallet",
    }
  ];
}
