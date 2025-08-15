import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:frugivore/regex.dart' as regex;
import 'package:frugivore/globals.dart' as globals;

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/models/staticPages/referAndEarn.dart';
import 'package:frugivore/services/staticPages/referAndEarn.dart';

class ReferEarnController extends GetxController {
  var isLoader = true.obs;
  var showLess = true.obs;
  List contacts = [].obs;
  List filteredContacts = [].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController referralCode =
      TextEditingController(text: globals.payload['referral_code']);
  final TextEditingController email = TextEditingController();
  final TextEditingController searchContacts = TextEditingController();

  final _data = ReferEarnModel().obs;
  ReferEarnModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchCondition();
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    await askPermissions();
    apicall();
    super.onInit();
  }

  void submitReference() {
    if (email.text == '') {
      globals.toast("Please enter your friend's email/phone for referral");
    } else if (email.text.trim() != '' && email.text.trim().length != 10) {
      globals.toast(
          "Mobile Number should not be less than or greater than 10 digits");
    } else if (!regex.mobileRegex.hasMatch(email.text.trim())) {
      globals.toast("Please enter valid Mobile Number");
    } else {
      Map data = {'email': email.text.trim()};
      Services.submitReference(data).then((response) {
        email.text = "";
        if (response.containsKey('message')) {
          globals.toast(response['message'], color: primaryColor);
        }
      }).catchError((onError) {
        globals.toast(onError, color: primaryColor);
      });
    }
  }

  String baseMessage =
      "Here's something to delight you! I invite you to a Frugivore experience of grocery and foods shopping. 🤩🥰 \n\n Below is my referral code that you can use to get INR 150 off on your first order: \n ${globals.payload['referral_code']} or just click on link https://frugivore.in/REFERRAL/${globals.payload['referral_code']}/ .\nWhat's more? You will also get 50% cashback on your first order.  🥳🤩😎";
  void referralCopy() {
    FlutterClipboard.copy(baseMessage).then((value) => globals
        .toast("Copied share message to Clipboard", color: primaryColor));
  }

  Future<void> launchWhatsapp({number}) async {
    String url;
    if (number != null) {
      if (number.contains("+91")) {
        number = number.replaceAll(" ", "");
      } else {
        number = '+91$number.replaceAll(" ", "")';
      }

      url = Uri.encodeFull("https://wa.me/$number?text=$baseMessage");
    } else {
      url = Uri.encodeFull("https://api.whatsapp.com/send?text=$baseMessage");
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchEmail() async {
    Uri url = Uri.parse("mailto:?subject=Referral Code to Avail INR 150&body=$baseMessage");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void invite(value) {
    Map data = {'email': value.replaceAll("+91 ", "").replaceAll(" ", "")};
    Services.submitReference(data).then((response) {
      email.text = "";
      if (response.containsKey('message')) {
        globals.toast(response['message'], color: primaryColor);
        apicall();
      }
    }).catchError((onError) {
      globals.toast(onError, color: primaryColor);
    });
  }

  void searchContactsMethod(value) {
    if (value!.isNotEmpty) {
      filteredContacts.assignAll(contacts.where((contact) =>
          (contact.displayName.toLowerCase().contains(value) ||
              contact.phones.first.value.toLowerCase().contains(value))));
    } else {
      filteredContacts.assignAll(contacts);
    }
  }

  void clearSearchField() {
    searchContacts.text = "";
    filteredContacts.assignAll(contacts);
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      contacts.assignAll(await FlutterContacts.getContacts());
      filteredContacts.assignAll(await FlutterContacts.getContacts());
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      globals.toast('Access to contact data denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      globals.toast('Contact data not available on device');
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
