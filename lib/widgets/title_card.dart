import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';

class TitleCard extends StatelessWidget {
  final String title;
  String heading;
  TitleCard({super.key, required this.title, this.heading = ""});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: ptb5,
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff525252),
                    fontFamily: 'FilsonProRegular',
                    fontSize: 22)),
            if (heading != "")
              Text(heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff525252),
                      fontFamily: 'FilsonProRegular',
                      fontSize: 16)),
          ],
        ));
  }
}

class OldTitleCard extends StatelessWidget {
  final String title;
  final Color? color;
  const OldTitleCard({super.key, required this.title, this.color});
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return Padding(
        padding: ptlr10,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Triangle(
                        color: Colors.black,
                        height: 10,
                        width: 10,
                        direction: "ULS"),
                    Container(
                        color: color ?? primaryColor,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Padding(
                          padding: plr10,
                          child: box.read('festival')
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            imageUrl: box.read("festivalIcon"),
                                            height: 30)),
                                    Expanded(
                                        flex: 8,
                                        child: Center(
                                          child: Text(title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            imageUrl: box.read("festivalIcon"),
                                            height: 30)),
                                  ],
                                )
                              : Center(
                                  child: Text(title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                        )),
                    Triangle(
                        color: Colors.black,
                        height: 10,
                        width: 10,
                        direction: "URS")
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class Triangle extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final String? direction;
  final String? value;

  const Triangle(
      {super.key, this.color, this.height, this.width, this.direction, this.value});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapesPainter(color!, direction!),
      child: SizedBox(
          height: height,
          width: width,
          child: value != null
              ? Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 30),
                      child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Text(value!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              )))))
              : null),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final Color color;
  final String direction;
  ShapesPainter(this.color, this.direction);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    if (direction == "URS") {
      path.lineTo(0, size.height);
      path.lineTo(size.height, size.width);
    } else if (direction == "ULS") {
      path.moveTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(size.width, 1);
    } else if (direction == "LRS") {
      path.lineTo(0, size.height);
      path.lineTo(size.width, 0);
    } else if (direction == "LLS") {
      path.lineTo(size.width, 0);
      path.lineTo(size.height, size.width);
    } else if (direction == "ULLRS") {
      path.lineTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
