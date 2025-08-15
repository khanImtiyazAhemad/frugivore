import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_bar.dart';

import 'package:frugivore/models/wallet/wallet.dart';
import 'package:frugivore/controllers/wallet/wallet.dart';

import 'package:frugivore/connectivity.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());
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
                                      title: "My Wallet", search: false),
                                  Column(children: [
                                    Card(
                                        margin: plbr10,
                                        shape: shapeRoundedRectangleBorderBLR,
                                        child: Padding(
                                            padding: p10,
                                            child: Column(
                                              children: [
                                                Text(
                                                    'Total Balance: Rs.${controller.data.total}',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                SizedBox(height: 20),
                                                SizedBox(
                                                  height: 300,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: SfCircularChart(
                                                    legend: Legend(isVisible: true, position: LegendPosition.bottom, overflowMode:LegendItemOverflowMode.wrap),
                                                      series: <CircularSeries>[
                                                        // Render pie chart
                                                        DoughnutSeries<PointsBalance, String>(
                                                          dataSource: controller.chartData,
                                                          pointColorMapper:(PointsBalance data, _) =>  data.colorval,
                                                          xValueMapper: (PointsBalance data, _) => data.type,
                                                          yValueMapper: (PointsBalance data, _) => data.points,
                                                        )
                                                      ]),
                                                ),
                                              ],
                                            ))),
                                    ExpiredCard(items: controller.data.expired!),
                                    Card(
                                        margin: plr10,
                                        shape: roundedCircularRadius,
                                        child: Padding(
                                            padding: p10,
                                            child: Column(children: [
                                              GestureDetector(
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                            padding: p15,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      borderColor),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Icon(
                                                                Icons.money,
                                                                color:
                                                                    primaryColor))),
                                                    Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                            "Recharge your Wallet")),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                            padding: p5,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: primaryColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color:
                                                                    whiteColor,
                                                                size: 14)))
                                                  ]),
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                              context,
                                                              "/recharge/''")
                                                          .then((value) =>
                                                              controller
                                                                  .apicall())),
                                              SizedBox(height: 10),
                                              GestureDetector(
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          padding: p15,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    borderColor),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                              Icons.history,
                                                              color:
                                                                  primaryColor))),
                                                  Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                          "Transaction History")),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          padding: p5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primaryColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color: whiteColor,
                                                              size: 14)))
                                                ]),
                                                onTap: () => Navigator.pushNamed(
                                                        context,
                                                        "/wallet-history?''")
                                                    .then((value) =>
                                                        controller.apicall()),
                                              ),
                                              SizedBox(height: 10),
                                              GestureDetector(
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                            padding: p15,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        borderColor),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Image.asset(
                                                                'assets/images/faq.png',
                                                                color:
                                                                    primaryColor,
                                                                height: 20))),
                                                    Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                            "Wallet FAQ's")),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                            padding: p5,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color:
                                                                    whiteColor,
                                                                size: 14)))
                                                  ]),
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                              context, "/faq")
                                                          .then((value) =>
                                                              controller
                                                                  .apicall())),
                                              SizedBox(height: 10),
                                            ])))
                                  ]),
                                  SizedBox(height: 80)
                                ]));
                    })))));
  }
}

class ExpiredCard extends StatelessWidget {
  final List<Expired> items;
  const ExpiredCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: items.map<Widget>((item) {
      return Card(
          margin: p10,
          shape: roundedCircularRadius,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: p20,
                  child: Row(children: [
                    Text("Your "),
                    Text("Rs ${item.points}",
                        style: TextStyle(color: primaryColor)),
                    Text(" points will be expire on "),
                    Text("${item.date}", style: TextStyle(color: primaryColor))
                  ]))));
    }).toList());
  }
}
