import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/shoppingList/myShoppingLists.dart';
import 'package:frugivore/controllers/shoppingList/myShoppingLists.dart';

import 'package:frugivore/connectivity.dart';

class MyShoppingListsPage extends StatelessWidget {
  const MyShoppingListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyShoppingListsController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(color: primaryColor),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                if (mode == LoadStatus.loading) {
                  return controller.wait.value
                      ? SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()))
                      : SizedBox();
                } else {
                  return SizedBox();
                }
              },
            ),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: NetworkSensitive(
                child: Container(
                    color: bodyColor,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: "Shopping Lists", search: false),
                                  Padding(
                                    padding: plr10,
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: customElevatedButton(
                                            pinkColor, whiteColor),
                                        onPressed: () => showDialog(
                                          context: Get.context!,
                                          builder: (_) =>
                                              NewShoppingListPopUp(),
                                          barrierDismissible: false,
                                        ),
                                        child: Text(
                                            "+ Create a new Shopping List"),
                                      ),
                                    ),
                                  ),
                                  Column(
                                                                      children:
                                    controller.results.map<Widget>((item) {
                                  return ShoppingListCard(item: item);
                                                                      }).toList(),
                                                                    ),
                                  SizedBox(height: 10),
                                  controller.wait.value
                                      ? CircularProgressIndicator()
                                      : Obx(() => Text(
                                          "Page ${controller.shoppinglist.page}/${controller.shoppinglist.maxPage}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600))),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class ShoppingListCard extends StatelessWidget {
  final Result item;
  const ShoppingListCard({super.key, required  this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyShoppingListsController());
    return Card(
        margin: p10,
        shape: roundedCircularRadius,
        child: Column(children: [
          Padding(
              padding: p10,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name!,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        if (item.description != null)
                          Column(children: [
                            Text(item.description!,style: TextStyle(fontSize: 12)),
                            SizedBox(height: 5)
                          ]),
                        Text("Total no of Items: ${item.totalItems}",style: TextStyle(fontSize: 12)),
                        SizedBox(height: 5),
                        Text("Created On: ${item.createdAt}",style: TextStyle(fontSize: 12)),
                      ]))),
          if (item.totalItems! > 0)
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: customElevatedButton(pinkColor, whiteColor)
                              .copyWith(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero))),
                          onPressed: () => Navigator.pushNamed(
                                  context, "/edit-shopping-list/${item.uuid}")
                              .then((value) => controller.apicall()),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: whiteColor),
                                SizedBox(width: 10),
                                Text("Edit Items")
                              ]),
                        ))),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: customElevatedButton(packageColor, whiteColor)
                              .copyWith(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero))),
                          onPressed: () => Navigator.pushNamed(
                                  context, "/shopping-list-detail/${item.uuid}")
                              .then((value) => controller.apicall()),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart, color: whiteColor),
                                SizedBox(width: 10),
                                Text("Shop from List")
                              ]),
                        )))
              ],
            ),
          if (item.totalItems! <= 0)
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor).copyWith(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  onPressed: () => Navigator.pushNamed(
                          context, "/edit-shopping-list/${item.uuid}")
                      .then((value) => controller.apicall()),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: whiteColor),
                        SizedBox(width: 10),
                        Text("Add Items")
                      ]),
                )),
          if (item.totalItems! > 0 && item.canSubscribe!)
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: customElevatedButton(skyBlueColor, whiteColor)
                      .copyWith(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero))),
                  onPressed: () => controller.subscribeList(item.uuid),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.subscriptions, color: whiteColor),
                        SizedBox(width: 10),
                        Text("Subscribe")
                      ]),
                ))
        ]));
  }
}

class NewShoppingListPopUp extends StatelessWidget {
  const NewShoppingListPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyShoppingListsController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text('Add Shopping List',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 14))),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              margin: ptb5,
              decoration: shapeDecoration,
              child: Padding(
                padding: p10,
                child: TextField(
                    controller: controller.name,
                    decoration: InputDecoration.collapsed(
                        hintText: "Name of your Shopping List")),
              )),
          SizedBox(height: 5),
          Container(
              margin: ptb5,
              decoration: shapeDecoration,
              child: Padding(
                padding: p10,
                child: TextField(
                    controller: controller.description,
                    maxLines: 3,
                    decoration: InputDecoration.collapsed(
                        hintText:
                            "Write your Shopping List Description (if any)")),
              )),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        style: customElevatedButton(pinkColor, whiteColor),
                        child: Text('SAVE'),
                        onPressed: () => controller.createShoppingList())),
              ),
              SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                        child: Text('CANCEL'),
                        onPressed: () => Navigator.of(context).pop())),
              ),
            ],
          )
        ]));
  }
}
