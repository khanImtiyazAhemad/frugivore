import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:in_app_update/in_app_update.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:frugivore/utils.dart';
import 'package:frugivore/error.dart';
import 'package:frugivore/routes.dart';
import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/enums/connectivity_status.dart';

import 'package:frugivore/services/connectivityService.dart';

void main() async {
  const kTestingCrashlytics = true;
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    // throw Exception(e.toString());
    print("---Exception as e ---- $e");
  }
  if (kTestingCrashlytics) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  final GetStorage box = GetStorage();

  AppInitialization appInitialization = AppInitialization();
  // appInitialization.intializeDatabase();
  appInitialization.setInitialData();
  // if (GetPlatform.isAndroid) {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     print(info);
  //   });
  // }
  runApp(MyApp(token: box.hasData('token')));
}

class MyApp extends StatelessWidget {
  final bool token;
  const MyApp({super.key, required this.token});

  GetMaterialApp activity() {
    return GetMaterialApp(
      title: 'Frugivore',
      smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'FilsonProRegular',
        scaffoldBackgroundColor: bodyColor,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: darkGrey),
        ),
      ),
      navigatorKey: Get.key,
      unknownRoute: GetPage(name: '/404', page: () => ErrorPage()),
      getPages: routes(),
      initialRoute: token ? "/" : "/",
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus?>(
      initialData: null,
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return activity();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return activity();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return activity();
          }
          return activity();
        },
      ),
    );
  }
}
