import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/services/subscription/createSubscriptionPlan.dart';
import 'package:frugivore/models/subscription/createSubscriptionPlan.dart';

class CreateSubscriptionPlanController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  var orderOccurance = "Daily".obs;
  var orderEndsOn = "Never".obs;
  var orderTimeSlot = "".obs;
  var defaultCustomOccurance = "".obs;
  RxList selectedWeekDays = [].obs;
  RxList selectedMonthDate = [].obs;
  DateTime startDate = DateTime.now().add(Duration(days: 1));

  DateTime? endsOnDate;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController repeatsCount = TextEditingController();
  final TextEditingController endsOnCount = TextEditingController();

  final _data = CreateSubscriptionPlanModel().obs;
  CreateSubscriptionPlanModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchDetail(uuid);
      if (response != null) {
        _data.value = response;
        orderTimeSlot(response.slots?[0].id.toString());
      }
    } finally {
      isLoader(false);
    }
  }

  @override
  void onInit() {
    uuid = Get.parameters['uuid'];
    apicall(uuid);
    super.onInit();
  }

  void changeWeekDays(value) {
    if (selectedWeekDays.contains(value)) {
      selectedWeekDays.remove(value);
    } else {
      selectedWeekDays.add(value);
    }
  }

  void changeMonthDate(value) {
    if (selectedMonthDate.contains(value)) {
      selectedMonthDate.remove(value);
    } else {
      selectedMonthDate.add(value);
    }
  }

  void saveAsDraft() async {
    isLoader(true);
    Map dataObj = {
      "starts_on": formatter.format(startDate),
      "occurance": orderOccurance.value,
      "ends_on": orderEndsOn.value,
      "delivery_slot": orderTimeSlot.value,
      "delivery_address": data.deliveryAddress!.id.toString()
    };
    if (orderOccurance.value == "Custom") {
      dataObj['repeats_count'] = repeatsCount.text;
      dataObj['repeats_every'] = defaultCustomOccurance.value;
      if (defaultCustomOccurance.value == "Weeks") {
        dataObj['weekly_repeats_on'] = selectedWeekDays;
      } else if (defaultCustomOccurance.value == "Months") {
        dataObj['monthly_repeats_on'] = selectedMonthDate;
      }
    }
    if (orderEndsOn.value == "On") {
      dataObj['ends_on_date'] = formatter.format(endsOnDate!);
    } else if (orderEndsOn.value == "After") {
      dataObj['ends_on_count'] = endsOnCount.text;
    }
    var response = await Services.createSubscriptionPlan(uuid, dataObj);
    if (response != null) {
      Navigator.pushNamed(Get.context!, '/my-subscription');
    }
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
