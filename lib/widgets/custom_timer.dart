// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:frugivore/models/home.dart';
import 'package:frugivore/widgets/custom.dart';

class CustomTimer extends StatefulWidget {
  final FlashSale item;
  const CustomTimer({super.key, required this.item});

  @override
  CustomTimerState createState() => CustomTimerState();
}

class CustomTimerState extends State<CustomTimer> {
  dynamic timer;
  @override
  initState() {
    super.initState();
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  var days = "00";
  var hours = "00";
  var mins = "00";
  var secs = "00";

  void tickerRunning(remainingTime) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime -= 1000;
        int daysValue = (remainingTime / (24 * 60 * 60 * 1000)).floor();
        days =
            daysValue < 10 ? "0$daysValue" : daysValue.toString();

        int hoursValue =
            ((remainingTime - (daysValue * (24 * 60 * 60 * 1000))) /
                    (60 * 60 * 1000))
                .floor();
        hours = hoursValue < 10
            ? "0$hoursValue"
            : hoursValue.toString();

        int minutesValue = ((remainingTime -
                    (daysValue * (24 * 60 * 60 * 1000)) -
                    (hoursValue * (60 * 60 * 1000))) /
                (60 * 1000))
            .floor();
        mins = minutesValue < 10
            ? "0$minutesValue"
            : minutesValue.toString();

        int secondsValue = ((remainingTime -
                    (daysValue * (24 * 60 * 60 * 1000)) -
                    (hoursValue * (60 * 60 * 1000)) -
                    (minutesValue * 60 * 1000)) /
                (1000))
            .floor();
        secs = secondsValue < 10
            ? "0$secondsValue"
            : secondsValue.toString();

        if (remainingTime <= 1000) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) tickerRunning(widget.item.remainingTime);
    return Container(
      padding: plbr10,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: 40,
                  width: 40,
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(days,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white)),
                      SizedBox(height: 2),
                      Text("Days",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  ))),
          SizedBox(width: 10),
          Expanded(
              child: Container(
                  height: 40,
                  width: 40,
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(hours,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white)),
                      SizedBox(height: 2),
                      Text("Hour",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  ))),
          SizedBox(width: 10),
          Expanded(
              child: Container(
                  height: 40,
                  width: 40,
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(mins,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white)),
                      SizedBox(height: 2),
                      Text("Mins",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  ))),
          SizedBox(width: 10),
          Expanded(
              child: Container(
                  height: 40,
                  width: 40,
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(secs,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white)),
                      SizedBox(height: 2),
                      Text("Secs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  )))
        ],
      ),
    );
  }
}
