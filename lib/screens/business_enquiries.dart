import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/controllers/businessEnquiries.dart';

import 'package:frugivore/connectivity.dart';

class BusinessEnquiriesPage extends StatelessWidget {
  const BusinessEnquiriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusinessEnquiriesController());
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
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTitleBar(
                                            title: "Business Enquiries",
                                            search: false),
                                        Card(
                                            margin: plr10,
                                            shape: roundedHalfCircularRadius,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: p20,
                                                    child: Column(children: [
                                                      Padding(
                                                          padding: ptb5,
                                                          child: Text(
                                                              "Business Enquiries",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      SizedBox(height: 40),
                                                      Text(
                                                          "Are you a Hotel, Restaurant, Corporate or an Instituitional Buyer?"),
                                                      Divider(
                                                          color: borderColor),
                                                      Text(
                                                          "Do you need any of our products in bulk? (Order size > Rs 10,000)"),
                                                      Divider(
                                                          color: borderColor),
                                                      Text(
                                                          "We are happy to provide you special discounts. Please contact us :"),
                                                      Divider(
                                                          color: borderColor),
                                                      Row(
                                                        children: [
                                                          FaIcon(
                                                              getIconFromCss(
                                                                  'fat fa-phone'),
                                                              color:
                                                                  primaryColor,
                                                              size: 16),
                                                          SizedBox(width: 10),
                                                          Text("844 844 844")
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          FaIcon(
                                                              getIconFromCss(
                                                                  'fat fa-envelope'),
                                                              color:
                                                                  primaryColor,
                                                              size: 16),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              "care@frugivore.in")
                                                        ],
                                                      ),
                                                    ])),
                                                Container(
                                                  color: backgroundGrey,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  child: Padding(
                                                    padding: ptb10,
                                                    child: Text(
                                                      "Enquiry Form",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: p20,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Phone Number/Email",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(height: 10),
                                                          Container(
                                                            padding: p10,
                                                            decoration:
                                                                shapeDecoration,
                                                            child: TextField(
                                                              maxLines: 1,
                                                              controller:
                                                                  controller
                                                                      .contact,
                                                              decoration: InputDecoration
                                                                  .collapsed(
                                                                      hintText:
                                                                          "Enter 10 digit Mobile Number or Email"),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text("Subject",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(height: 10),
                                                          Container(
                                                              height: 36,
                                                              decoration:
                                                                  shapeDecoration,
                                                              child: Obx(
                                                                  () => Padding(
                                                                        padding:
                                                                            plr10,
                                                                        child: DropdownButton(
                                                                            value: BusinessEnquiriesController.defaultSubject.value,
                                                                            isExpanded: true,
                                                                            icon: Icon(Icons.arrow_drop_down),
                                                                            underline: Container(height: 0),
                                                                            iconSize: 30,
                                                                            items: globals.businessEnquiriesList.map((value) {
                                                                              return DropdownMenuItem(
                                                                                value: value,
                                                                                child: Text(value, style: TextStyle(fontSize: 16)),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged: (val) => BusinessEnquiriesController.changeSubjects(val)),
                                                                      ))),
                                                          SizedBox(height: 10),
                                                          Container(
                                                            padding: p10,
                                                            decoration:
                                                                shapeDecoration,
                                                            child: TextField(
                                                              textInputAction: TextInputAction.go,
                                                              maxLines: 4,
                                                              controller:
                                                                  controller
                                                                      .message,
                                                              decoration:
                                                                  InputDecoration
                                                                      .collapsed(
                                                                          hintText:
                                                                              ""),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
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
                                                                          "/"),
                                                                  child: Text(
                                                                      "Cancel"),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: ElevatedButton(
                                                                      style: customElevatedButton(
                                                                          pinkColor,
                                                                          whiteColor),
                                                                      onPressed:
                                                                          () =>
                                                                              controller.submit(),
                                                                      child: Text(
                                                                          "Submit")))
                                                            ],
                                                          )
                                                        ]))
                                              ],
                                            )),
                                        SizedBox(height: 80)
                                      ])));
                    })))));
  }
}
