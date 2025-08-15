import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/services/subcategory.dart';
import 'package:frugivore/models/subcategory.dart';

class SubCategoryController extends GetxController {
  var isLoader = true.obs;
  static String? category, subcategory;
  String? selectedTab;
  String? qsp;
  List<GlobalKey?> key = [];
  int activeSubCategoryIndex = 0;

  var wait = false.obs;
  ScrollController horizontalScrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _detail = SubCategoryModel().obs;
  SubCategoryModel get detail => _detail.value;
  set detail(value) => _detail.value = value;

  final results = List<GlobalProductModel>.empty(growable: true).obs;

  void apicall(qsp, category, subcategory) async {
    qsp = qsp;
    SubCategoryController.category = category;
    SubCategoryController.subcategory = subcategory;
    try {
      isLoader(true);
      var response =
          await Services.fetchSubCategoryProducts(qsp, category, subcategory);
      if (response != null) {
        _detail.value = response;
        results.assignAll(response.results!);
        if (response.subCategories!.isNotEmpty) {
          selectedTab = response.subCategories![0];
        }
        key.length = response.subcategorylist!.length;
        for (int i = 0; i < response.subcategorylist!.length; i++) {
          if (i != 0 && response.subcategorylist![i].name == response.subCategories![0]) {
            activeSubCategoryIndex = i - 1;
          }
          key[i] = GlobalKey();
        }
        // Future.delayed(const Duration(seconds: 1), () async {
        //   RenderBox? box = key[activeSubCategoryIndex]!.currentContext!.findRenderObject() as RenderBox;
        //   Offset position = box.localToGlobal(Offset.zero); //this is global position
        //   double y = position.dx; //this is y - I think it's what you want
        //   if (horizontalScrollController.hasClients) {
        //     await horizontalScrollController.animateTo(
        //       y,
        //       curve: Curves.easeOut,
        //       duration: Duration(milliseconds: 500),
        //     );
        //   }
        // });
      }
    } finally {
      isLoader(false);
    }
  }

  void redirection() {
    if (detail.redirection != null) {
      Navigator.pushNamed(
          Get.context!, detail.redirection!.replaceAll(globals.webUri, '/'));
    }
  }

  @override
  void onInit() {
    SubCategoryController.category = Get.parameters['category']!;
    SubCategoryController.subcategory = Get.parameters['subcategory']!;
    qsp = "";
    apicall(qsp, category, subcategory);
    super.onInit();
  }

  void loadMore(dataObserver) async {
    try {
      var response = await Services.loadMore(dataObserver.next);
      if (response != null) {
        dataObserver.page = response.page;
        dataObserver.next = response.next;
        dataObserver.previous = response.previous;
        results.addAll(response.results!);
      }
    } finally {
      wait(false);
    }
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(qsp, category, subcategory);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (detail.page != detail.maxPage && !wait.value) {
      wait(true);
      loadMore(detail);
      refreshController.loadComplete();
    }
  }

}
