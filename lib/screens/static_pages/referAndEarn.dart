import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/controllers/staticPages/referAndEarn.dart';

import 'package:frugivore/connectivity.dart';

class ReferEarnPage extends StatelessWidget {
  const ReferEarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());
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
                                  child: Column(children: [
                                    TitleCard(
                                        title:
                                            "Refer your Friends"),
                                    Card(
                                        margin: plr10,
                                        shape: shapeRoundedRectangleBorderBLR,
                                        child: Padding(
                                            padding: p10,
                                            child: Column(children: [
                                              Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomStart,
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl: controller
                                                            .data.banner![0].image ?? ""),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 10),
                                                      child: ElevatedButton(
                                                        style:
                                                            referCustomElevatedButton(
                                                                whiteColor,
                                                                pinkColor,
                                                                pinkColor),
                                                        onPressed: () =>
                                                            showModalBottomSheet(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20)),
                                                                ),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return ConditionsModalBottomSheet();
                                                                }),
                                                        child: Text(
                                                            "Terms & Conditions"),
                                                      ),
                                                    )
                                                  ]),
                                              controller.contacts.isNotEmpty
                                                  ? Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () =>
                                                              showModalBottomSheet(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        topLeft:
                                                                            Radius.circular(20)),
                                                                  ),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ReferralModalBottomSheet();
                                                                  }),
                                                          child: Container(
                                                            padding: ptb10,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: CircleAvatar(
                                                                        child: Icon(
                                                                            Icons.mobile_screen_share_outlined))),
                                                                SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                    flex: 6,
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              "Imtiyaz Ahemad",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                          SizedBox(
                                                                              height: 5),
                                                                          Text(globals
                                                                              .payload['referral_code'])
                                                                        ])),
                                                                SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                        "Share",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blue))),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                            height: 1,
                                                            color:
                                                                Colors.black),
                                                        Column(
                                                          children: controller
                                                              .contacts
                                                              .map<Widget>(
                                                                  (contact) {
                                                            return ContactCard(
                                                                contact:
                                                                    contact);
                                                          }).toList(),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Container(
                                                          padding: p15,
                                                          decoration: boxDecoration
                                                              .copyWith(
                                                                  color:
                                                                      bodyColor),
                                                          child: TextField(
                                                            controller: controller
                                                                .referralCode,
                                                            readOnly: true,
                                                            decoration:
                                                                InputDecoration
                                                                    .collapsed(
                                                                        hintText:
                                                                            "REFERRAL CODE"),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Container(
                                                          padding: p15,
                                                          decoration:
                                                              boxDecoration,
                                                          child: TextField(
                                                            controller:
                                                                controller
                                                                    .email,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration
                                                                    .collapsed(
                                                                        hintText:
                                                                            "Enter Mobile No. to Refer"),
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text("or",
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                        SizedBox(height: 20),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              child: FaIcon(getIconFromCss('fab fa-whatsapp'), color: primaryColor, size: 30),
                                                              onTap: () =>
                                                                  controller
                                                                      .launchWhatsapp(),
                                                            ),
                                                            SizedBox(width: 20),
                                                            GestureDetector(
                                                              child: FaIcon(getIconFromCss('fat fa-envelope'), color: primaryColor, size: 30),
                                                              onTap: () =>
                                                                  controller
                                                                      .launchEmail(),
                                                            ),
                                                            SizedBox(width: 20),
                                                            GestureDetector(
                                                              child: FaIcon(getIconFromCss('fat fa-copy'), color: primaryColor, size: 30),
                                                              onTap: () =>
                                                                  controller
                                                                      .referralCopy(),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(height: 20),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 40,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: customCircularElevatedButton(
                                                                      pinkColor,
                                                                      whiteColor),
                                                                  onPressed: () =>
                                                                      controller
                                                                          .submitReference(),
                                                                  child: Text(
                                                                      "Refer"),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 40,
                                                                child: ElevatedButton(
                                                                    style: customCircularElevatedButton(
                                                                        backgroundGrey,
                                                                        Colors
                                                                            .black),
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    child: Text(
                                                                        "Cancel")),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                            ]))),
                                    SizedBox(height: 80)
                                  ])));
                    })))));
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  const ContactCard({super.key, required  this.contact});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());
    return Container(
      padding: ptb10,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: CircleAvatar(
                  backgroundColor:
                      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                          .withValues(alpha:1.0),
                  child: Text(contact.displayName[0],
                      style: TextStyle(color: Colors.white)))),
          SizedBox(width: 10),
          Expanded(
              flex: 6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.displayName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    contact.phones.first.number.contains("+91")
                        ? Text(contact.phones.first.number)
                        : Text("+91 ${contact.phones.first.number}")
                  ])),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: controller.data.referrals!.contains(
                      contact.phones.first.number.replaceAll("+91 ", ""))
                  ? Text("Reffered",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: packageColor))
                  : GestureDetector(
                      child: Text("Invite",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryColor)),
                      onTap: () =>
                          controller.invite(contact.phones.first.number))),
        ],
      ),
    );
  }
}

class ConditionsModalBottomSheet extends StatelessWidget {
  const ConditionsModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());
    return Stack(alignment: Alignment.bottomCenter, children: [
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: p20,
              child: Column(
                children: [
                  Row(children: [
                    Image.asset('assets/images/logo.png', width: 50),
                    SizedBox(width: 10),
                    Text("From Frugivore")
                  ]),
                  SizedBox(height: 20),
                  Html(data: controller.data.data!.content),
                  SizedBox(height: 40)
                ],
              ))),
      Container(
        margin: ptb10,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return ReferralModalBottomSheet();
              }),
          style: referCustomElevatedButton(pinkColor, whiteColor, pinkColor),
          child: Text("Invite friends"),
        ),
      )
    ]);
  }
}

class ReferralModalBottomSheet extends StatelessWidget {
  const ReferralModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() => Padding(
            padding: p20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset('assets/images/logo.png', width: 50),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      flex: 8,
                      child: GestureDetector(
                          onTap: () => controller.showLess(
                              controller.showLess.value ? false : true),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Check out Frugivore with me",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(
                                  controller.showLess.value
                                      ? controller.baseMessage
                                          .substring(0, 150)
                                      : controller.baseMessage,
                                  softWrap: true),
                            ],
                          )))
                ]),
                SizedBox(height: 10),
                Divider(height: 1, color: Colors.black),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Image.asset("assets/images/whatsapp.png",
                          height: 30),
                      onTap: () => controller.launchWhatsapp(),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: Icon(Icons.email, color: primaryColor),
                      onTap: () => controller.launchEmail(),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      child: Icon(Icons.copy_outlined),
                      onTap: () => controller.referralCopy(),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: 1, color: Colors.black),
                SizedBox(height: 10),
                Container(
                  decoration: shapeDecoration,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                          flex: 8,
                          child: TextField(
                            controller: controller.searchContacts,
                            decoration: InputDecoration.collapsed(
                              hintText: "Search Contacts",
                            ),
                            onChanged: (text) =>
                                controller.searchContactsMethod(text),
                          )),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(Icons.cancel, size: 18),
                            onPressed: () => controller.clearSearchField()),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text("Phone Contacts", textAlign: TextAlign.start),
                SizedBox(height: 10),
                Column(
                  children: controller.filteredContacts.map<Widget>((contact) {
                    return SocialContactCard(contact: contact);
                  }).toList(),
                ),
              ],
            ))));
  }
}

class SocialContactCard extends StatelessWidget {
  final Contact contact;
  const SocialContactCard({super.key, required  this.contact});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());
    return GestureDetector(
      child: Container(
        padding: ptb10,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: CircleAvatar(
                    backgroundColor:
                        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                            .withValues(alpha: 255),
                    child: Text(contact.displayName[0],
                        style: TextStyle(color: Colors.white)))),
            SizedBox(width: 10),
            Expanded(
                flex: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.displayName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      contact.phones.first.number.contains("+91")
                          ? Text(contact.phones.first.number)
                          : Text("+91 ${contact.phones.first.number}")
                    ])),
          ],
        ),
      ),
      onTap: () =>
          controller.launchWhatsapp(number: contact.phones.first.number),
    );
  }
}
