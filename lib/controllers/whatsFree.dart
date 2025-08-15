import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsFreeController extends GetxController {
  var isLoader = true.obs;
  var cashbackHideWhatsFreeContent = true.obs;
  var instagarmHideWhatsFreeContent = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future launchCustomUrl(String url) async {
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : print('Could not launch $url');
  }

  void apicall() async {
    try {
      isLoader(true);
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    apicall();
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
