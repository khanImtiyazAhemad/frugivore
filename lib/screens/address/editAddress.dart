import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/widgets/pincode.dart';

import 'package:frugivore/controllers/address/editAddress.dart';

import 'package:frugivore/connectivity.dart';

class EditAddressPage extends StatelessWidget {
  const EditAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditAddressController());
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
                    : Column(
                        children: [
                          Column(
                            children: [
                              CustomTitleBar(
                                title: "Edit Address",
                                search: false,
                              ),
                              Card(
                                color: whiteColor,
                                margin: plr10,
                                shape: roundedCircularRadius,
                                child: Padding(
                                  padding: p10,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText("City"),
                                                  CitiesDropDown(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText(
                                                    "Pincode",
                                                  ),
                                                  PinCodeContainer(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        controller.inputText("Area"),
                                        controller.inputTextField(
                                          controller.area,
                                          "Area",
                                        ),
                                        controller.inputText("Address Details"),
                                        controller.inputTextField(
                                          controller.addressDetail,
                                          "Please provide details FLoor, H.No, Street No, Locality.",
                                          maxline: 5,
                                        ),
                                        controller.inputText("Landmark"),
                                        controller.inputTextField(
                                          controller.landmark,
                                          "Landmark(optional)",
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText("Name"),
                                                  controller.inputTextField(
                                                    controller.name,
                                                    "Name",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText("Email"),
                                                  controller.inputTextField(
                                                    controller.email,
                                                    "Email",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText(
                                                    "Mobile Number",
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            .1,
                                                        decoration:
                                                            boxDecoration
                                                                .copyWith(
                                                                  color:
                                                                      bodyColor,
                                                                ),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                              5,
                                                              10,
                                                              5,
                                                              10,
                                                            ),
                                                        child: Text(
                                                          "+91",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            .33,
                                                        padding: p10,
                                                        decoration:
                                                            shapeDecoration,
                                                        child: TextField(
                                                          controller: controller
                                                              .mobileNumber,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                          decoration: controller
                                                              .inputDecoration(
                                                                "Mobile Number",
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.inputText(
                                                    "Alternate Number",
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            .1,
                                                        decoration:
                                                            boxDecoration
                                                                .copyWith(
                                                                  color:
                                                                      bodyColor,
                                                                ),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                              5,
                                                              10,
                                                              5,
                                                              10,
                                                            ),
                                                        child: Text(
                                                          "+91",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            .33,
                                                        padding: p10,
                                                        decoration:
                                                            shapeDecoration,
                                                        child: TextField(
                                                          controller: controller
                                                              .alternatePhoneNumber,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                          decoration: controller
                                                              .inputDecoration(
                                                                "Alternate Number",
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        controller.inputText("Address Type"),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(
                                                  0,
                                                ),
                                                title: Text(
                                                  "Home",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                leading: Radio(
                                                  activeColor: pinkColor,
                                                  value: "Home",
                                                  groupValue: controller
                                                      .addressType
                                                      .value,
                                                  onChanged: (value) {
                                                    controller.addressType(
                                                      value.toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(
                                                  0,
                                                ),
                                                title: Text(
                                                  "Work",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                leading: Radio(
                                                  activeColor: pinkColor,
                                                  value: "Work",
                                                  groupValue: controller
                                                      .addressType
                                                      .value,
                                                  onChanged: (value) {
                                                    controller.addressType(
                                                      value.toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(
                                                  0,
                                                ),
                                                title: Text(
                                                  "Other",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                leading: Radio(
                                                  activeColor: pinkColor,
                                                  value: "Other",
                                                  groupValue: controller
                                                      .addressType
                                                      .value,
                                                  onChanged: (value) {
                                                    controller.addressType(
                                                      value.toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ElevatedButton(
                                            style: customElevatedButton(
                                              primaryColor,
                                              whiteColor,
                                            ),
                                            onPressed: () =>
                                                controller.editAddress(),
                                            child: Text("Save"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
