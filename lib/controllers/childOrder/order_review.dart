import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/childOrder/orderReview.dart';
import 'package:frugivore/models/childOrder/orderReview.dart';

class ChildOrderReviewController extends GetxController {
  var isLoader = true.obs;
  var amountPayable = "".obs;

  String? uuid;

  List? addressList;
  String? defaultAddress;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController instruction = TextEditingController();

  final _orderReview = ChildOrderReviewModel().obs;
  ChildOrderReviewModel get orderReview => _orderReview.value;
  set orderReview(value) => _orderReview.value = value;

// Delivery Type Controller
  String selectedDeliveryType = "";
  var deliveryType = "".obs;

  void deliveryTypeController(String val) {
    deliveryType(val);
    selectedDeliveryType = val;
  }

  int carryBagPriceCalculation(value, textFieldValue) {
    List bagsList =
        orderReview.bags!.where((item) => item.id.toString() == value).toList();
    var price = int.parse(bagsList[0].price);
    var quantity = int.parse(textFieldValue.text);
    return price * quantity;
  }

  // Normal Carry Bag Controller

  final _activeNormalDateRecord = DateRecord().obs;
  DateRecord get activeNormalDateRecord => _activeNormalDateRecord.value;
  set activeNormalDateRecord(value) =>
      _activeNormalDateRecord.value = value;

  final activeNormalTimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController carryBagTextField = TextEditingController(text: "1");

  void addCarryBag(value, price) {
    selectedCarryBag(value);
    carryBagTextField.text = "1";
    int carryBagPrice =
        carryBagPriceCalculation(selectedCarryBag.value, carryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  void increaseCarryBagQuantity(price) {
    int addCarryBagQuantity = int.parse(carryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    carryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice =
        carryBagPriceCalculation(selectedCarryBag.value, carryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  void decreaseCarryBagQuantity(price) {
    carryBagTextField.text = (int.parse(carryBagTextField.text) - 1).toString();
    if (int.parse(carryBagTextField.text) < 1) {
      carryBagTextField.text = "1";
    }
    int carryBagPrice =
        carryBagPriceCalculation(selectedCarryBag.value, carryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  var selectedNormalTimeSlot = "".obs;
  var selectedCarryBag = "".obs;
  var carryBag = true.obs;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchOrderReviewDetail(uuid);
      if (response != null) {
        _orderReview.value = response;
        addressList = [response.address];
        amountPayable(response.amountPayable.toString());
        defaultAddress = response.address!.id.toString();
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void validation() async {
    if (selectedNormalTimeSlot.value == "") {
      globals.toast("Please select a valid date and time");
    } else {
      Map<String, dynamic> data = {"delivery_address": defaultAddress};
      data["carry_bag"] = selectedCarryBag.value;
      data["carry_bag_quantity"] = carryBagTextField.text;
      data["carry_bag_price"] =
          carryBagPriceCalculation(selectedCarryBag.value, carryBagTextField);
      data["delivery_date"] = activeNormalDateRecord.value;
      data["delivery_time"] = selectedNormalTimeSlot.value;
      data["instruction"] = instruction.text;

      isLoader(true);
      var response = await Services.orderCreation(uuid, data);
      if (response != null) {
        Navigator.pushReplacementNamed(
            Get.context!, '/payment/${response['uuid']}');
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
