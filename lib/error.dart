import 'package:flutter/material.dart';

import 'package:frugivore/widgets/app_bar.dart';
import 'package:frugivore/widgets/drawer.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:Image.asset("assets/images/error.png", fit: BoxFit.fitHeight))
          );
  }
}
