import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frugivore/regex.dart' as regex;
import 'package:frugivore/globals.dart' as globals;
import 'package:geocoding/geocoding.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/controllers/pincode.dart';
import 'package:frugivore/services/address/add_address.dart';

import 'package:frugivore/widgets/custom.dart';

class AddAddressController extends GetxController {
  var isLoader = false.obs;
  late Position position;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController area = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController name = TextEditingController(
      text:
          globals.payload['name'] != null ? "${globals.payload['name']}" : "");
  TextEditingController email = TextEditingController(
      text: globals.payload['email'] != null
          ? "${globals.payload['email']}"
          : "");
  TextEditingController mobileNumber =
      TextEditingController(text: "${globals.payload['phone']}");
  TextEditingController alternatePhoneNumber = TextEditingController(
      text: globals.payload['alternate_phone'] != null
          ? "${globals.payload['alternate_phone']}"
          : "");

  var addressType = "Home".obs;

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration.collapsed(hintText: hintText);
  }

  Padding inputText(String text) {
    return Padding(padding: ptb10, child: Text(text));
  }

  Container inputTextField(controller, String hinttext, {maxline}) {
    return Container(
        padding: p10,
        decoration: shapeDecoration,
        child: TextField(
            style: TextStyle(fontSize: 12),
            maxLines: maxline ?? 1,
            controller: controller,
            decoration: inputDecoration(hinttext)));
  }

  @override
  void onInit() async {
    addressType("Home");
    await checkPermission();
    super.onInit();
  }

  void addAddress() async {
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
      // print("Save Address $data");
      var response = await Services.addAddress(data);
      isLoader(false);
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else if (response != null) {
        Navigator.pop(Get.context!);
      }
    }
  }

  Future<void> checkPermission() async {
    await asKPermission();
  }

  Future<void> asKPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        await currentPosition();
      }else if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }else if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      await currentPosition();
    }
  }

  Future<void> currentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    _getAddress(position.latitude, position.longitude);
  }

  Future<void> _getAddress(double lat, double lang) async {
    List<Placemark> p = await placemarkFromCoordinates(lat, lang);
    Placemark currentAddress = p[0];
    if (globals.cities.contains(currentAddress.locality)) {
      PinCodeController.defaultCities(currentAddress.locality);
    }
    PinCodeController.pinCodeController.text = currentAddress.postalCode!;
    area.text = currentAddress.subLocality!;
    addressDetail.text = currentAddress.subLocality!;
    // landmark.text = response.landmark;
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
}
