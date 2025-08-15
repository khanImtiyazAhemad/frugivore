import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:frugivore/models/utils.dart';
import 'package:frugivore/widgets/title_card.dart';

import 'package:frugivore/widgets/custom.dart';

class OfferContainer extends StatelessWidget {
  final DynamicOfferModel item;
  const OfferContainer({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleCard(title: item.code!),
        Card(
            margin: plr10,
            shape: shapeRoundedRectangleBorderBLTL,
            child: Padding(
                padding: plr10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.banner != null)
                            CachedNetworkImage(imageUrl: item.banner),
                          SizedBox(height: 10),
                          if (item.description != null) Text(item.description!),
                          SizedBox(height: 10),
                          if (item.termsAndCondition != null)
                            Html(data: item.termsAndCondition),
                          SizedBox(height: 10),
                        ]))))
      ],
    );
  }
}

class DynamicPopUp extends StatelessWidget {
  final String message;
  const DynamicPopUp({super.key,  required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/exclamation.png', height: 60),
          SizedBox(height: 20),
          Text(message, textAlign: TextAlign.center),
          SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: customElevatedButton(pinkColor, whiteColor),
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop())),
        ],
      ),
    );
  }
}

class ComplaintsHistorySection extends StatelessWidget {
  final int ongoing, past;
  const ComplaintsHistorySection({super.key, required this.ongoing, required this.past});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: p10,
        shape: roundedCircularRadius,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
              child: Container(
                padding: ptlr10,
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                          flex: 8,
                          child: Text("Ongoing Complaints",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green))),
                      Expanded(
                          flex: 1,
                          child: ongoing > 0 ?Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: skyBlueColor, shape: BoxShape.circle),
                            child: Text(ongoing.toString(),
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: whiteColor, fontSize: 11)),
                          ):SizedBox()),
                      Expanded(
                          flex: 1,
                          child: Image.asset('assets/images/blackBackArrow.png',
                              height: 12))
                    ]),
                    SizedBox(height: 10),
                    Divider(height: 1, color: Colors.black),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(context, "/helps")),
          GestureDetector(
              child: Container(
                padding: ptlr10,
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                          flex: 8,
                          child: Text("Past Complaints",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red))),
                      Expanded(
                          flex: 1,
                          child: past> 0 ?Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: skyBlueColor, shape: BoxShape.circle),
                            child: Text(past.toString(),
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: whiteColor, fontSize: 11)),
                          ): SizedBox()),
                      Expanded(
                          flex: 1,
                          child: Image.asset('assets/images/blackBackArrow.png',
                              height: 12))
                    ]),
                    SizedBox(height: 10),
                    Divider(height: 1, color: Colors.black),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(context, "/archives"))
        ]));
  }
}
