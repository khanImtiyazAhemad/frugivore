import 'dart:isolate';
import 'dart:ui';

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/utils.dart';

import 'package:frugivore/screens/order/orderDetail.dart';

import 'package:frugivore/models/order/orderDetail.dart';
import 'package:frugivore/services/order/orderDetail.dart';
import 'package:frugivore/services/utils.dart';

import 'package:frugivore/widgets/custom.dart';

class OrderDetailController extends GetxController {
  String? uuid;
  var isLoader = true.obs;
  var selectedTab = "Summary".obs;
  bool? _permissionReady;
  String? _localPath;
  final ReceivePort _port = ReceivePort();

  final _razorpay = Razorpay();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _data = OrderDetailModel().obs;
  OrderDetailModel get data => _data.value;
  set data(value) => _data.value = value;

  final _activeNormalDateRecord = DateRecord().obs;
  DateRecord get activeNormalDateRecord => _activeNormalDateRecord.value;
  set activeNormalDateRecord(value) =>
      _activeNormalDateRecord.value = value;

  final activeNormalTimeRecord = List<Time>.empty(growable: true).obs;

  var selectedNormalTimeSlot = "".obs;

  Padding staticText(text, {color, textAlign}) {
    return Padding(
      padding: ptb2,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(fontSize: 12.0, color: color, height: 1),
      ),
    );
  }

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchOrderDetail(uuid);
      if (response != null) {
        _data.value = response;
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() async {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    _permissionReady = await _checkPermission();
    if (_permissionReady!) {
      await _prepareSaveDir();
    }
    super.onInit();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {});
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void repeatOrder(uuid) {
    isLoader(true);
    UtilsServices.repeatOrder(uuid).then((response) async {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        CartRouting().routing();
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void claimRefund() async {
    var response = await Services.claimRefund(uuid);
    if (response != null) {
      Get.close(1);
      apicall(uuid);
      if (response['refund_successfull']) {
        showDialog(
          context: Get.context!,
          builder: (_) => ClaimRefundPopUp(message: response['message']),
          barrierDismissible: true,
        );
      } else {
        globals.toast(response['message']);
      }
    }
  }

  Future<bool> _checkPermission() async {
    if (GetPlatform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = '${await _findLocalPath()}${Platform.pathSeparator}Download';
    final savedDir = Directory(_localPath!);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findLocalPath() async {
    final directory = GetPlatform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  void downloadInvoice() async {
    isLoader(true);
    Services.downloadInvoice(uuid).then((response) async {
      isLoader(false);
      await FlutterDownloader.enqueue(
        url: globals.baseuri + response['url'],
        savedDir: _localPath!,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }).catchError((onError) {
      isLoader(false);
      globals.toast(onError.toString());
    });
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void changeDeliverySlotDateTime() async {
    if (selectedNormalTimeSlot.value == "") {
      globals.toast(
          "Please select valid date and time to update the delivery date and time");
    } else {
      Map data = {
        "delivery_date": activeNormalDateRecord.value,
        "delivery_time": selectedNormalTimeSlot.value
      };
      var response = await Services.changeDeliverySlotDateTime(uuid, data);
      if (response != null) {
        apicall(uuid);
        Get.close(1);
      }
    }
  }

  void payNow() {
    var options = {
      'key': globals.razorApiKey,
      "name": "Frugviore India Pvt Ltd",
      "description": "Secure Payment Page",
      "theme": {"color": "#787878"},
      "order_id": data.razorpayOrderId,
      "prefill": {
        'name': globals.payload['name'],
        'contact': globals.payload['phone'],
        'email': globals.payload['email'],
        'method': "card"
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      throw Exception(e.toString());
    }
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    String qsp =
        "payment=${response.paymentId}&signature=${response.signature}";
    Services.payNow(uuid, qsp).then((response) {
      if (response.containsKey('error')) {
        globals.toast(response['error']);
      } else {
        apicall(uuid);
      }
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    apicall(uuid);
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    apicall(uuid);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    apicall(uuid);
    refreshController.loadComplete();
  }
}
