import 'dart:io';
import 'package:get/get.dart';
import "package:flutter/material.dart";

import 'package:frugivore/controllers/picker.dart';

class Picker extends StatelessWidget {
  final PickerController controller = Get.put(PickerController());
  final File image;
  Picker({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () => controller.openCamera(image)),
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
                    onPressed: () => controller.openGallery(image)),
                Text("Gallery")
              ],
            )),
          ],
        ));
  }
}
