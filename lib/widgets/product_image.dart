// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/controllers/productDetail.dart';

class ZoomImageContainer extends StatefulWidget {
  String item;
  final List images;
  ZoomImageContainer({super.key, required this.item, required this.images});

  @override
  ZoomImageContainerState createState() => ZoomImageContainerState();
}

class ZoomImageContainerState extends State<ZoomImageContainer> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    return AlertDialog(
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
            width: MediaQuery.of(context).size.width,
            color: darkGrey,
            child: Row(
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.arrow_back_ios_outlined,
                        color: whiteColor, size: 16),
                    onPressed: () => Navigator.of(context).pop()),
                Center(
                  child: Text("Product Image",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: whiteColor, fontSize: 18)),
                )
              ],
            )),
        content: Column(
          children: [
            if (widget.item != "")
              GestureDetector(
                  onDoubleTapDown: controller.handleDoubleTapDown,
                  onDoubleTap: controller.handleDoubleTap,
                  child: Center(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: InteractiveViewer(
                        transformationController:
                            controller.transformationController,
                        panEnabled: true,
                        scaleEnabled: true,
                        minScale: 1.0,
                        maxScale: 2.2,
                        child: CachedNetworkImage(
                            imageUrl: widget.item, fit: BoxFit.fitWidth)),
                  ))),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.map((url) {
                  return GestureDetector(
                    child: Container(
                        alignment: Alignment.center,
                        margin: p10,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.item == url
                                    ? primaryColor
                                    : borderColor)),
                        child: CachedNetworkImage(
                            imageUrl: url, fit: BoxFit.fill)),
                    onTap: () => setState(() {
                      widget.item = url;
                    }),
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }
}
