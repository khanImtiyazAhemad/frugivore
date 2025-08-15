import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/recipe/recipeDetail.dart';
import 'package:frugivore/services/recipe/recipeDetail.dart';

class RecipeDetailController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = RecipeDetailModel().obs;
  RecipeDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  Padding staticText(text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchRecipeDetail(uuid);
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
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
