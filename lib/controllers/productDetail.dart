import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frugivore/globals.dart' as globals;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/utils.dart';
import 'package:frugivore/widgets/custom.dart';

import 'package:frugivore/services/utils.dart';
import 'package:frugivore/services/productDetail.dart';

import 'package:frugivore/models/productDetail.dart';

class ProductDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();

  var isLoader = true.obs;
  var selectedTab = "".obs;
  late String link;
  var addButton = true.obs;
  TextEditingController quantity = TextEditingController();

  dynamic benefits, ingredients, facts, description = 'No Data Available';
  // List descriptionTabs = [
  //   'Description',
  //   'Benefits',
  //   'Ingredients',
  //   'Product Info'
  // ];
  List descriptionTabs = [];
  dynamic textForTab(var tabId) {
    switch (tabId) {
      case "Benefits":
        return benefits ?? 'No Data Available';
      case "Ingredients":
        return ingredients ?? 'No Data Available';
      case "Product Info":
        return facts ?? 'No Data Available';
      default:
        return description;
    }
  }

  late String slug;
  late TabController tabController;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final transformationController = TransformationController();
  late TapDownDetails doubleTapDetails;

  final _detail = ProductDetailModel().obs;
  ProductDetailModel get detail => _detail.value;
  set detail(value) => _detail.value = value;

  final _activePackage = ProductPackage().obs;
  ProductPackage get activePackage => _activePackage.value;
  set activePackage(value) => _activePackage.value = value;

  void apicall(slug) async {
    try {
      isLoader(true);
      var response = await Services.fetchProductDetail(slug);
      _detail.value = response;
      _activePackage.value =
          SelectDefaultProductPackage(items: response.product!.productPackage)
              .defaultPackage();
      quantity.text = activePackage.userQuantity.toString();
      if (activePackage.userQuantity! > 0) {
        addButton(false);
      }
      link = "https://frugivore.in/product-details/${response.product!.slug}";

      if (response.product!.description != "" &&
          response.product!.description != null) {
        description = response.product!.description!;
        if (descriptionTabs.isEmpty) descriptionTabs.add("Description");
      }
      if (response.product!.facts != "" && response.product!.facts != null) {
        facts = response.product!.facts;
        if (descriptionTabs.isEmpty) descriptionTabs.add("Product Info");
      }
      if (response.product!.benefits != "" &&
          response.product!.benefits != null) {
        benefits = response.product!.benefits;
        if (descriptionTabs.isEmpty) descriptionTabs.add("Benefits");
      }
      if (response.product!.ingredients != "" &&
          response.product!.ingredients != null) {
        ingredients = response.product!.ingredients;
        if (descriptionTabs.isEmpty) descriptionTabs.add("Ingredients");
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    String? slug = Get.parameters['slug'];
    selectedTab("Description");
    tabController = TabController(length: 2, vsync: this);
    apicall(slug);
    super.onInit();
  }

  void removeItem() async {
    String product = detail.product!.id.toString();
    String package = activePackage.id.toString();
    quantity.text = (int.parse(quantity.text) - 1).toString();
    activePackage.userQuantity = int.parse(quantity.text);
    if (int.parse(quantity.text) <= 0) {
      addButton(true);
    }


    var response =
        await UtilsServices.updateCart(product, package, quantity.text);
    if (response != null) {
      globals.toast(response['message'], color: primaryColor);
    }
  }

  void addItem() async {
    int addQuantity = int.parse(quantity.text) + 1;
    if (addQuantity > activePackage.maxQty!) {
      globals.toast("You can't add more than ${activePackage.maxQty} Quantity");
      return;
    }

    quantity.text = addQuantity.toString();
    String product = detail.product!.id.toString();
    String package = activePackage.id.toString();
    activePackage.userQuantity = int.parse(quantity.text);
    addButton(false);


    var response =
        await UtilsServices.updateCart(product, package, quantity.text);
    if (response != null) {
      globals.toast(response['message'], color: primaryColor);
    }
  }

  void handleDoubleTapDown(TapDownDetails details) {
    doubleTapDetails = details;
  }

  void handleDoubleTap() {
    if (transformationController.value != Matrix4.identity()) {
      transformationController.value = Matrix4.identity();
    } else {
      final position = doubleTapDetails.localPosition;
      // For a 3x zoom
      transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(slug);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(slug);
    refreshController.loadComplete();
  }
}
