import 'package:frugivore/widgets/custom.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/cart.dart';
import 'package:frugivore/screens/cart.dart';
import 'package:frugivore/screens/utils.dart';

import 'package:frugivore/services/cart.dart';
import 'package:frugivore/services/utils.dart';

class CartController extends GetxController {
  var isLoader = true.obs;
  GetStorage box = GetStorage();

  var saved = "".obs;
  var deliveryFee = "".obs;
  var subTotal = "".obs;
  var total = "".obs;
  var usedWallet = "".obs;
  var canEndorse = true.obs;
  var canChildOrder = true.obs;
  var vendor = false.obs;
  var activeDeliveryInstruction = 0.obs;
  var activeDeliveryInstructionText = "".obs;
  var showTimeContainer = false.obs;
  var timeContainerTitle = "Change".obs;
  var selectedNormalTimeSlot = "".obs;
  var selectedTimeSlotTitle = "".obs;
  String? defaultAddress;


  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final _cart = CartModel().obs;
  CartModel get cart => _cart.value;
  set cart(value) => _cart.value = value;

  final _activeNormalDateRecord = DateRecord().obs;
  DateRecord get activeNormalDateRecord => _activeNormalDateRecord.value;
  set activeNormalDateRecord(value) => _activeNormalDateRecord.value = value;

  final activeNormalTimeRecord = List<Time>.empty(growable: true).obs;

  final deliveryInstruction = List<DeliveryInstructionModel>.empty(
    growable: true,
  ).obs;

  String selectedDeliveryType = "";

  void emptyCart() async {
    await Services.emptyCart();
    Get.close(1);
    apicall();
  }

  void deleteItem(id, package) async {
    await UtilsServices.deleteItem(id);
    Get.close(1);
    apicall();
  }

  void showHideTimeContainer() async {
    if (showTimeContainer.value == true) {
      showTimeContainer(false);
      timeContainerTitle("Change");
    } else {
      showTimeContainer(true);
      timeContainerTitle("Hide");
    }
  }

  String parseDateTime(input) {
    DateTime date = DateFormat("dd-MMM-yyyy").parse(input);
    return DateFormat("MMM dd,yyyy").format(date);
  }

  void apicall() async {
    try {
      isLoader(true);

      var response = await Services.fetchCartDetail();
      if (response != null) {
        _cart.value = response;
        vendor(response.vendor);
        saved(response.saved.toString());
        deliveryFee(response.deliveryFee.toString());
        subTotal(response.subTotal.toString());
        total(response.total.toString());
        usedWallet(response.usedWallet.toString());
        selectedNormalTimeSlot(response.deliverySlot!.id.toString());
        selectedTimeSlotTitle(response.deliverySlot!.title);
        defaultAddress = response.address!.id.toString();
        for (DateRecord item in response.dateRecords!) {
          if (item.checked! && activeNormalDateRecord.value == null) {
            activeNormalDateRecord = item;
            activeNormalTimeRecord.assignAll(item.time!);
            selectedNormalTimeSlot("");
            for (Time time in item.time!) {
              if (selectedNormalTimeSlot.value == "" && !time.disable!) {
                selectedNormalTimeSlot(time.id.toString());
                break;
              }
            }
            break;
          }
        }
        globals.payload['cart'] = response.count.toString();
        globals.payload.refresh();
        if (Get.currentRoute.contains('/cart') &&
            response.child! &&
            canChildOrder.value) {
          showDialog(
            context: Get.context!,
            builder: (_) => ChildOrder(item: response.order!),
            barrierDismissible: false,
          );
          canChildOrder(false);
        } else if (Get.currentRoute.contains('/cart') &&
            response.endorse != null &&
            canEndorse.value) {
          showDialog(
            context: Get.context!,
            builder: (_) => EndorseProduct(item: response.endorse!),
            barrierDismissible: false,
          );
          canEndorse(false);
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
  void onInit() async {
    apicall();
    super.onInit();
  }

  void removeCartItem(product, package, quantity) async {
    quantity.text = (int.parse(quantity.text) - 1).toString();

    var response = await UtilsServices.updateCart(
      product,
      package.id.toString(),
      quantity.text,
    );
    if (response != null) {
      if (response['apicall']) {
        apicall();
      } else {
        saved(response['saved'].toString());
        deliveryFee(response['delivery_fee'].toString());
        subTotal(response['sub_total'].toString());
        total(response['total'].toString());
        usedWallet(response['used_wallet'].toString());
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void addEndoreProductItem(product, package) async {
    var response = await UtilsServices.updateCart(product, package, "1");
    if (response != null) {
      Get.close(1);
      apicall();
    }
  }

  void addCartItem(product, package, quantity) async {
    int addQuantity = int.parse(quantity.text) + 1;
    if (addQuantity > package.maxQty) {
      globals.toast("You can't add more than ${package.maxQty} Quantity");
      return;
    }
    quantity.text = addQuantity.toString();

    var response = await UtilsServices.updateCart(
      product,
      package.id.toString(),
      quantity.text,
    );
    if (response != null) {
      if (response['apicall']) {
        apicall();
      } else {
        quantity.text = response['quantity'].toString();
        saved(response['saved'].toString());
        deliveryFee(response['delivery_fee'].toString());
        subTotal(response['sub_total'].toString());
        total(response['total'].toString());
        usedWallet(response['used_wallet'].toString());
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void validation() async {
    isLoader(true);
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, '/login');
    } else {
      var response = await Services.cartValidation();
      isLoader(false);
      if (response.containsKey('popup')) {
        if (response['popup'] == "Empty Cart") {
          apicall();
          showDialog(
            context: Get.context!,
            builder: (_) => EmptyCartValidation(),
            barrierDismissible: false,
          );
        } else if (response['popup'] == "Minimum Amount") {
          showDialog(
            context: Get.context!,
            builder: (_) => MinimumAmount(
              textData: "Minimum cart value cannot be less than Rs ",
              data: response,
            ),
            barrierDismissible: false,
          );
        } else if (response['popup'] == "Maximum Amount") {
          showDialog(
            context: Get.context!,
            builder: (_) => MinimumAmount(
              textData: "Maximum cart value cannot exceed Rs ",
              data: response,
            ),
            barrierDismissible: false,
          );
        } else if (response['popup'] == "Address") {
          showDialog(
            context: Get.context!,
            builder: (_) => AddAddress(),
            barrierDismissible: false,
          );
        } else if (response['popup'] == "Delivery Address") {
          showDialog(
            context: Get.context!,
            builder: (_) => DynamicPopUp(
              message:
                  "Sorry for the inconvenience! We are not serving at this address",
            ),
            barrierDismissible: true,
          );
        } else if (response['popup'] == "Inactive") {
          showDialog(
            context: Get.context!,
            builder: (_) => InactiveItems(data: response),
            barrierDismissible: false,
          );
        }
      } else {
        if (cart.offers!.isNotEmpty && cart.offers != null) {
          showDialog(
            context: Get.context!,
            builder: (_) => DiscountApplied(
              discount: cart.discountapplied,
              offers: cart.offers,
            ),
            barrierDismissible: true,
          );
        } else {
          Map<String, dynamic> data = {"delivery_address": defaultAddress};
          if (selectedNormalTimeSlot.value == "") {
            globals.toast("Please select a valid date and time");
            return;
          }
          data["order_type"] = activeNormalDateRecord.orderType ?? "";
          data["delivery_date"] = activeNormalDateRecord.value;
          data["delivery_time"] = selectedNormalTimeSlot.value;
          data["instruction"] = "";
          data["delivery_instruction"] = activeDeliveryInstruction.value != 0
              ? activeDeliveryInstructionText.value
              : "";
          isLoader(true);
          var response = await Services.orderCreation(data);
          if (response != null) {
            Navigator.pushReplacementNamed(
              Get.context!,
              '/payment/${response['uuid']}',
            );
          }
        }
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
