import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/shoppingList/editShoppingListDetail.dart';
import 'package:frugivore/controllers/shoppingList/editShoppingListDetail.dart';

import 'package:frugivore/connectivity.dart';

class EditShoppingListDetailPage extends StatelessWidget {
  const EditShoppingListDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditShoppingListDetailController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: Obx(() => controller.isLoader.value
            ? SizedBox(height: 0)
            : CustomBottomBarButton()),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(color: primaryColor),
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
                                      title: "Edit Shopping List",
                                      search: false),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          margin: plr10,
                                          shape: shapeRoundedRectangleBorderBLR,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffB3B6B7),
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: whiteColor,
                                                            width: 1))),
                                                padding: p10,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(children: [
                                                        Expanded(
                                                          flex: 9,
                                                          child: Text(
                                                              "Name: ${controller.data.name}",
                                                              style: TextStyle(
                                                                  color:
                                                                      whiteColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: IconButton(
                                                              icon: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                      whiteColor),
                                                              onPressed: () =>
                                                                  showDialog(
                                                                    context: Get
                                                                        .context!,
                                                                    builder: (_) =>
                                                                        UpdateShoppingListPopUp(),
                                                                    barrierDismissible:
                                                                        false,
                                                                  )),
                                                        )
                                                      ]),
                                                      if (controller.data
                                                              .description !=
                                                          null)
                                                        Text(
                                                            "Description: ${controller.data.description}",
                                                            style: TextStyle(
                                                              color: whiteColor,
                                                            )),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          "Total no of Items: ${controller.data.totalItems}",
                                                          style: TextStyle(
                                                              color:
                                                                  whiteColor))
                                                    ]),
                                              ),
                                              Container(
                                                height: 50,
                                                color: Color(0xff5b5959),
                                                padding: p5,
                                                child: Container(
                                                    decoration: ShapeDecoration(
                                                      color: whiteColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid,
                                                            color: borderColor),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                      ),
                                                    ),
                                                    child:
                                                        AutoCompleteContainer()),
                                              ),
                                              Column(
                                                  children: controller
                                                      .data.shoppingListItems
                                                      !.map<Widget>((item) {
                                                return ShoppingListItemsContainer(
                                                    item: item);
                                              }).toList()),
                                            ],
                                          ))),
                                  SizedBox(height: 60)
                                ]));
                    })))));
  }
}

class ShoppingListItemsContainer extends StatelessWidget {
  final ShoppingListItem item;
  const ShoppingListItemsContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditShoppingListDetailController());
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: backgroundGrey,
        padding: p10,
        child: Text(item.name!),
      ),
      Padding(
          padding: ptlr10,
          child: Column(
            children: item.items!.map((item) {
              final quantity = TextEditingController(text: "${item.quantity}");
              return Container(
                padding: ptb5,
                decoration: boxDecorationBottomBorder,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CachedNetworkImage(
                        imageUrl: item.image!,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${item.brand} - ${item.name}"),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3, child: Text("${item.package} X")),
                              SizedBox(width: 5),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      height: 35,
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                                child: Container(
                                                    padding: ptb10,
                                                    decoration: cartLeftButton,
                                                    child: Icon(Icons.remove,
                                                        color: whiteColor,
                                                        size: 16)),
                                                onTap: () => controller
                                                    .updateShoppingListItem(
                                                        item.productId,
                                                        item.packageId,
                                                        quantity,
                                                        "REMOVE")),
                                          ),
                                          Expanded(
                                              child: Container(
                                            padding: ptb10,
                                            color: pinkColor,
                                            child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    color: whiteColor),
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                controller: quantity,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: "1",
                                                )),
                                          )),
                                          Expanded(
                                            child: GestureDetector(
                                                child: Container(
                                                    padding: ptb10,
                                                    decoration: cartRightButton,
                                                    child: Icon(Icons.add,
                                                        color: whiteColor,
                                                        size: 16)),
                                                onTap: () => controller
                                                    .updateShoppingListItem(
                                                        item.productId,
                                                        item.packageId,
                                                        quantity,
                                                        "ADD")),
                                          ),
                                        ],
                                      ))),
                              Expanded(
                                  flex: 4,
                                  child: IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(Icons.delete,
                                          color: backgroundGrey),
                                      onPressed: () =>
                                          controller.deleteItem(item.uuid)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ))
    ]);
  }
}

class CustomBottomBarButton extends StatelessWidget {
  const CustomBottomBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditShoppingListDetailController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 40,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor).copyWith(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero))),
                  child: Text("Update & Save List"),
                  onPressed: () => Navigator.pushNamed(
                          context, "/shopping-list-detail/${controller.uuid}")
                      .then((value) => controller.apicall(controller.uuid))),
            )),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: customElevatedButton(packageColor, whiteColor)
                        .copyWith(
                            shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 5),
                        Text("Add to Cart")
                      ],
                    ),
                    onPressed: () => controller.addToCart(),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

class UpdateShoppingListPopUp extends StatelessWidget {
  const UpdateShoppingListPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditShoppingListDetailController());
    return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(10),
        title: Container(
            padding: p10,
            color: pinkColor,
            child: Text('Update Shopping List',
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
                        child: Text('UPDATE'),
                        onPressed: () => controller.updateShoppingList())),
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

class AutoCompleteContainer extends StatefulWidget {
  const AutoCompleteContainer({super.key});

  @override
  AutoCompleteContainerState createState() => AutoCompleteContainerState();
}

class AutoCompleteContainerState extends State<AutoCompleteContainer> {
  final controller = Get.put(EditShoppingListDetailController());
  GlobalKey<AutoCompleteTextFieldState<ShoppingListAutocompleteModel>> key =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AutoCompleteTextField<ShoppingListAutocompleteModel>(
      key: key,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black),
          suffixIcon: IconButton(
              icon: Icon(Icons.cancel, color: Colors.black),
              onPressed: () => controller.clearSearchField()),
          hintText: "Add Items by Searching Here..."),
      controller: controller.searchField,
      suggestions: controller.suggestions,
      suggestionsAmount: 5,
      minLength: 3,
      textChanged: (text) => controller.changeType(text),
      itemSubmitted: (text) => {}, // We can ignore this
      itemBuilder: (context, suggestion) =>
          SuggestionItems(suggestion: suggestion),
      itemSorter: (a, b) => -1,
      itemFilter: (suggestion, input) =>
          suggestion.name!.toLowerCase().contains(input.toLowerCase()),
    );
  }
}

class SuggestionItems extends StatelessWidget {
  final ShoppingListAutocompleteModel suggestion;
  const SuggestionItems({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditShoppingListDetailController());
    final quantityController = TextEditingController(
        text: suggestion.package!.userQuantity.toString());
    return Container(
        padding: p5,
        decoration: boxDecorationBottomBorder,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(
                flex: 2,
                child:
                    CachedNetworkImage(imageUrl: suggestion.package!.imgOne!)),
            SizedBox(width: 20),
            Expanded(
                flex: 7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${suggestion.brand} - ${suggestion.name}",
                          style: TextStyle(fontSize: 12)),
                      Text("${suggestion.package!.name}",
                          style: TextStyle(fontSize: 12))
                    ])),
            suggestion.isPromotional!
                ? Expanded(
                    flex: 3,
                    child: Container(
                        height: 40,
                        decoration: boxDecoration,
                        alignment: Alignment.center,
                        child: Text("NOT FOR SALE",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: pinkColor))))
                : suggestion.deliveryType == "PRE ORDER"
                    ? suggestion.package!.userQuantity! > 0
                        ? Expanded(
                            flex: 3,
                            child: Container(
                                height: 40,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                padding: ptb10,
                                                decoration: preOrderLeftButton,
                                                child: Icon(Icons.remove,
                                                    color: whiteColor,
                                                    size: 18)),
                                            onTap: () {
                                              controller.updateShoppingListItem(
                                                  suggestion.id,
                                                  suggestion.package!.id,
                                                  quantityController,
                                                  "MINUS");
                                            })),
                                    Expanded(
                                        child: Container(
                                            padding: ptb10,
                                            color: packageColor,
                                            child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    color: whiteColor),
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                controller: quantityController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: "1",
                                                )))),
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                padding: ptb10,
                                                decoration: preOrderRightButton,
                                                child: Icon(Icons.add,
                                                    color: whiteColor,
                                                    size: 18)),
                                            onTap: () {
                                              controller.updateShoppingListItem(
                                                  suggestion.id,
                                                  suggestion.package!.id,
                                                  quantityController,
                                                  "ADD");
                                            }))
                                  ],
                                )))
                        : Expanded(
                            flex: 3,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    style: customElevatedButton(
                                        packageColor, whiteColor),
                                    child: Text("PRE ORDER",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white)),
                                    onPressed: () {
                                      controller.updateShoppingListItem(
                                          suggestion.id,
                                          suggestion.package!.id,
                                          quantityController,
                                          "ADD");
                                    })))
                    : suggestion.package!.userQuantity! > 0
                        ? Expanded(
                            flex: 3,
                            child: Container(
                                height: 40,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                padding: ptb10,
                                                decoration: cartLeftButton,
                                                child: Icon(Icons.remove,
                                                    color: whiteColor,
                                                    size: 18)),
                                            onTap: () {
                                              controller.updateShoppingListItem(
                                                  suggestion.id,
                                                  suggestion.package!.id,
                                                  quantityController,
                                                  "MINUS");
                                            })),
                                    Expanded(
                                        child: Container(
                                            padding: ptb10,
                                            color: pinkColor,
                                            child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    color: whiteColor),
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                controller: quantityController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: "1",
                                                )))),
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                padding: ptb10,
                                                decoration: cartRightButton,
                                                child: Icon(Icons.add,
                                                    color: whiteColor,
                                                    size: 18)),
                                            onTap: () {
                                              controller.updateShoppingListItem(
                                                  suggestion.id,
                                                  suggestion.package!.id,
                                                  quantityController,
                                                  "ADD");
                                            }))
                                  ],
                                )))
                        : Expanded(
                            flex: 3,
                            child: ElevatedButton(
                                style:
                                    customElevatedButton(pinkColor, whiteColor),
                                child: Text("ADD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                onPressed: () {
                                  controller.updateShoppingListItem(
                                      suggestion.id,
                                      suggestion.package!.id,
                                      quantityController,
                                      "ADD");
                                }))
          ]),
        ));
  }
}
