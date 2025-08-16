import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/utils.dart';

import 'package:frugivore/notification.dart';

import 'package:frugivore/models/home.dart';
import 'package:frugivore/services/home.dart';
import 'package:frugivore/services/utils.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage();
  var loggedUser = false.obs;
  var rating = 0.obs;
  var deliveryBoyRating = 0.obs;
  var recentOrderFeedbackCheck = false.obs;
  static var lastUndeliveredOrderCheck = false.obs;

  var isLoader = true.obs;
  var showAllCategories = false.obs;
  var showAllSubCategories = false.obs;
  var categoryStaticLength = 9;
  var subCategoryStaticLength = 9;
  int bannersLength = 0;
  int tilesLength = 0;
  int activeOrdersLength = 0;
  // var timerQueue = Queue<Duration>();

  ScrollController scrollController = ScrollController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController comment = TextEditingController();

  final banners = List<BannersModel>.empty(growable: true).obs;

  final _homePage = HomePageModel().obs;
  HomePageModel get homepage => _homePage.value;
  set homepage(value) => _homePage.value = value;

  static final _lastUndeliveredOrder = UndeliveredOrderModel().obs;
  UndeliveredOrderModel get lastUndeliveredOrder => HomeController._lastUndeliveredOrder.value;
  set lastUndeliveredOrder(value) =>
      HomeController._lastUndeliveredOrder.value = value;

  final tiles = List<MarketingTilesModel>.empty(growable: true).obs;

   final activeOrders = List<ActiveOrdersModel>.empty(growable: true).obs;

  final categories = List<CategoryList>.empty(growable: true).obs;
  final subCategories = List<SubCategoriesModel>.empty(growable: true).obs;

  final testimonials = List<TestimonialsModel>.empty(growable: true).obs;
  final blogs = List<BlogsModel>.empty(growable: true).obs;
  final purchaseHistoryOrders =
      List<PurchaseHistoryModel>.empty(growable: true).obs;
  final seasonBest = List<SeasonBestModel>.empty(growable: true).obs;
  final mySection = List<MySectionModel>.empty(growable: true).obs;

  final _recentOrderData = RecentOrderFeedbackModel().obs;
  RecentOrderFeedbackModel get recentOrderData => _recentOrderData.value;
  set recentOrderData(value) => _recentOrderData.value = value;

  final _earliestDeliverySlot = EarliestDeliverySlotModel().obs;
  EarliestDeliverySlotModel get earliestDeliverySlot => _earliestDeliverySlot.value;
  set earliestDeliverySlot(value) => _earliestDeliverySlot.value = value;

  void bannersApi() async {
    var response = await Services.fetchBanners();
    if (response != null) {
      bannersLength = response.length;
      banners.assignAll(response);
    }
  }

  void tilesApi() async {
    var response = await Services.fetchMarketingTiles();
    if (response != null) {
      tilesLength = response.length;
      tiles.assignAll(response);
    }
  }

  void activeOrdersApi() async {
    var response = await Services.activeOrders();
    if (response != null) {
      activeOrdersLength = response.length;
      activeOrders.assignAll(response);
    }
  }

  void homePageApi() async {
    var response = await Services.fetchHomePage();
    if (response != null) {
      _homePage.value = response;
    }
  }

  void categoriesApi() async {
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
      categories.addAll(response.categories!);
    }
  }

  void subCategoriesApi() async {
    var response = await Services.fetchSubCategories();
    if (response != null) {
      subCategories.assignAll(response);
    }
  }

  void testimonialsApi() async {
    var response = await Services.fetchTestimonials();
    if (response != null) {
      testimonials.assignAll(response);
    }
  }

  void blogsApi() async {
    var response = await Services.fetchBlogs();
    if (response != null) {
      blogs.assignAll(response);
    }
  }

  void seasonBestApi() async {
    var response = await Services.fetchSeasonBestItems();
    if (response != null) {
      seasonBest.assignAll(response);
    }
  }

  void mySectionApi() async {
    var response = await Services.fetchMySectionItems();
    if (response != null) {
      mySection.assignAll(response);
    }
  }

  void recentOrderFeedbackApi() async {
    var response = await Services.fetchRecentOrderFeedback();
    if (response != null) {
      _recentOrderData.value = response;
      if (response.lastOrderUuid != false) recentOrderFeedbackCheck(true);
    }
  }

  static Future<void> lastUndeiveredOrderApi() async {
    var response = await Services.fetchlastUndeliverdOrder();
    if (response != null && response.exist!) {
      HomeController._lastUndeliveredOrder.value = response;
      HomeController.lastUndeliveredOrderCheck(true);
    }
  }

  void footerContentApi() async {
    var footerContent = await UtilsServices.footerContent();
    if (footerContent != null) {
      globals.payload['cart'] = footerContent['count'].toString();
      globals.payload['final_cart_amount'] = footerContent['total'].toString();
      globals.payload['total_discounted_price'] =
          footerContent['saved'].toString();
      globals.payload['cart_message'] =
          footerContent['cart_message'].toString();
      globals.payload.refresh();
    }
  }

  void earliestDeliverySlotApi() async {
    var response = await Services.fetchEarliestDeliverySlot();
    if (response != null) {
      loggedUser(true);
      _earliestDeliverySlot.value = response;
    }
  }

  void apicall() async {
    try {
      isLoader(true);
      homePageApi();
      bannersApi();
      tilesApi();
      categoriesApi();
      subCategoriesApi();
      testimonialsApi();
      blogsApi();
      recentOrderFeedbackApi();
      activeOrdersApi();
      if (box.hasData('token')) {
        var offerContent = await UtilsServices.offerContent();
        if (offerContent != null) {
          globals.payload['sticky_offer_content'] =
              offerContent['content'].toString();
          globals.payload.refresh();
        }
        lastUndeiveredOrderApi();
        earliestDeliverySlotApi();
        var response = await Services.fetchPurchaseHistory();
        if (response != null) {
          purchaseHistoryOrders.assignAll(response);
        }
      }
      seasonBestApi();
      mySectionApi();
    } finally {
      isLoader(false);
      PushNotificationsManager().listeners();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    apicall();

    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((info) {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate();
        }
      }).catchError((e) {
      });
    }
    // scrollController.addListener(() {
    //   print("Testing---- ${scrollController.position.pixels}");
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent - 50) {
    //     print("testing");
    //   }
    // });
  }

  void rateUsOrder() {
    if (rating.value <= 0) {
      globals.toast("Order Rating is mandatory");
    } else if (deliveryBoyRating.value <= 0) {
      globals.toast("Delivery Boy Rating is mandatory");
    } else {
      Map data = {
        "rating": rating.value.toString(),
        "delivery_rating": deliveryBoyRating.value.toString(),
        "comment": comment.text
      };
      Services.rateusOrder(recentOrderData.lastOrderUuid, data)
          .then((response) {
        globals.toast(response['message'], color: primaryColor);
        recentOrderFeedbackCheck(false);
      }).catchError((onError) {});
    }
  }

  Future launchCustomUrl(url) async {
    await canLaunchUrl(Uri.parse(url))
        ? await launchUrl(Uri.parse(url))
        : print('Could not launch $url');
  }

  void categoriesList() {
    if (showAllCategories.value) {
      categoryStaticLength = 9;
      showAllCategories(false);
    } else {
      categoryStaticLength = categories.length + 1;
      showAllCategories(true);
    }
  }

  void subCategoriesList() {
    if (showAllSubCategories.value) {
      subCategoryStaticLength = 9;
      showAllSubCategories(false);
    } else {
      subCategoryStaticLength = subCategories.length + 1;
      showAllSubCategories(true);
    }
  }

  void repeatOrder(uuid) {
    isLoader(true);
    UtilsServices.repeatOrder(uuid).then((response) async {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        CartRouting().routing();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void convertToShoppingList(uuid) {
    isLoader(true);
    UtilsServices.convertToShoppingList(uuid).then((response) async {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        Navigator.pushNamed(
            Get.context!, '/edit-shopping-list/${response['uuid']}');
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void blogsRouting(title) {
    title = Uri.parse(title);
    Navigator.pushNamed(Get.context!, "/blogs/$title");
  }

  void flashRemoveCartItem(product, package, quantity) async {
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, "/login");
    } else {
      quantity.text = (int.parse(quantity.text) - 1).toString();


      var response = await UtilsServices.updateCart(
          product, package.id.toString(), quantity.text,
          flashSale: true);
      if (response != null) {
        quantity.text = response['quantity'].toString();
        globals.toast(response['message'], color: primaryColor);
      }
    }
  }

  void flashAddCartItem(product, package, quantity) async {
    if (!box.hasData('token')) {
      Navigator.pushNamed(Get.context!, "/login");
    } else {
      int addQuantity = int.parse(quantity.text) + 1;
      if (addQuantity > package.maxQty) {
        globals.toast("You can't add more than ${package.maxQty} Quantity");
        return;
      }
      quantity.text = addQuantity.toString();



      var response = await UtilsServices.updateCart(
          product, package.id.toString(), quantity.text,
          flashSale: true);
      if (response != null) {
        quantity.text = response['quantity'].toString();
        globals.toast(response['message'], color: primaryColor);
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


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
