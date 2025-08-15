import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      centerTitle: true,
      title: GestureDetector(
        child: Image.asset('assets/images/logo.png', width: 70),
        onTap: () => Navigator.pushReplacementNamed(
          context,
          "/",
        ).then((value) => setState(() {})),
      ),
      iconTheme: IconThemeData(color: primaryColor),
      actions: [
        Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  iconSize: 22,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  icon: FaIcon(
                    getIconFromCss('fat fa-bell'),
                    color: primaryColor,
                    size: 24,
                  ),
                  onPressed: () {
                    // Get.reset();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/notification",
                      (route) => false,
                    );
                  },
                ),
                Obx(
                  () => Container(
                    height: 18,
                    width: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      globals.payload['notification'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: whiteColor, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: p5,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    iconSize: 22,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    icon: FaIcon(
                      getIconFromCss('fat fa-cart-shopping'),
                      color: primaryColor,
                      size: 24,
                    ),
                    onPressed: () async {
                      // Get.reset();
                      CartRouting().routing();
                    },
                  ),
                  Obx(
                    () => Container(
                      height: 18,
                      width: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        globals.payload['cart'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: whiteColor, fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}