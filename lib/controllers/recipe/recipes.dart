import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/recipe/recipes.dart';
import 'package:frugivore/services/recipe/recipes.dart';

class RecipesController extends GetxController {
  var isLoader = true.obs;
  String? name;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final data = List<RecipesModel>.empty(growable: true).obs;

  void apicall(name) async {
    try {
      isLoader(true);
      var response = await Services.fetchRecipes(name);
      if (response != null) {
        data.assignAll(response);
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    name = Get.parameters['name'];
    apicall(name);
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(name);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(name);
    refreshController.loadComplete();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }
}
