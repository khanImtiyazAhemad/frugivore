import 'package:flutter/material.dart';
import 'package:frugivore/widgets/custom.dart';

class ThemeStrip extends StatefulWidget {
  const ThemeStrip({super.key});

  @override
  ThemeStripState createState() => ThemeStripState();
}

class ThemeStripState extends State<ThemeStrip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ptb10,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: Column(children: [
                    Image.asset('assets/images/freshness.png', height: 50),
                    SizedBox(height: 5),
                    Text("UNPARALLELED FRESHNESS",
                        style: TextStyle(fontSize: 9.5),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true)
                  ]),
                  onTap: () => Navigator.pushNamed(context, "/about-us")
                      .then((value) => setState(() {})))),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset('assets/images/pcp.png', height: 50),
                      SizedBox(height: 5),
                      Text("EXCLUSIVE PRODUCTS",
                          style: TextStyle(fontSize: 9.5),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true)
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, "/about-us")
                      .then((value) => setState(() {})))),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset('assets/images/unbeatable.png', height: 50),
                      SizedBox(height: 5),
                      Text("UNBEATABLE VALUE",
                          style: TextStyle(fontSize: 9.5),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true)
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, "/about-us")
                      .then((value) => setState(() {})))),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset('assets/images/planet.png', height: 50),
                      SizedBox(height: 5),
                      Text("PLANET FRIENDLY",
                          style: TextStyle(fontSize: 9.5),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true)
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, "/about-us")
                      .then((value) => setState(() {})))),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset('assets/images/foodtofeel.png', height: 50),
                      SizedBox(height: 5),
                      Text("FEEL GOOD FOOD",
                          style: TextStyle(fontSize: 9.5),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true)
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, "/about-us")
                      .then((value) => setState(() {})))),
        ],
      ),
    );
  }
}
