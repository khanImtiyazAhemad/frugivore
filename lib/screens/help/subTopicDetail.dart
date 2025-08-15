import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/screens/utils.dart';

import 'package:frugivore/models/help/subTopicDetail.dart';
import 'package:frugivore/controllers/help/sub_topic_detail.dart';

import 'package:frugivore/connectivity.dart';

class HelpSubTopicDetailPage extends StatelessWidget {
  const HelpSubTopicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: Obx(
          () => controller.isLoader.value
              ? Loader()
              : Stack(alignment: Alignment.bottomCenter, children: [
                  SmartRefresher(
                    enablePullDown: true,
                    header: WaterDropMaterialHeader(color: primaryColor),
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    child: NetworkSensitive(
                        child: Container(
                            color: bodyColor,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: controller.isLoader.value
                                    ? Loader()
                                    : Column(children: [
                                        CustomTitleBar(
                                            title: "Customer Service",
                                            search: false),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                                margin: plr10,
                                                shape: roundedCircularRadius,
                                                child: Padding(
                                                    padding: p10,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller.subSubTopic
                                                                  .value
                                                              ? controller.data
                                                                  .subSubTopic ?? ""
                                                              : controller.data
                                                                  .subTopic ?? "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Html(
                                                            data: controller
                                                                .data.content),
                                                        if (controller
                                                            .data.buttonSupport!)
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                                padding: plr10,
                                                                width: MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    .6,
                                                                child: ElevatedButton(
                                                                    style: customNonSlimmerElevatedButton(
                                                                        skyBlueColor,
                                                                        whiteColor),
                                                                    onPressed: () => Navigator.pushNamed(
                                                                        context,
                                                                        controller
                                                                            .data
                                                                            .buttonRedirection ?? ""),
                                                                    child: Text(
                                                                        controller
                                                                            .data
                                                                            .buttonText ?? ""))),
                                                          ),
                                                      ],
                                                    )))),
                                        if (controller.orderId != null &&
                                            controller.data.orderDetail!)
                                          OrderDetail(),
                                        if (controller.data.itemsSupport! &&
                                            controller.itemsContainer.value)
                                          QualityIssues()
                                        else if (controller.data.commentSupport!)
                                          CommentSupport(),
                                        ComplaintsHistorySection(ongoing:controller.ongoing!, past:controller.past!),
                                        SizedBox(height: 160)
                                      ])))),
                  ),
                  if (controller.data.callSupport! ||
                      controller.data.chatSupport!)
                    BottomButton()
                ]),
        ));
  }
}

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
            margin: ptlr10,
            shape: roundedCircularRadius,
            child: Container(
                padding: p10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Order Status:")),
                            Expanded(
                                child: Text(
                                    controller.orderDataResponse.orderStatus ?? "",
                                    textAlign: TextAlign.end)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Delivery Boy Name:")),
                            Expanded(
                                child: Text(
                                    controller.orderDataResponse.deliveryBoy ?? "",
                                    textAlign: TextAlign.end)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Delivery Boy Contact:")),
                            Expanded(
                                child: Text(
                                    controller.orderDataResponse.deliveryPhone ?? "",
                                    textAlign: TextAlign.end)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Delivery Date:")),
                            Expanded(
                                child: Text(
                                    controller.orderDataResponse.deliveryDate ?? "",
                                    textAlign: TextAlign.end)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Delivery Slot:")),
                            Expanded(
                                child: Text(
                                    controller.orderDataResponse.deliverySlot ?? "",
                                    textAlign: TextAlign.end)),
                          ]),
                    ]))));
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return Padding(
      padding: p10,
      child: Row(
        children: [
          if (controller.data.callSupport!)
            Expanded(
                child: ElevatedButton(
              style: customNonSlimmerElevatedButton(whiteColor, Colors.black),
              onPressed: () => launchUrl(Uri.parse("tel:8448448994")),
              child: Text("Call Us"),
            )),
          SizedBox(width: 10),
          if (controller.data.chatSupport!)
            Expanded(
                child: ElevatedButton(
                    style:
                        customNonSlimmerElevatedButton(pinkColor, whiteColor),
                    onPressed: () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'care@frugivore.in',
                        query:
                            'subject=${controller.subSubTopic.value ? controller.data.subSubTopic : controller.data.subTopic}', //add subject and body here
                      );
                      var url = params.toString();
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        globals.toast(
                            "No email client available to send email, you can write to us at care@frugivore.in");
                      }
                    },
                    child: Text("Email Us"))),
        ],
      ),
    );
  }
}

class QualityIssues extends StatefulWidget {
  const QualityIssues({super.key});

  @override
  QualityIssuesState createState() => QualityIssuesState();
}

class QualityIssuesState extends State<QualityIssues> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: p10,
        shape: roundedCircularRadius,
        child: Container(
            padding: p10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please select Items"),
                SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        controller.selectedItem = x;
                        controller.calculatePrice();
                      });
                    },
                    options: controller.orderItemsListing,
                    selectedValues: controller.selectedItem,
                    whenEmpty: 'Select Items',
                  ),
                ),
                SizedBox(height: 5),
                if (controller.selectedItem.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.data.commentSupport!)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Comment:"),
                            SizedBox(height: 5),
                            Container(
                                padding: p10,
                                decoration: shapeDecoration,
                                child: TextField(
                                    maxLines: 3,
                                    controller: controller.comment,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Comment"))),
                            SizedBox(height: 5),
                          ],
                        ),
                      Text("Attach Live Images"),
                      Row(
                          children:
                              controller.images.asMap().entries.map((item) {
                        if (item.value is ImageUploadModel) {
                          ImageUploadModel? uploadModel =
                              controller.images[item.key] as ImageUploadModel?;
                          return Expanded(
                              child: Container(
                            padding: p10,
                            child: Stack(
                              children: [
                                Image.file(uploadModel!.imageFile!),
                                Container(
                                  transform:
                                      Matrix4.translationValues(-5, -5, 0),
                                  child: InkWell(
                                    child: Icon(Icons.cancel,
                                        size: 20, color: Colors.red),
                                    onTap: () {
                                      setState(() {
                                        controller.images.replaceRange(
                                            item.key,
                                            item.key + 1,
                                            [uploadModel.productName!]);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ));
                        } else {
                          return Expanded(
                              child: GestureDetector(
                                  child: Container(
                                      decoration: boxDecoration.copyWith(
                                          color: backgroundGrey),
                                      padding: p10,
                                      margin: p10,
                                      child: Icon(Icons.add)),
                                  onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => Picker(index: item.key),
                                        barrierDismissible: true,
                                      ).then((value) {
                                        setState(() {});
                                      })));
                        }
                      }).toList()),
                      if (controller.totalSelectedItemPrice.value > 200)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text("What do you prefer?"),
                            SizedBox(height: 5),
                            Container(
                                height: 40,
                                decoration: shapeDecoration,
                                child: Padding(
                                    padding: plr10,
                                    child: DropdownButton(
                                        value: controller.preference.value,
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down),
                                        underline: Container(height: 0),
                                        iconSize: 30,
                                        items:
                                            globals.helpOrderitems.map((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value,
                                                style:
                                                    TextStyle(fontSize: 14.0)),
                                          );
                                        }).toList(),
                                        onChanged: (val) => setState(() {
                                              controller.preference(val.toString());
                                            })))),
                          ],
                        ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: customNonSlimmerElevatedButton(
                              pinkColor, whiteColor),
                          onPressed: () => controller.submitRequest(),
                          child: Text("Submit"),
                        ),
                      )
                    ],
                  ),
              ],
            )),
      ),
    );
  }
}

class CommentSupport extends StatefulWidget {
  const CommentSupport({super.key});

  @override
  CommentSupportState createState() => CommentSupportState();
}

class CommentSupportState extends State<CommentSupport> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: p10,
        shape: roundedCircularRadius,
        child: Container(
            padding: p10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Comment:"),
                SizedBox(height: 5),
                Container(
                    padding: p10,
                    decoration: shapeDecoration,
                    child: TextField(
                        maxLines: 3,
                        controller: controller.comment,
                        decoration: InputDecoration.collapsed(hintText: ""))),
                SizedBox(height: 5),
                if (controller.data.commentAttachment != null &&
                    controller.data.commentAttachment!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Attach Live Images"),
                      Row(
                          children:
                              controller.images.asMap().entries.map((item) {
                        if (item.value is ImageUploadModel) {
                          ImageUploadModel? uploadModel =
                              controller.images[item.key] as ImageUploadModel?;
                          return Expanded(
                              child: Container(
                            padding: p10,
                            child: Stack(
                              children: [
                                Image.file(uploadModel!.imageFile!),
                                Container(
                                  transform:
                                      Matrix4.translationValues(-5, -5, 0),
                                  child: InkWell(
                                    child: Icon(Icons.cancel,
                                        size: 20, color: Colors.red),
                                    onTap: () {
                                      setState(() {
                                        controller.images.replaceRange(
                                            item.key,
                                            item.key + 1,
                                            [uploadModel.productName!]);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ));
                        } else {
                          return Expanded(
                              child: GestureDetector(
                                  child: Container(
                                      decoration: boxDecoration.copyWith(
                                          color: backgroundGrey),
                                      padding: p10,
                                      margin: p10,
                                      child: Icon(Icons.add)),
                                  onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => Picker(index: item.key),
                                        barrierDismissible: true,
                                      ).then((value) {
                                        setState(() {});
                                      })));
                        }
                      }).toList()),
                      controller.images
                                  .whereType<ImageUploadModel>()
                                  .toList()
                                  .length ==
                              controller.images.length
                          ? GestureDetector(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text("+ Add More Images",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                      ))),
                              onTap: () => setState(() {
                                if (controller.images.length < 3) {
                                  controller.images.add("Add Images");
                                } else {
                                  globals.toast(
                                      "You can't add more than 3 Images");
                                }
                              }),
                            )
                          : SizedBox(),
                    ],
                  ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style:
                        customNonSlimmerElevatedButton(pinkColor, whiteColor),
                    onPressed: () => controller.submitCommentSupportRequest(),
                    child: Text("Submit"),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class Picker extends StatelessWidget {
  final int index;
  const Picker({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubTopicDetailController());
    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text("Choose your action", textAlign: TextAlign.center),
        content: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () => controller.openCamera(index)),
                Text("Take a pic")
              ],
            )),
            SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () => controller.onAddImageClick(index)),
                Text("Gallery")
              ],
            )),
          ],
        ));
  }
}

class _TheState {}

var _theState = RM.inject(() => _TheState());

class DropDownMultiSelect extends StatefulWidget {
  /// The options form which a user can select
  final List<String> options;

  /// Selected Values
  final List<String> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<String>) onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// this text is shown when there is no selection
  final String whenEmpty;

  const DropDownMultiSelect({super.key, 
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.whenEmpty,
    this.isDense = false,
    this.enabled = true,
  });
  @override
  DropDownMultiSelectState createState() => DropDownMultiSelectState();
}

class DropDownMultiSelectState extends State<DropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          _theState.rebuild(() => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(widget.selectedValues.isNotEmpty
                      ? widget.selectedValues.reduce((a, b) => '$a , $b')
                      : widget.whenEmpty)))),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              isDense: true,
              value: null,
              onChanged: widget.enabled ? (x) {} : null,
              selectedItemBuilder: (context) {
                return widget.options
                    .map((e) => DropdownMenuItem(
                          child: Container(),
                        ))
                    .toList();
              },
              items: widget.options
                  .map((x) => DropdownMenuItem(
                        value: x,
                        onTap: () {
                          var ns = widget.selectedValues;
                          if (widget.selectedValues.contains(x)) {
                            ns.remove(x);
                          } else {
                            ns.add(x);
                          }
                          widget.onChanged(ns);
                          _theState.notify();
                        },
                        child: _theState.rebuild(() {
                          return Row(
                            children: [
                              Checkbox(
                                  value: widget.selectedValues.contains(x),
                                  onChanged: (value) {
                                    var ns = widget.selectedValues;
                                    if (value!) {
                                      ns.add(x);
                                    } else {
                                      ns.remove(x);
                                    }
                                    widget.onChanged(ns);
                                    _theState.notify();
                                  }),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: Text(x,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 13))),
                            ],
                          );
                        }),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
