import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:frugivore/enums/connectivity_status.dart';

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Use Connectivity() here to gather more info if you need t
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  // Cancel the instance to prevent memory leaks and unexpected behaviour
  void disposeStream() {
    connectionStatusController.close();
  }
}
