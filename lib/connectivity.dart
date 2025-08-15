import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frugivore/enums/connectivity_status.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;

  const NetworkSensitive({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus?>(context);

    print("Connection----- $connectionStatus");

    if (connectionStatus == null) {
      // You can return a loader or just the child safely
      return Center(child: CircularProgressIndicator()); // or return child;
    }

    if (connectionStatus == ConnectivityStatus.WiFi ||
        connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/images/connectivity.png",
          fit: BoxFit.fitHeight,
        ),
      );
    }
  }
}

