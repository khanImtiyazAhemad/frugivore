import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/controllers/staticPages/aboutUs.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';
import 'package:frugivore/widgets/theme.dart';

import 'package:frugivore/connectivity.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutUsController());
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
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: controller.isLoader.value
                              ? Loader()
                              : Column(children: [
                                  CustomTitleBar(
                                      title: "About Us", search: false),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Card(
                                          margin: plr10,
                                          shape: roundedCircularRadius,
                                          child: Column(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    controller.data.data!.image ?? "",
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                color: Color(0xff7e906f),
                                                child: Padding(
                                                  padding: ptb15,
                                                  child: Text(
                                                    "Bringing the best of FRUGIVORE",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              ThemeStrip(),
                                              Padding(
                                                  padding: p20,
                                                  child: Column(children: [
                                                    Text(
                                                      "FEEL GOOD FOOD!",
                                                      style: TextStyle(
                                                          fontSize: 50,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "Frugivore is a ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "new online food specialist in India ",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "offering an extensive range of ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "premium products with unbeatable value.",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular'))
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        )),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "Launched in 2018, Frugivore",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    " bring the best of grocery, creating a unique online grocery destination to ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "feel good about every delicious bite.",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular'))
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Image.asset(
                                                        'assets/images/FreshlyMobile.jpg'),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "UNPARALLELED FRESHNESS",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "The freshest fruits, vegetables, juices & dairy ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "straight from our trusted farms direct to your door.",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    " Our unique fulfilment process ensures our incredibly fresh products arrive at our customers doorstep in perfect condition, ready to savour and enjoy.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular'))
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Image.asset(
                                                        'assets/images/PLPMobile.jpg'),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "EXCLUSIVE FRUGIVORE PRODUCTS",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "While we do stock some favourite market leading brands, most of the products we carry are grown or produced under strict quality standards and ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "exclusively for Frugivore so we can maintain lower prices for our customers, everyday!",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Image.asset(
                                                        'assets/images/FruitBoxMobile.jpg'),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "PREMIUM PANTRY STAPLES WITHOUT THE PREMIUM PRICE TAG",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "A vast range of ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "pantry staples",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    " and innovative products from breakfast cereal to baked goods, condiments to coffee, all crafted for superior taste and quality.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Image.asset(
                                                        'assets/images/PlanetMobile.jpg'),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "FRIENDLY TO THE PLANET",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "Frugivore is committed to ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "minimising the use of single use plastics in our packaging and we also use electric vehicles",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    " for delivery. These are critical measures we are taking within our wider business to create a positive impact.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Image.asset(
                                                        'assets/images/WomenEmpowermentMobile.jpg'),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "FOOD TO FEEL GOOD ABOUT",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "Did you know that women grow as much as 80% of India’s food? ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                            TextSpan(
                                                                text:
                                                                    "At Frugivore 1% of our profits are used to support and empower women in agriculture.",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff7e906f),
                                                                    fontFamily:
                                                                        'FilsonProRegular')),
                                                          ],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )),
                                                    SizedBox(height: 60),
                                                    Text(
                                                      "So when we say",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "FEEL GOOD FOOD!",
                                                      style: TextStyle(
                                                          fontSize: 50,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "we really mean it!",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'Chantal',
                                                          color: Color(
                                                              0xff7e906f)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ])),
                                              ThemeStrip(),
                                              SizedBox(height: 20)
                                            ],
                                          ))),
                                  SizedBox(height: 200),
                                ]));
                    })))));
  }
}
