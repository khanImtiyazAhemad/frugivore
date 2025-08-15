import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/regex.dart' as regex;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/address/editAddress.dart';
import 'package:frugivore/models/address/editAddress.dart';
import 'package:frugivore/controllers/pincode.dart';

import 'package:frugivore/widgets/custom.dart';

class EditAddressController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = EditAddressDetailModel().obs;
  EditAddressDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  TextEditingController area = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController alternatePhoneNumber = TextEditingController();

  var addressType = "Home".obs;

  InputDecoration inputDecoration(hintText) {
    return InputDecoration.collapsed(hintText: hintText);
  }

  Padding inputText(text) {
    return Padding(padding: ptb10, child: Text(text));
  }

  Container inputTextField(controller, hinttext, {maxline}) {
    return Container(
        padding: p10,
        decoration: shapeDecoration,
        child: TextField(
            style: TextStyle(fontSize: 12),
            maxLines: maxline ?? 1,
            controller: controller,
            decoration: inputDecoration(hinttext)));
  }

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchAddressDetail(uuid);
      if (response != null) {
        _data.value = response;
        PinCodeController.defaultCities(response.city);
        PinCodeController.pinCodeController.text = response.pinCode!;
        area.text = response.area!;
        addressDetail.text = response.address!;
        landmark.text = response.landmark != null ? response.landmark! : "";
        name.text = response.name != null ? response.name! : "";
        email.text = response.email != null ? response.email! : "";
        mobileNumber.text = response.phone!;
        alternatePhoneNumber.text = response.alternatePhone!;
        addressType(response.addressType);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    addressType("Home");
    super.onInit();
  }

  void editAddress() async {
    if (PinCodeController.pinCodeController.text == "") {
      globals.toast("Please enter the Pincode");
    } else if (!regex.pinCodeRegex
        .hasMatch(PinCodeController.pinCodeController.text.trim())) {
      globals.toast("Please enter valid Pincode");
    } else if (area.text.trim() == "") {
      globals.toast("Area can't be blank");
    } else if (addressDetail.text.trim() == "") {
      globals.toast("Address Detail can't be blank");
    } else if (name.text.trim() == "") {
      globals.toast("Name can't be blank");
    } else if (email.text.trim() == "") {
      globals.toast("Email can't be blank");
    } else if (!regex.emailRegex.hasMatch(email.text.trim())) {
      globals.toast("Please enter valid Email");
    } else if (mobileNumber.text.trim() == "") {
      globals.toast("Mobile Number can't be blank");
    } else if (mobileNumber.text.trim() != '' &&
        mobileNumber.text.trim().length != 10) {
      globals.toast(
          "Mobile Number should not be less than or greater than 10 digits");
    } else if (!regex.mobileRegex.hasMatch(mobileNumber.text.trim())) {
      globals.toast("Please enter valid Mobile Number");
    } else if (alternatePhoneNumber.text.trim() != '' &&
        alternatePhoneNumber.text.trim().length != 10) {
      globals.toast(
          "Alternate Mobile Number should not be less than or greater than 10 digits");
    } else if (alternatePhoneNumber.text.trim() != '' &&
        !regex.mobileRegex.hasMatch(alternatePhoneNumber.text.trim())) {
      globals.toast("Please enter valid Alternate Mobile Number");
    } else {
      isLoader(true);
      Map data = {
        "city": PinCodeController.defaultCities.value,
        "pin_code": PinCodeController.pinCodeController.text,
        "area": area.text,
        "address": addressDetail.text,
        "landmark": landmark.text,
        "name": name.text,
        "email": email.text,
        "phone": mobileNumber.text,
        "alternate_phone": alternatePhoneNumber.text,
        "address_type": addressType.value
      };

      var response = await Services.editAddress(uuid, data);
      isLoader(false);
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else if (response != null) {
        Get.back();
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
