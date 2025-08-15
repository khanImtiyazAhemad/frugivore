import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/models/home.dart';

class CategoriesController extends GetxController {
  var isLoader = true.obs;

  var clickedCategories = "".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final categories = List<CategoryList>.empty(growable: true).obs;

  void apicall() async {
    try {
      isLoader(true);
      var response = await UtilsServices.fetchCategories();
      if (response != null && categories.isEmpty) {
        if (response.frugivoreOriginals != null) {
          categories.add(CategoryList(
            id: 0,
            subcategorySlug: "frugivore-originals",
            image:
                "https://frugivore-bucket.s3.amazonaws.com/static/images/frugivore-originals.png",
            icon:
                "https://frugivore-bucket.s3.amazonaws.com/static/images/frugivore-originals.png",
            banner: "",
            name: "Frugivore Originals",
            slug: "frugivore-originals",
            redirectionUrl: null,
            isActive: true,
          ));
        }
        if (categories.length < 2) categories.addAll(response.categories!);
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
