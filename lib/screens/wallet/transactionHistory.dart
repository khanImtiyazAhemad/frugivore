import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';
import 'package:frugivore/widgets/loader.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/models/wallet/transactionHistory.dart';
import 'package:frugivore/controllers/wallet/transactionHistory.dart';

import 'package:frugivore/connectivity.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionHistoryController());
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
                                  Column(children: [
                                                                      TitleCard(title: "Wallet History"),
                                                                      Card(
                                    margin: plr10,
                                    shape: roundedCircularRadius,
                                    child: Padding(
                                        padding: p10,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                children: [
                                                  Text(
                                                      controller
                                                          .data.chart1Title ?? "",
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                      height: 400,
                                                      width: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width,
                                                      child: SfCircularChart(
                                                        legend: Legend(isVisible: true, position: LegendPosition.bottom, overflowMode:LegendItemOverflowMode.wrap),
                                                  series: <CircularSeries>[
                                                    // Render pie chart
                                                    DoughnutSeries<Data, String>(
                                                      dataSource: controller.chart1Data,
                                                      pointColorMapper:(Data data, _) =>  Color(data.color),
                                                      xValueMapper: (Data data, _) => data.type,
                                                      yValueMapper: (Data data, _) => double.parse(data.points!),
                                                    )
                                                  ])),
                                                  SizedBox(height: 20),
                                                  Text(
                                                      controller
                                                          .data.chart2Title ?? "",
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                      height: 300,
                                                      width: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width,
                                                      child: SfCircularChart(
                                                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                                                  series: <CircularSeries>[
                                                    // Render pie chart
                                                    DoughnutSeries<Data, String>(
                                                      dataSource: controller.chart2Data,
                                                      pointColorMapper:(Data data, _) =>  Color(data.color),
                                                      xValueMapper: (Data data, _) => data.type,
                                                      yValueMapper: (Data data, _) => double.parse(data.points!),
                                                    )
                                                  ])),
                                                ])))),
                                                                      ExpiredCard(items: controller.data.expired!),
                                                                      PointsCard(
                                    items: controller.data.walletHistory!),
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

class PointsCard extends StatelessWidget {
  final List<WalletHistory> items;
  const PointsCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionHistoryController());
    return Card(
        margin: ptlr10,
        shape: roundedCircularRadius,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map<Widget>((item) {
                return Container(
                  decoration: boxDecorationBottomBorder,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.typeOfPoints!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      Text(item.createdAt!,
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      item.typeOfPoints == "Paid" ||
                                              item.typeOfPoints == "Expired"
                                          ? Icon(Icons.remove,
                                              color: primaryColor, size: 12)
                                          : Icon(Icons.add,
                                              color: primaryColor, size: 12),
                                      SizedBox(width: 5),
                                      Text("\u{20B9} ${item.points}",
                                          style: TextStyle(fontSize: 14))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => controller
                                .clickedHistory(item.transactionId.toString())),
                        Visibility(
                            visible: item.transactionId.toString() ==
                                controller.clickedHistory.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Transaction ID: #${item.transactionId}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic)),
                                if (item.invoiceNumber != null)
                                  Text("Order ID: #${item.invoiceNumber}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic)),
                                if (item.expireAt != null)
                                  Text("Expired at: ${item.expireAt}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontStyle: FontStyle.italic))
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              }).toList(),
            )));
  }
}
