import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/auth.dart';
import 'package:frugivore/services/profile/privacy.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/controllers/profile/privacy.dart';

import 'package:frugivore/connectivity.dart';

// A screen that allows users to take a picture using a given camera.
class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyController());
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
                                      title: "Privacy", search: false),
                                  controller.isLoader.value
                                      ? Loader()
                                      : Column(
                                          children: [
                                            TitleCard(title: "Account"),
                                            Column(children: [
                                                                                          Card(
                                              margin: plr10,
                                              shape:
                                                  shapeRoundedRectangleBorderBLR,
                                              child: Padding(
                                                  padding: p20,
                                                  child: SizedBox(
                                                      width: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(children: [
                                                              Expanded(
                                                                flex: 8,
                                                                child: Text(
                                                                    "Allow SMS"),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Switch(
                                                                  value: controller
                                                                      .data
                                                                      .allowSms!,
                                                                  activeColor:
                                                                      primaryColor,
                                                                  onChanged: (bool
                                                                          value) =>
                                                                      controller
                                                                          .updateProfile({
                                                                    "allow_sms":
                                                                        value
                                                                  }),
                                                                ),
                                                              ),
                                                            ]),
                                                            Padding(
                                                              padding:
                                                                  ptb10,
                                                              child:
                                                                  Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Row(children: [
                                                              Expanded(
                                                                flex: 8,
                                                                child: Text(
                                                                    "Allow Email"),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Switch(
                                                                  value: controller
                                                                      .data
                                                                      .allowEmail!,
                                                                  activeColor:
                                                                      primaryColor,
                                                                  onChanged: (bool
                                                                          value) =>
                                                                      controller
                                                                          .updateProfile({
                                                                    "allow_email":
                                                                        value
                                                                  }),
                                                                ),
                                                              ),
                                                            ]),
                                                            Padding(
                                                              padding:
                                                                  ptb10,
                                                              child:
                                                                  Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Row(children: [
                                                              Expanded(
                                                                flex: 8,
                                                                child: Text(
                                                                    "Allow Notification"),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Switch(
                                                                  value: controller
                                                                      .data
                                                                      .allowNotification!,
                                                                  activeColor:
                                                                      primaryColor,
                                                                  onChanged: (bool
                                                                          value) =>
                                                                      controller
                                                                          .updateProfile({
                                                                    "allow_notification":
                                                                        value
                                                                  }),
                                                                ),
                                                              ),
                                                            ]),
                                                            Padding(
                                                              padding:
                                                                  ptb10,
                                                              child:
                                                                  Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  ptb15,
                                                              child:
                                                                  GestureDetector(
                                                                child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                            9,
                                                                        child:
                                                                            Text("Delete Account"),
                                                                      ),
                                                                      Expanded(
                                                                        flex:
                                                                            1,
                                                                        child: FaIcon(FontAwesomeIcons.angleRight,
                                                                            color: Colors.grey,
                                                                            size: 18),
                                                                      ),
                                                                    ]),
                                                                onTap: () => showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (_) =>
                                                                            DeleteAccount(),
                                                                    barrierDismissible:
                                                                        false),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  ptb10,
                                                              child:
                                                                  Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ]))))
                                                                                        ]),
                                          ],
                                        )
                                ]));
                    })))));
  }
}

class ConfirmationContainer extends StatelessWidget {
  const ConfirmationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: plr10,
        shape: roundedCircularRadius,
        child: Padding(
            padding: p20,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Your changes has been updated Successfully",
                          textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: customElevatedButton(pinkColor, whiteColor),
                          onPressed: () => Navigator.pushNamed(context, "/"),
                          child: Text("HOME"),
                        ),
                      )
                    ]))));
  }
}


class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      actionsAlignment: MainAxisAlignment.center,
      title: Text('Delete Personal Detail', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              'Delete your account will:'),
            Text("- Delete your account info and profile photo"),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style: customNonSlimmerElevatedButton(pinkColor, whiteColor),
                child: Text('Delete Account'),
                onPressed: () async {
                  var response = await Services.deleteAccount();
                  if (response != null) {
                    await AuthServices.removeToken();
                    Navigator.pop(context);
                    globals.payload['cart'] = "0";
                    globals.payload.refresh();
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                })),
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style:
                    customNonSlimmerElevatedButton(backgroundGrey, whiteColor),
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop())),
      ],
    );
  }
}
