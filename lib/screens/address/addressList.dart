import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/controllers/address/addressList.dart';

import 'package:frugivore/connectivity.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressListController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
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
                                      title: "Select Address", search: false),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(children: [
                                        Card(
                                          color: whiteColor,
                                            margin: plr10,
                                            shape: roundedCircularRadius,
                                            child: Padding(
                                                padding: p10,
                                                child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child:
                                                                  GestureDetector(
                                                                      onTap: () =>
                                                                          Navigator.pushNamed(context, '/add-address').then(
                                                                              (_) {
                                                                            controller.apicall();
                                                                          }),
                                                                      child: Text(
                                                                          "+ Add New Address",
                                                                          style: TextStyle(
                                                                              color: primaryColor,
                                                                              decoration: TextDecoration.underline)))),
                                                          controller
                                                                      .addresslist
                                                                      .results
                                                                      !.isNotEmpty
                                                              ? Column(
                                                                  children: controller
                                                                      .addresslist
                                                                      .results
                                                                      !.map<Widget>(
                                                                          (item) {
                                                                  return AddressCard(
                                                                      item:
                                                                          item);
                                                                }).toList())
                                                              : Padding(
                                                                  padding:
                                                                      ptb20,
                                                                  child: Image
                                                                      .asset(
                                                                          'assets/images/blankAddress.gif'))
                                                        ]))))
                                      ])),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class AddressCard extends StatelessWidget {
  final Address item;
  const AddressCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressListController());
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Divider(color: darkGrey),
          Row(children: [
            Expanded(
                flex: 8,
                child: item.deliverHere!
                    ? Text("Currently Delivering Here",
                        style: TextStyle(
                            color: pinkColor, fontWeight: FontWeight.w600))
                    : Text("Address")),
            Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(Icons.edit, color: primaryColor),
                    onPressed: () => Navigator.pushNamed(
                            context, '/edit-address/${item.uuid}')
                        .then((value) => controller.apicall()))),
            Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.delete, color: primaryColor),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => DeleteAddress(item: item),
                    barrierDismissible: false,
                  ),
                ))
          ]),
          Text(item.name!),
          Text(item.address!),
          Text(item.area!),
          Text("${item.city}, ${item.pinCode}"),
          Text("Ph: ${item.phone}"),
          !item.deliverHere!
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: customElevatedButton(pinkColor, whiteColor),
                    onPressed: () =>
                        controller.makeDeliverHere(item.id.toString()),
                    child: Text("I want it delivered here"),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}

class DeleteAddress extends StatelessWidget {
  final Address item;
  const DeleteAddress({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressListController());
    return AlertDialog(
      backgroundColor: whiteColor,
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      title: Text('Delete Address', textAlign: TextAlign.center),
      content: Text(
        'Do you want to delete this Address Details?',
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style: customElevatedButton(pinkColor, whiteColor),
                child: Text('YES'),
                onPressed: () => controller.deleteAddress(item.uuid))),
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style: customElevatedButton(darkGrey, whiteColor),
                child: Text('NO'),
                onPressed: () => Navigator.of(context).pop())),
      ],
    );
  }
}
