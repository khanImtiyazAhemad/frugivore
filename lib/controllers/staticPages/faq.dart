import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/models/staticPages/faq.dart';
import 'package:frugivore/services/staticPages/faq.dart';

class FAQController extends GetxController {
  var isLoader = true.obs;
  var clickedQuestion = "".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _faq = FaqModel().obs;
  FaqModel get faq => _faq.value;
  set faq(value) => _faq.value = value;

  void apicall() async {
    try {
      isLoader(true);
      var response = await Services.fetchFaq();
      if (response != null) {
        _faq.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
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
