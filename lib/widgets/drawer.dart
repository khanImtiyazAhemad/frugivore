import 'package:frugivore/services/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/auth.dart';
import 'package:frugivore/widgets/custom.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  static final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: whiteColor,
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              box.hasData('token')
                  ? Center(
                      child: Row(children: [
                        if (globals.payload['avatar'] != null &&
                            globals.payload['avatar'] != "")
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 70,
                              width: 70,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          globals.payload['avatar']),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                        Expanded(
                            flex: 6,
                            child: Container(
                                width: 100,
                                margin: EdgeInsets.only(left: 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0),
                                          child: Text(globals.payload['name'],
                                              style:
                                                  TextStyle(fontSize: 12))),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(getIconFromCss('fat fa-location-dot'), color: primaryColor, size: 24),
                                            SizedBox(width: 5),
                                            Flexible(
                                                child: Text(
                                                    globals
                                                        .payload['address'],
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        fontSize: 12)))
                                          ])
                                    ])))
                      ]),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(getIconFromCss('fat fa-location-dot'), color: primaryColor, size: 24),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(globals.payload['address'],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 12)),
                              )
                            ]),
                        Container(
                            padding: p10,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: customCircularElevatedButton(
                                    pinkColor, whiteColor),
                                onPressed: () =>
                                    Navigator.pushNamed(context, "/login"),
                                child: Text("Login/Sign Up"))),
                      ],
                    ),
              SizedBox(height: 10)
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height * .9,
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.black, height: 0),
                    shrinkWrap: true,
                    itemCount: globals.drawerdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map item = globals.drawerdata[index];
                      if (item['child']!.isNotEmpty) {
                        return ListTileTheme(
                            style: ListTileStyle.drawer,
                            dense: true,
                            contentPadding: plr20,
                            child: ExpansionTile(
                              title: Text(item['title'],
                                  style: TextStyle(fontSize: 14)),
                              leading: item['leading'],
                              trailing: item['trailing'],
                              onExpansionChanged: (val) => val
                                  ? Icon(Icons.remove,
                                      color: Colors.black, size: 20)
                                  : item['trailing'],
                              children: [
                                ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        Divider(color: Colors.black, height: 0),
                                    shrinkWrap: true,
                                    itemCount: item['child'].length,
                                    itemBuilder: (BuildContext context, int i) {
                                      Map childitem = item['child'][i];
                                      return ListTile(
                                          dense: true,
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          contentPadding: EdgeInsets.only(
                                              left: 30,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          title: Text(childitem['title'],
                                              style: TextStyle(fontSize: 14)),
                                          leading: childitem['leading'],
                                          onTap: () {
                                            // Get.reset();
                                            Navigator.of(context).pop();
                                            if (childitem['action'] ==
                                                "/subcategory") {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  childitem['action'] +
                                                      "/${childitem['categorySlug']}/${childitem['subCategorySlug']}",
                                                  (route) =>
                                                      false).then(
                                                  (value) => setState(() {}));
                                            } else {
                                              Navigator.pushNamed(
                                                      context, childitem['action'])
                                                  .then((value) => setState(() {}));
                                            }
                                          });
                                    })
                              ],
                            ));
                      } else {
                        return item['action'] == "/logout" && !box.hasData("token")
                            ? null
                            : ListTile(
                                dense: true,
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                title: Text(item['title'],
                                    style: TextStyle(fontSize: 14)),
                                leading: item['leading'],
                                trailing: item['trailing'],
                                onTap: () {
                                  String currentRoute = Get.currentRoute;
                                  if (currentRoute != item['action']) {
                                    // Get.reset();
                                    Navigator.of(context).pop();
                                    if (item['action'] == "/blogs") {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          item['action'] + "/''", (route) => false);
                                    } else if (item['action'] ==
                                        "/my-shopping-lists") {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        item['action'],
                                        (route) => false,
                                        arguments: [],
                                      );
                                    } else if (item['action'] == "/logout") {
                                      showDialog(
                                          context: context,
                                          builder: (_) => Logout(),
                                          barrierDismissible: false);
                                    } else if (item['action'] ==
                                        "/frugivore-sale") {
                                      if (box.read('saleStatus')) {
                                        Get.toNamed(
                                                "${item['action']}/${box.read('slug')}")!
                                            .then((value) => setState(() {}));
                                      }
                                    } else {
                                      Get.toNamed(item['action'])!
                                          .then((value) => setState(() {}));
                                    }
                                  } else {
                                    Get.close(1);
                                  }
                                });
                      }
                    }),
              ),
              
            ],
          ),
          SizedBox(height: 500)
        ],
      ),

    ));
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.all(10),
      title: Text('Logout', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              'Do you want to Logout?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style: customNonSlimmerElevatedButton(pinkColor, whiteColor),
                child: Text('Logout'),
                onPressed: () async {
                  var response = await UtilsServices.logout();
                  if (response != null) {
                    await AuthServices.removeToken();
                    Navigator.pop(context);
                    globals.payload['cart'] = "0";
                    globals.payload.refresh();
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                })),
        SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: ElevatedButton(
                style:
                    customNonSlimmerElevatedButton(backgroundGrey, whiteColor),
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop())),
      ],
    );
  }
}
