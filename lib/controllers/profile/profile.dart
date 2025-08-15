import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frugivore/regex.dart' as regex;
import 'package:frugivore/globals.dart' as globals;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/profile/profile.dart';
import 'package:frugivore/services/utils.dart';

import 'package:frugivore/models/utils.dart';

import 'package:frugivore/widgets/custom.dart';

class ProfileController extends GetxController {
  var isLoader = true.obs;
  var avatarChange = false.obs;
  var gender = "".obs;
  var confirmation = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController alternatePhone = TextEditingController();
  dynamic selectedDate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  File? avatarImage;

  final _profile = ProfileModel().obs;
  ProfileModel get profile => _profile.value;
  set profile(value) => _profile.value = value;

  final picker = ImagePicker();
  void openGallery() async {
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    avatarChange(false);
    avatarImage = File(image!.path);
    avatarChange(true);
  }

  InputDecoration inputDecoration(hintText) {
    return InputDecoration.collapsed(hintText: hintText);
  }

  InputDecoration inputDateDecoration(hintText) {
    return InputDecoration.collapsed(
      // icon: Icon(Icons.event_note),
      hintText: hintText,
    );
  }

  Padding inputText(text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container inputTextField(controller, hinttext, {maxline}) {
    return Container(
      padding: p15,
      decoration: shapeDecoration,
      child: TextField(
        maxLines: maxline ?? 1,
        controller: controller,
        decoration: inputDecoration(hinttext),
      ),
    );
  }

  Container inputPrefixTextField(controller, hinttext, {maxline, enabled}) {
    return Container(
        padding: p15,
        decoration: shapeDecoration,
        child: Row(children: [
          Expanded(flex: 1, child: Text("+91")),
          SizedBox(width: 5),
          Expanded(
            flex: 9,
            child: TextField(
              enabled: enabled != null ? false : true,
              maxLines: maxline ?? 1,
              controller: controller,
              decoration: inputDecoration(hinttext),
            ),
          )
        ]));
  }

  void apicall() async {
    try {
      isLoader(true);
      confirmation(false);
      var response = await UtilsServices.fetchProfile();
      if (response != null) {
        _profile.value = response;
        name.text = response.name!;
        email.text = response.email!;
        phone.text = response.phone!;
        alternatePhone.text = response.alternatePhone != null ? response.alternatePhone! : "";
        gender(response.gender);
        if (response.dateOfBirth != null) selectedDate = response.dateOfBirth;
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

  void updateProfile() async {
    if (name.text == "") {
      globals.toast("Please enter your name");
    } else if (email.text == "") {
      globals.toast("Please enter your email");
    } else if (!regex.emailRegex.hasMatch(email.text.trim())) {
      globals.toast("Please enter valid Email");
    } else if (phone.text == "") {
      globals.toast("Please enter your Mobile Number");
    } else if (phone.text.trim() != '' && phone.text.trim().length != 10) {
      globals.toast(
          "Mobile Number should not be less than or greater than 10 digits");
    } else if (!regex.mobileRegex.hasMatch(phone.text.trim())) {
      globals.toast("Please enter valid Mobile Number");
    } else if (alternatePhone.text.trim() != '' &&
        alternatePhone.text.trim().length != 10) {
      globals.toast(
          "Alternate Mobile Number should not be less than or greater than 10 digits");
    } else if (alternatePhone.text.trim() != '' &&
        !regex.mobileRegex.hasMatch(alternatePhone.text.trim())) {
      globals.toast("Please enter valid Alternate Mobile Number");
    } else {
      Map<String, String> data = {
        "name": name.text,
        "email": email.text,
        "phone": phone.text,
        "gender": gender.value
      };
      if (selectedDate != null) {
        data["date_of_birth"] = formatter.format(selectedDate);
      }
      if (alternatePhone.text != "") {
        data["alternate_phone"] = alternatePhone.text;
      }
      var response = await Services.updateProfile(data, avatarImage);
      // print("Response $response");
      if (response != null) {
        // confirmation(true);
        apicall();
        globals.toast("Profile Updated Successfully", color: primaryColor);
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
