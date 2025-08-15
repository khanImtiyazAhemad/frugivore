import 'package:flutter/material.dart';
import 'package:frugivore/utils.dart' as utils;

import 'package:frugivore/widgets/custom.dart';
import 'package:marquee/marquee.dart';

class InformativeStrip extends StatefulWidget {
  final String message;
  const InformativeStrip({super.key, required this.message});

  @override
  InformativeStripState createState() => InformativeStripState();
}

class InformativeStripState extends State<InformativeStrip> {
  bool isClosed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: Key("Infromation"),
        child: !isClosed
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: p5,
                color: Color(0xffffc107),
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        child: Marquee(
                          text: widget.message,
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          startPadding: 10.0,
                          style: TextStyle(color: whiteColor, fontSize: 15)
                          
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child:
                            Icon(Icons.cancel, color: Colors.white, size: 18))
                  ],
                ))
            : SizedBox(),
        onTap: () => setState(() {
              utils.AppInitialization().removeInformationData();
              isClosed = true;
            }));
  }
}
