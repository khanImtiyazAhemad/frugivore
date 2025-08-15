import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/staticPages/blogs.dart';
import 'package:frugivore/services/staticPages/blogs.dart';

class BlogsController extends GetxController {
  var isLoader = true.obs;
  String? name;
  var showLess = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = BlogsListModel().obs;
  BlogsListModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(name) async {
    try {
      isLoader(true);
      var response = await Services.fetchBlogs(name);
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    String? name = Get.parameters['name'];
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
}
