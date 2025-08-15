import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/orderReview.dart';
import 'package:frugivore/models/orderReview.dart';
import 'package:frugivore/services/utils.dart';
import '../screens/order_review.dart';

class OrderReviewController extends GetxController {
  var isLoader = true.obs;
  var amountPayable = "".obs;
  var sameDayAlert = true.obs;
  var activeDeliveryInstruction = 0.obs;
  var activeDeliveryInstructionText = "".obs;

  List? addressList;
  String? defaultAddress;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController instruction = TextEditingController();

  final _orderReview = OrderReviewModel().obs;
  OrderReviewModel get orderReview => _orderReview.value;
  set orderReview(value) => _orderReview.value = value;

  final deliveryInstruction =
      List<DeliveryInstructionModel>.empty(growable: true).obs;

  void hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

// Delivery Type Controller
  String selectedDeliveryType = "";
  var deliveryType = "".obs;

  void deliveryTypeController(val) {
    deliveryType(val);
    selectedDeliveryType = val;
    amountPayable((int.parse(orderReview.amountPayable ?? "")).toString());
  }

  int carryBagPriceCalculation(value, textFieldValue) {
    if (orderReview.bags!.isNotEmpty) {
      List bagsList = orderReview.bags
          !.where((item) => item.id.toString() == value)
          .toList();
      var price = int.parse(bagsList[0].price);
      var quantity = int.parse(textFieldValue.text);
      return price * quantity;
    } else {
      return 0;
    }
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

  // Option 1 Carry Bag Controller
  final _activeOption1DateRecord = DateRecord().obs;
  DateRecord get activeOption1DateRecord => _activeOption1DateRecord.value;
  set activeOption1DateRecord(value) =>
      _activeOption1DateRecord.value = value;

  final activeOption1TimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController option1CarryBagTextField =
      TextEditingController(text: "1");

  void option1AddCarryBag(value, price) {
    selectedOption1CarryBag(value);
    option1CarryBagTextField.text = "1";
    int carryBagPrice = carryBagPriceCalculation(
        selectedOption1CarryBag.value, option1CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  void option1IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity = int.parse(option1CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option1CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice = carryBagPriceCalculation(
        selectedOption1CarryBag.value, option1CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  void option1DecreaseCarryBagQuantity(price) {
    option1CarryBagTextField.text =
        (int.parse(option1CarryBagTextField.text) - 1).toString();
    if (int.parse(option1CarryBagTextField.text) < 1) {
      option1CarryBagTextField.text = "1";
    }
    int carryBagPrice = carryBagPriceCalculation(
        selectedOption1CarryBag.value, option1CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice).toString());
  }

  var selectedOption1TimeSlot = "".obs;
  var selectedOption1CarryBag = "".obs;
  var option1CarryBag = true.obs;

  // Option 2 Shipment 1 Carry Bag Controller
  final _activeOption2Shipment1DateRecord = DateRecord().obs;
  DateRecord get activeOption2Shipment1DateRecord =>
      _activeOption2Shipment1DateRecord.value;
  set activeOption2Shipment1DateRecord(value) =>
      _activeOption2Shipment1DateRecord.value = value;

  final activeOption2Shipment1TimeRecord = List<Time>.empty(growable: true).obs;
  TextEditingController option2Shipment1CarryBagTextField =
      TextEditingController(text: "1");

  void option2Shipment1AddCarryBag(value, price) {
    selectedOption2Shipment1CarryBag(value);
    option2Shipment1CarryBagTextField.text = "1";
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  void option2Shipment1IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity =
        int.parse(option2Shipment1CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option2Shipment1CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  void option2Shipment1DecreaseCarryBagQuantity(price) {
    option2Shipment1CarryBagTextField.text =
        (int.parse(option2Shipment1CarryBagTextField.text) - 1).toString();
    if (int.parse(option2Shipment1CarryBagTextField.text) < 1) {
      option2Shipment1CarryBagTextField.text = "1";
    }
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  var selectedOption2Shipment1TimeSlot = "".obs;
  var selectedOption2Shipment1CarryBag = "".obs;
  var option2Shipment1CarryBag = true.obs;

  // Option 2 Shipment 2 Carry Bag Controller
  final _activeOption2Shipment2DateRecord = DateRecord().obs;
  DateRecord get activeOption2Shipment2DateRecord =>
      _activeOption2Shipment2DateRecord.value;
  set activeOption2Shipment2DateRecord(value) =>
      _activeOption2Shipment2DateRecord.value = value;

  final activeOption2Shipment2TimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController option2Shipment2CarryBagTextField =
      TextEditingController(text: "1");

  void option2Shipment2AddCarryBag(value, price) {
    selectedOption2Shipment2CarryBag(value);
    option2Shipment2CarryBagTextField.text = "1";
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  void option2Shipment2IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity =
        int.parse(option2Shipment2CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option2Shipment2CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  void option2Shipment2DecreaseCarryBagQuantity(price) {
    option2Shipment2CarryBagTextField.text =
        (int.parse(option2Shipment2CarryBagTextField.text) - 1).toString();
    if (int.parse(option2Shipment2CarryBagTextField.text) < 1) {
      option2Shipment2CarryBagTextField.text = "1";
    }
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption2Shipment1CarryBag.value,
        option2Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption2Shipment2CarryBag.value,
        option2Shipment2CarryBagTextField);
    amountPayable(
        (int.parse(orderReview.amountPayable ?? "") + carryBagPrice1 + carryBagPrice2)
            .toString());
  }

  var selectedOption2Shipment2TimeSlot = "".obs;
  var selectedOption2Shipment2CarryBag = "".obs;
  var option2Shipment2CarryBag = true.obs;

  // Option 3 Shipment 1 Carry Bag Controller
  final _activeOption3Shipment1DateRecord = DateRecord().obs;
  DateRecord get activeOption3Shipment1DateRecord =>
      _activeOption3Shipment1DateRecord.value;
  set activeOption3Shipment1DateRecord(value) =>
      _activeOption3Shipment1DateRecord.value = value;

  final activeOption3Shipment1TimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController option3Shipment1CarryBagTextField =
      TextEditingController(text: "1");

  void option3Shipment1AddCarryBag(value, price) {
    selectedOption3Shipment1CarryBag(value);
    option3Shipment1CarryBagTextField.text = "1";
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment1IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity =
        int.parse(option3Shipment1CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option3Shipment1CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment1DecreaseCarryBagQuantity(price) {
    option3Shipment1CarryBagTextField.text =
        (int.parse(option3Shipment1CarryBagTextField.text) - 1).toString();
    if (int.parse(option3Shipment1CarryBagTextField.text) < 1) {
      option3Shipment1CarryBagTextField.text = "1";
    }
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  var selectedOption3Shipment1TimeSlot = "".obs;
  var selectedOption3Shipment1CarryBag = "".obs;
  var option3Shipment1CarryBag = true.obs;

  // Option 3 Shipment 2 Carry Bag Controller
  final _activeOption3Shipment2DateRecord = DateRecord().obs;
  DateRecord get activeOption3Shipment2DateRecord =>
      _activeOption3Shipment2DateRecord.value;
  set activeOption3Shipment2DateRecord(value) =>
      _activeOption3Shipment2DateRecord.value = value;

  final activeOption3Shipment2TimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController option3Shipment2CarryBagTextField =
      TextEditingController(text: "1");

  void option3Shipment2AddCarryBag(value, price) {
    selectedOption3Shipment2CarryBag(value);
    option3Shipment2CarryBagTextField.text = "1";
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment2IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity =
        int.parse(option3Shipment2CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option3Shipment2CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment2DecreaseCarryBagQuantity(price) {
    option3Shipment2CarryBagTextField.text =
        (int.parse(option3Shipment2CarryBagTextField.text) - 1).toString();
    if (int.parse(option3Shipment2CarryBagTextField.text) < 1) {
      option3Shipment2CarryBagTextField.text = "1";
    }
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  var selectedOption3Shipment2TimeSlot = "".obs;
  var selectedOption3Shipment2CarryBag = "".obs;
  var option3Shipment2CarryBag = true.obs;

  // Option 3 Shipment 3 Carry Bag Controller
  final _activeOption3Shipment3DateRecord = DateRecord().obs;
  DateRecord get activeOption3Shipment3DateRecord =>
      _activeOption3Shipment3DateRecord.value;
  set activeOption3Shipment3DateRecord(value) =>
      _activeOption3Shipment3DateRecord.value = value;

  final activeOption3Shipment3TimeRecord = List<Time>.empty(growable: true).obs;

  TextEditingController option3Shipment3CarryBagTextField =
      TextEditingController(text: "1");

  void option3Shipment3AddCarryBag(value, price) {
    selectedOption3Shipment3CarryBag(value);
    option3Shipment3CarryBagTextField.text = "1";
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment3IncreaseCarryBagQuantity(price) {
    int addCarryBagQuantity =
        int.parse(option3Shipment3CarryBagTextField.text) + 1;
    if (addCarryBagQuantity > 10) {
      globals.toast("You can't add more than 10 Carry bag");
      return;
    }
    option3Shipment3CarryBagTextField.text = addCarryBagQuantity.toString();
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  void option3Shipment3DecreaseCarryBagQuantity(price) {
    option3Shipment3CarryBagTextField.text =
        (int.parse(option3Shipment3CarryBagTextField.text) - 1).toString();
    if (int.parse(option3Shipment3CarryBagTextField.text) < 1) {
      option3Shipment3CarryBagTextField.text = "1";
    }
    int carryBagPrice1 = carryBagPriceCalculation(
        selectedOption3Shipment1CarryBag.value,
        option3Shipment1CarryBagTextField);
    int carryBagPrice2 = carryBagPriceCalculation(
        selectedOption3Shipment2CarryBag.value,
        option3Shipment2CarryBagTextField);
    int carryBagPrice3 = carryBagPriceCalculation(
        selectedOption3Shipment3CarryBag.value,
        option3Shipment3CarryBagTextField);
    amountPayable((int.parse(orderReview.amountPayable ?? "") +
            carryBagPrice1 +
            carryBagPrice2 +
            carryBagPrice3)
        .toString());
  }

  var selectedOption3Shipment3TimeSlot = "".obs;
  var selectedOption3Shipment3CarryBag = "".obs;
  var option3Shipment3CarryBag = true.obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchOrderReviewDetail();
      if (response != null) {
        _orderReview.value = response;
        addressList = response.address;
        amountPayable(response.amountPayable.toString());
        defaultAddress = response.address![0].id.toString();
        if (response.multipleOrder!) {
          selectedDeliveryType = "OPTION1";
          deliveryType("OPTION1");
        }
        if (response.sameDay! && sameDayAlert.value) {
          showDialog(
            context: Get.context!,
            builder: (_) => SameDayAlert(),
            barrierDismissible: true,
          );
        }
      }
      var deliveryInstructionResponse =
          await Services.fetchDeliveryInstruction();
      if (deliveryInstructionResponse != null) {
        deliveryInstruction.assignAll(deliveryInstructionResponse);
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

  void optForSameDayDelivery() {
    selectedDeliveryType = "OPTION2";
    deliveryType("OPTION2");
    Get.close(1);
  }

  void deleteItem(id) async {
    await UtilsServices.deleteItem(id);
    Get.close(1);
    apicall();
  }

  void changeAddress(val) async {
    if (defaultAddress != val) {
      Map data = {"id": val};
      var response = await Services.addressChange(data);
      if (response != null) {
        apicall();
      }
    }
  }

  void validation() async {
    Map<String, dynamic> data = {"delivery_address": defaultAddress};
    if (selectedDeliveryType == "OPTION1") {
      if (selectedOption1TimeSlot.value == "") {
        globals.toast("Please select a valid date and time");
        return;
      }
      data['delivery_type'] = "OPTION1";
      data['option_1'] = {
        "order_type": orderReview.option1!.orderType,
        "delivery_date": activeOption1DateRecord.value,
        "delivery_time": selectedOption1TimeSlot.value,
      };
      if (orderReview.bags!.isNotEmpty) {
        data['option_1']["carry_bag"] = selectedOption1CarryBag.value;
        data['option_1']["carry_bag_quantity"] = option1CarryBagTextField.text;
        data['option_1']["carry_bag_price"] = carryBagPriceCalculation(
            selectedOption1CarryBag.value, option1CarryBagTextField);
      }
    } else if (selectedDeliveryType == "OPTION2") {
      if (selectedOption2Shipment1TimeSlot.value == "") {
        globals.toast(
            "Please select a valid date and time for option 2 shipment 1");
        return;
      } else if (selectedOption2Shipment2TimeSlot.value == "") {
        globals.toast(
            "Please select a valid date and time for option 2 shipment 2");
        return;
      }
      data['delivery_type'] = "OPTION2";
      data['option_2'] = {
        "shipment_1": {
          "cart": orderReview.option2?.shipment1?.cart,
          "order_type": orderReview.option2?.shipment1?.orderType,
          "delivery_date": activeOption2Shipment1DateRecord.value,
          "delivery_time": selectedOption2Shipment1TimeSlot.value,
        },
        "shipment_2": {
          "cart": orderReview.option2?.shipment2?.cart,
          "order_type": orderReview.option2?.shipment2?.orderType,
          "delivery_date": activeOption2Shipment2DateRecord.value,
          "delivery_time": selectedOption2Shipment2TimeSlot.value,
        },
      };
      if (orderReview.bags!.isNotEmpty) {
        data['option_2']["shipment_1"]["carry_bag"] =
            selectedOption2Shipment1CarryBag.value;
        data['option_2']["shipment_1"]["carry_bag_quantity"] =
            option2Shipment1CarryBagTextField.text;
        data['option_2']["shipment_1"]["carry_bag_price"] =
            carryBagPriceCalculation(selectedOption2Shipment1CarryBag.value,
                option2Shipment1CarryBagTextField);
        data['option_2']["shipment_2"]["carry_bag"] =
            selectedOption2Shipment2CarryBag.value;
        data['option_2']["shipment_2"]["carry_bag_quantity"] =
            option2Shipment2CarryBagTextField.text;
        data['option_2']["shipment_2"]["carry_bag_price"] =
            carryBagPriceCalculation(selectedOption2Shipment2CarryBag.value,
                option2Shipment2CarryBagTextField);
      }
    } else if (selectedDeliveryType == "OPTION3") {
      if (selectedOption3Shipment1TimeSlot.value == "") {
        globals.toast(
            "Please select a valid date and time for option 3 shipment 1");
        return;
      } else if (selectedOption3Shipment2TimeSlot.value == "") {
        globals.toast(
            "Please select a valid date and time for option 3 shipment 2");
        return;
      } else if (selectedOption3Shipment3TimeSlot.value == "") {
        globals.toast(
            "Please select a valid date and time for option 3 shipment 3");
        return;
      }
      data['delivery_type'] = "OPTION3";
      data['option_3'] = {
        "shipment_1": {
          "cart": orderReview.option3?.shipment1?.cart,
          "order_type": orderReview.option3?.shipment1?.orderType,
          "delivery_date": activeOption3Shipment1DateRecord.value,
          "delivery_time": selectedOption3Shipment1TimeSlot.value,
        },
        "shipment_2": {
          "cart": orderReview.option3?.shipment2?.cart,
          "order_type": orderReview.option3?.shipment2?.orderType,
          "delivery_date": activeOption3Shipment2DateRecord.value,
          "delivery_time": selectedOption3Shipment2TimeSlot.value,
        },
        "shipment_3": {
          "cart": orderReview.option3?.shipment3.cart,
          "order_type": orderReview.option3?.shipment3.orderType,
          "delivery_date": activeOption3Shipment3DateRecord.value,
          "delivery_time": selectedOption3Shipment3TimeSlot.value,
        },
      };
      if (orderReview.bags!.isNotEmpty) {
        data['option_3']["shipment_1"]["carry_bag"] =
            selectedOption3Shipment1CarryBag.value;
        data['option_3']["shipment_1"]["carry_bag_quantity"] =
            option3Shipment1CarryBagTextField.text;
        data['option_3']["shipment_1"]["carry_bag_price"] =
            carryBagPriceCalculation(selectedOption3Shipment1CarryBag.value,
                option3Shipment1CarryBagTextField);
        data['option_3']["shipment_2"]["carry_bag"] =
            selectedOption3Shipment2CarryBag.value;
        data['option_3']["shipment_2"]["carry_bag_quantity"] =
            option3Shipment2CarryBagTextField.text;
        data['option_3']["shipment_2"]["carry_bag_price"] =
            carryBagPriceCalculation(selectedOption3Shipment2CarryBag.value,
                option3Shipment2CarryBagTextField);
        data['option_3']["shipment_3"]["carry_bag"] =
            selectedOption3Shipment3CarryBag.value;
        data['option_3']["shipment_3"]["carry_bag_quantity"] =
            option3Shipment3CarryBagTextField.text;
        data['option_3']["shipment_3"]["carry_bag_price"] =
            carryBagPriceCalculation(selectedOption3Shipment3CarryBag.value,
                option3Shipment3CarryBagTextField);
      }
    } else {
      if (selectedNormalTimeSlot.value == "") {
        globals.toast("Please select a valid date and time");
        return;
      }
      data["order_type"] = activeNormalDateRecord.orderType ?? "";
      if (orderReview.bags!.isNotEmpty) {
        data["carry_bag"] = selectedCarryBag.value;
        data["carry_bag_quantity"] = carryBagTextField.text;
        data["carry_bag_price"] =
            carryBagPriceCalculation(selectedCarryBag.value, carryBagTextField);
      }

      data["delivery_date"] = activeNormalDateRecord.value;
      data["delivery_time"] = selectedNormalTimeSlot.value;
      data["instruction"] = instruction.text != "" ? instruction.text : "";
      data["delivery_instruction"] = activeDeliveryInstruction.value != 0 ? activeDeliveryInstructionText.value : "";
    }

    isLoader(true);
    var response = await Services.orderCreation(data);
    if (response != null) {
      Navigator.pushReplacementNamed(
          Get.context!, '/payment/${response['uuid']}');
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
