import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/controllers/filter.dart';
import 'package:frugivore/controllers/subcategory.dart';

// final void Function(String qsp, String category, String subcategory) callback;

class CustomFilterContainer extends StatelessWidget {
  final int? count;
  final String? text;
  final dynamic invoices;
  final dynamic categories;
  final dynamic subcategories;
  final dynamic brands;
  final dynamic callback;
  final List? arguments;

  CustomFilterContainer(
      {super.key, 
      this.count,
      this.text,
      this.invoices,
      this.categories,
      this.subcategories,
      this.brands,
      this.callback,
      this.arguments});

  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(flex: 6, child: Text("$count $text")),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: customElevatedButton(backgroundGrey, Colors.black),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(getIconFromCss('fat fa-sort'), color: Colors.black, size: 16),
                    SizedBox(width: 2),
                    Text("Sort", style: TextStyle(fontSize: 12))
                  ]),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => Get.currentRoute == "/my-order"
                    ? SortOrderContainer(
                        callback: callback, arguments: arguments)
                    : SortProductContainer(
                        callback: callback, arguments: arguments),
                barrierDismissible: false,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: customElevatedButton(backgroundGrey, Colors.black),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(getIconFromCss('fat fa-filter'), color: Colors.black, size: 16),
                    SizedBox(width: 2),
                    Text("Filter", style: TextStyle(fontSize: 12))
                  ]),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => Get.currentRoute == "/my-order"
                    ? FilterOrderContainer(
                        invoices: invoices,
                        count: count!,
                        callback: callback,
                        arguments: arguments)
                    : FilterProductContainer(
                        categories: categories,
                        subcategories: subcategories,
                        brands: brands,
                        count: count!,
                        callback: callback,
                        arguments: arguments),
                barrierDismissible: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SortOrderContainer extends StatelessWidget {
  final dynamic callback;
  final dynamic arguments;
  SortOrderContainer({super.key, this.callback, this.arguments});
  final FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
            width: MediaQuery.of(context).size.width,
            color: darkGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(Icons.arrow_back_ios_outlined,
                            color: whiteColor, size: 16),
                        onPressed: () => Navigator.of(context).pop())),
                Expanded(
                    flex: 5,
                    child: Text("Sort",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: whiteColor, fontSize: 18)))
              ],
            )),
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
                children: controller.sortOrder.map((item) {
              return GestureDetector(
                onTap: () => controller.defaultSortOrder(item['value']),
                child: Container(
                  decoration: boxDecorationBottomBorder,
                  child: Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            Text(item['text'], style: TextStyle(fontSize: 13)),
                        leading: Radio<String>(
                            activeColor: pinkColor,
                            value: item['value'],
                            groupValue: controller.defaultSortOrder.value,
                            onChanged: (value) =>
                                controller.defaultSortOrder(value.toString())),
                      )),
                ),
              );
            }).toList()),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor).copyWith(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  onPressed: () {
                    Get.close(1);
                    callback(controller.resultQsp());
                  },
                  child: Text("Apply"),
                ))
          ],
        ));
  }
}

class SortProductContainer extends StatelessWidget {
  final dynamic callback;
  final dynamic arguments;
  SortProductContainer({super.key, this.callback, this.arguments});
  final FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
            width: MediaQuery.of(context).size.width,
            color: darkGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: whiteColor,
                        size: 16,
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                Expanded(
                  child: Text("Sort",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: whiteColor, fontSize: 14)),
                )
              ],
            )),
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
                children: controller.sortProduct.map((item) {
              return GestureDetector(
                onTap: () => controller.defaultSortProduct(item['value']),
                child: Container(
                  decoration: boxDecorationBottomBorder,
                  child: Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            Text(item['text'], style: TextStyle(fontSize: 13)),
                        leading: Radio<String>(
                            activeColor: pinkColor,
                            value: item['value'],
                            groupValue: controller.defaultSortProduct.value,
                            onChanged: (value) =>
                                controller.defaultSortProduct(value.toString())),
                      )),
                ),
              );
            }).toList()),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor).copyWith(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  onPressed: () {
                    String currentRoute = Get.currentRoute;
                    Get.close(1);
                    String resultQsp = controller.resultProductQsp();
                    if (currentRoute.contains("/subcategory")) {
                      callback(resultQsp, arguments[0], arguments[1]);
                    } else if (currentRoute.contains("/search")) {
                      callback(resultQsp, arguments[0]);
                    } else {
                        callback(resultQsp);}
                  },
                  child: Text("Apply"),
                ))
          ],
        ));
  }
}

class FilterOrderContainer extends StatelessWidget {
  final dynamic invoices;
  final int? count;
  final dynamic arguments;

  final dynamic callback;
  const FilterOrderContainer(
      {super.key, this.invoices, this.count, this.arguments, this.callback});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());
    if (controller
            .filterOrder[controller.filterOrder.length - 1]['child'].length >
        0) {
      controller.filterOrder[controller.filterOrder.length - 1]['child'] = [];
    }
    for (String item in invoices) {
      controller.filterOrder[controller.filterOrder.length - 1]['child']
          .add({"text": item, "value": item});
    }

    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
            width: MediaQuery.of(context).size.width,
            color: darkGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(Icons.arrow_back_ios_outlined,
                          color: whiteColor, size: 16),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                Expanded(
                    flex: 5,
                    child: Text("Filter",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: whiteColor, fontSize: 18)))
              ],
            )),
        content: Obx(() => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: p10,
                        color: backgroundGrey,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("$count Orders",
                                    style: TextStyle(fontSize: 13))),
                            Expanded(
                                child: GestureDetector(
                              child: Text("CLEAR ALL",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: pinkColor, fontSize: 13)),
                              onTap: () {
                                controller.clearAllFilterQSP();
                                controller.fetchFilteredList();
                                Get.close(1);
                                callback(controller.resultQsp());
                              },
                            )),
                          ],
                        ),
                      ),
                      if (FilterController.selectedOrderFilters.isNotEmpty)
                        Container(
                          padding: p5,
                          child: Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: FilterController.selectedOrderFilters
                                  .map((item) {
                                return Container(
                                    padding: p5,
                                    margin: p2,
                                    decoration: semiCircleboxDecoration,
                                    child: Text(
                                        "${item['name']} : ${item['value']}",
                                        style: TextStyle(fontSize: 10)));
                              }).toList()),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Color(0xfff1f1f1),
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: controller.filterOrder.map((item) {
                                    return GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            right: 10,
                                            left: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration:
                                            boxDecorationBottomBorder.copyWith(
                                                color: controller
                                                            .filterOrderSelectedTab
                                                            .value ==
                                                        item['text']
                                                    ? primaryColor
                                                    : null),
                                        child: Text(item['text'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: controller
                                                            .filterOrderSelectedTab
                                                            .value ==
                                                        item['text']
                                                    ? whiteColor
                                                    : null)),
                                      ),
                                      onTap: () {
                                        controller.filterOrderSelectedTab(
                                            item['text']);
                                        controller.filterOrderSelectedTabChild =
                                            item['child'];
                                      },
                                    );
                                  }).toList()),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: controller
                                          .filterOrderSelectedTabChild
                                          .map((item) {
                                        return item['type'] == "radio"
                                            ? GestureDetector(
                                                onTap: () {
                                                  item['groupValue'](
                                                      item['value']);
                                                  controller
                                                      .fetchFilteredList();
                                                },
                                                child: Container(
                                                    decoration:
                                                        boxDecorationBottomBorder,
                                                    child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                            item['text'],
                                                            style: TextStyle(
                                                                fontSize: 13)),
                                                        leading: Radio<String>(
                                                            activeColor:
                                                                pinkColor,
                                                            value:
                                                                item['value'],
                                                            groupValue: item[
                                                                    'groupValue']
                                                                .value,
                                                            onChanged: (value) {
                                                              item['groupValue'](
                                                                  item[
                                                                      'value']);
                                                              controller
                                                                  .fetchFilteredList();
                                                            }))),
                                              )
                                            : GestureDetector(
                                                onTap: () =>
                                                    controller.changeInvoices(
                                                        item['value']),
                                                child: Container(
                                                  decoration:
                                                      boxDecorationBottomBorder,
                                                  padding: p15,
                                                  child: Row(children: [
                                                    SizedBox(
                                                        height: 24.0,
                                                        width: 24.0,
                                                        child: Checkbox(
                                                            checkColor:
                                                                whiteColor,
                                                            activeColor:
                                                                pinkColor,
                                                            value: FilterController
                                                                    .defaultfilterInvoices
                                                                    .contains(item[
                                                                        'value'])
                                                                ? true
                                                                : false,
                                                            onChanged: (val) =>
                                                                controller
                                                                    .changeInvoices(
                                                                        item[
                                                                            'value']))),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                            item['text'],
                                                            style: TextStyle(
                                                                fontSize: 13)))
                                                  ]),
                                                ),
                                              );
                                      }).toList())),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        style: customElevatedButton(pinkColor, whiteColor)
                            .copyWith(
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                        onPressed: () {
                          Get.close(1);
                          callback(controller.resultQsp());
                        },
                        child: Text("Apply"),
                      ))
                ],
              ),
            )));
  }
}

class FilterProductContainer extends StatelessWidget {
  final dynamic categories;
  final dynamic subcategories;
  final dynamic brands;
  final int? count;
  final dynamic callback;
  final dynamic arguments;

  const FilterProductContainer(
      {super.key, this.categories,
      this.subcategories,
      this.brands,
      this.count,
      this.callback,
      this.arguments});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());
    if (controller.filterProduct[0]['child']!.isNotEmpty) {
      controller.filterProduct[0]['child'] = [];
    }
    for (String item in categories) {
      controller.filterProduct[0]['child'].add({
        "text": item,
        "value": item,
        "listObserver": FilterController.defaultCategories,
        "callback": FilterController.changeCategories
      });
    }
    if (controller.filterProduct[1]['child']!.isNotEmpty) {
      controller.filterProduct[1]['child'] = [];
    }
    for (String item in subcategories) {
      controller.filterProduct[1]['child'].add({
        "text": item,
        "value": item,
        "listObserver": FilterController.defaultSubCategories,
        "callback": FilterController.changeSubCategories
      });
    }
    if (controller.filterProduct[2]['child']!.isNotEmpty) {
      controller.filterProduct[2]['child'] = [];
    }
    for (String item in brands) {
      controller.filterProduct[2]['child'].add({
        "text": item,
        "value": item,
        "listObserver": FilterController.defaultBrands,
        "callback": FilterController.changeBrands
      });
    }
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
            width: MediaQuery.of(context).size.width,
            color: darkGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(Icons.arrow_back_ios_outlined,
                          color: whiteColor, size: 16),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                Expanded(
                  child: Text("Filter",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: whiteColor, fontSize: 14)),
                )
              ],
            )),
        content: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      padding: p10,
                      color: backgroundGrey,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("$count Products",
                                  style: TextStyle(fontSize: 13))),
                          Expanded(
                              child: GestureDetector(
                            child: Text("CLEAR ALL",
                                textAlign: TextAlign.end,
                                style:
                                    TextStyle(color: pinkColor, fontSize: 13)),
                            onTap: () {
                              String currentRoute = Get.currentRoute;
                              controller.clearAllProductFilterQSP();
                              controller.fetchProductFilteredList();
                              Get.close(1);
                              if (currentRoute.contains("/subcategory")) {
                                callback(
                                    controller.resultProductQsp(),
                                    SubCategoryController.category,
                                    SubCategoryController.subcategory);
                              } else if (currentRoute.contains("/search")) {
                                callback(controller.resultProductQsp(),
                                    arguments[0]);
                              } else
                                {callback(controller.resultProductQsp());}
                            },
                          )),
                        ],
                      ),
                    ),
                    if (FilterController.selectedFilters.isNotEmpty)
                      Container(
                        padding: p5,
                        child: Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            children:
                                FilterController.selectedFilters.map((item) {
                              return Container(
                                  padding: p5,
                                  margin: p2,
                                  decoration: semiCircleboxDecoration,
                                  child: Text(
                                      "${item['name']} : ${item['value']}",
                                      style: TextStyle(fontSize: 10)));
                            }).toList()),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            color: Color(0xfff1f1f1),
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.filterProduct.map((item) {
                                  return GestureDetector(
                                    child: Container(
                                      padding: p15,
                                      width: MediaQuery.of(context).size.width,
                                      decoration:
                                          boxDecorationBottomBorder.copyWith(
                                              color: controller
                                                          .filterProductSelectedTab
                                                          .value ==
                                                      item['text']
                                                  ? primaryColor
                                                  : null),
                                      child: Text(item['text'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: controller
                                                          .filterProductSelectedTab
                                                          .value ==
                                                      item['text']
                                                  ? whiteColor
                                                  : null)),
                                    ),
                                    onTap: () {
                                      controller.filterProductSelectedTab(
                                          item['text']);
                                      controller.filterProductSelectedTabChild =
                                          item['child'];
                                    },
                                  );
                                }).toList()),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    children: controller
                                        .filterProductSelectedTabChild
                                        .map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      item['callback'](item['value']);
                                      controller.fetchProductFilteredList();
                                    },
                                    child: Container(
                                      decoration: boxDecorationBottomBorder,
                                      padding: p15,
                                      child: Row(children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Checkbox(
                                                checkColor: whiteColor,
                                                activeColor: pinkColor,
                                                value: item['listObserver']
                                                        .contains(item['value'])
                                                    ? true
                                                    : false,
                                                onChanged: (val) {
                                                  item['callback'](
                                                      item['value']);
                                                  controller
                                                      .fetchProductFilteredList();
                                                })),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(item['text'],
                                                style: TextStyle(fontSize: 13)))
                                      ]),
                                    ),
                                  );
                                }).toList())),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: customElevatedButton(pinkColor, whiteColor)
                          .copyWith(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero))),
                      onPressed: () {
                        String currentRoute = Get.currentRoute;
                        Get.close(1);
                        if (currentRoute.contains("/subcategory")) {
                          callback(
                              controller.resultProductQsp(),
                              SubCategoryController.category,
                              SubCategoryController.subcategory);
                        } else if (currentRoute.contains("/search")) {
                          callback(controller.resultProductQsp(), arguments[0]);
                        } else
                          {callback(controller.resultProductQsp());}
                      },
                      child: Text("Apply"),
                    ))
              ],
            ))));
  }
}
