import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/controllers/profile/profile.dart';

import 'package:frugivore/connectivity.dart';

// A screen that allows users to take a picture using a given camera.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
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
                                      title: "My Profile", search: false),
                                  controller.confirmation.value
                                      ? ConfirmationContainer()
                                      : Column(children: [
                                      TitleCard(title: "My Details"),
                                      Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Padding(
                                              padding: p10,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    SizedBox(height: 10),
                                                    GestureDetector(
                                                        onTap: () => controller
                                                            .openGallery(),
                                                        child: Container(
                                                          alignment:
                                                              Alignment
                                                                  .center,
                                                          child: controller.profile.avatar !=
                                                                      null &&
                                                                  !controller
                                                                      .avatarChange
                                                                      .value
                                                              ? CircleAvatar(
                                                                  backgroundImage: NetworkImage(controller
                                                                      .profile
                                                                      .avatar ?? ""),
                                                                  radius:
                                                                      60,
                                                                  child:
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomRight,
                                                                          child:
                                                                              Container(
                                                                            padding: p5,
                                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: bodyColor),
                                                                            child: Icon(Icons.edit, color: primaryColor),
                                                                          )))
                                                              : Obx(() => controller
                                                                      .avatarChange
                                                                      .value
                                                                  ? Container(
                                                                      width:
                                                                          120,
                                                                      height:
                                                                          120,
                                                                      decoration:
                                                                          BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: FileImage(controller.avatarImage!))))
                                                                  : CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      child: Text(
                                                                          controller.profile.name![0],
                                                                          style: TextStyle(fontSize: 40.0, color: Colors.white)),
                                                                    )),
                                                        )),
                                                    SizedBox(height: 10),
                                                    controller
                                                        .inputText('Name'),
                                                    controller.inputTextField(
                                                        controller.name,
                                                        "Enter your name"),
                                                    SizedBox(height: 10),
                                                    controller.inputText(
                                                        'Email ID'),
                                                    controller.inputTextField(
                                                        controller.email,
                                                        "Enter Email ID"),
                                                    SizedBox(height: 10),
                                                    controller.inputText(
                                                        'Date of Birth'),
                                                    Container(
                                                        padding: p15,
                                                        decoration:
                                                            shapeDecoration,
                                                        child:
                                                            DateTimeField(
                                                          decoration: controller
                                                              .inputDateDecoration(
                                                                  "dd-mm-yyyy(optional)"),
                                                          mode:
                                                              DateTimeFieldPickerMode
                                                                  .date,
                                                          firstDate:
                                                              controller
                                                                  .selectedDate,
                                                          onChanged:
                                                              (DateTime?
                                                                  value) {
                                                            controller
                                                                    .selectedDate =
                                                                value;
                                                            setState(() {});
                                                          },
                                                        )),
                                                    SizedBox(height: 10),
                                                    controller.inputText(
                                                        'Gender'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            dense: true,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .all(0),
                                                            title: Text(
                                                                "Male"),
                                                            leading: Radio(
                                                                activeColor:
                                                                    pinkColor,
                                                                value:
                                                                    "Male",
                                                                groupValue:
                                                                    controller
                                                                        .gender
                                                                        .value,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .gender(
                                                                          value.toString());
                                                                }),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: ListTile(
                                                            dense: true,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .all(0),
                                                            title: Text(
                                                                "Female"),
                                                            leading: Radio(
                                                                activeColor:
                                                                    pinkColor,
                                                                value:
                                                                    "Female",
                                                                groupValue:
                                                                    controller
                                                                        .gender
                                                                        .value,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .gender(
                                                                          value.toString());
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    controller.inputText(
                                                        'Mobile Number'),
                                                    controller
                                                        .inputPrefixTextField(
                                                            controller
                                                                .phone,
                                                            "Enter your Mobile Number",
                                                            maxline: 1,
                                                            enabled: false),
                                                    SizedBox(height: 10),
                                                    controller.inputText(
                                                        'Alternate Mobile Number'),
                                                    controller.inputPrefixTextField(
                                                        controller
                                                            .alternatePhone,
                                                        "Enter Mobile Number(optional)"),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: ElevatedButton(
                                                                style: customElevatedButton(
                                                                    pinkColor,
                                                                    whiteColor),
                                                                onPressed: () =>
                                                                    controller
                                                                        .updateProfile(),
                                                                child: Text(
                                                                    "Update"))),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              ElevatedButton(
                                                            style: customElevatedButton(
                                                                backgroundGrey,
                                                                Colors
                                                                    .black),
                                                            onPressed: () =>
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    "/").then((value) => controller.apicall()),
                                                            child: Text(
                                                                "Cancel"),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ]))),
                                                                              ]),
                                  SizedBox(height: 80)
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
                          onPressed: () =>
                              Navigator.pushNamed(context, "/"),
                          child: Text("HOME"),
                        ),
                      )
                    ]))));
  }
}
