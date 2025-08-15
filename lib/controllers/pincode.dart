import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/models/pincode.dart';
import 'package:frugivore/services/utils.dart';

class PinCodeController extends GetxController {
  static final message = "".obs;
  static var color = packageColor;

  static FocusNode? pinCodeFocus;
  static var defaultCities = "New Delhi".obs;

  static TextEditingController pinCodeController =
      TextEditingController(text: "110033");

  final suggestions = List<PinCodeSearchModel>.empty(growable: true).obs;


  static void changeCities(val) {
    if (PinCodeController.defaultCities.value != val) {
      PinCodeController.pinCodeController.text = "";
    }
    PinCodeController.defaultCities(val);
  }

  void changeType(text) {
    if (text.length <= 0) {
      message("");
      suggestions.assignAll([]);
    } else {
      RegExp exp = RegExp(r"^[0-9]$");
      UtilsServices.fetchArea(text).then((response) {
        suggestions.assignAll(response);
        if (suggestions.isNotEmpty) {
          if (suggestions[0].express!) {
            message("Yes !! Same Day delivery available in your area.");
          } else {
            message("Yes !! Next Day delivery available in your area.");
          }
          color = packageColor;
          defaultCities(suggestions[0].city);
        } else {
          if (!exp.hasMatch(text)) {
            message("Please enter a valid Pin Code for Searching!");
          } else if (exp.hasMatch(text)) {
            message("Sorry, We do not serve your area currently");
          } else {
            message("Please enter your Pin Code for Searching!");
          }
          color = Colors.red;
        }
      }).catchError((onError) {});
    }
  }

  void itemSubmitted(item) {
    PinCodeController.pinCodeController.text = item.pincode;
    if (item.express) {
      message("Yes !! Same Day delivery available in your area.");
    } else {
      message("Yes !! Next Day delivery available in your area.");
    }
    defaultCities(item.city);
    suggestions.assignAll([]);
    color = packageColor;
  }

}
