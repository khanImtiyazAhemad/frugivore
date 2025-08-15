import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/services/subscription/editSubscriptionPlan.dart';
import 'package:frugivore/models/subscription/editSubscriptionPlan.dart';

class EditSubscriptionPlanController extends GetxController {
  var isLoader = true.obs;
  String? uuid;

  var orderOccurance = "Daily".obs;
  var orderEndsOn = "Never".obs;
  var orderTimeSlot = "".obs;
  var defaultCustomOccurance = "Days".obs;
  RxList selectedWeekDays = [].obs;
  RxList selectedMonthDate = [].obs;
  DateTime? startDate;
  DateTime? endsOnDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController repeatsCount = TextEditingController();
  final TextEditingController endsOnCount = TextEditingController();

  final _data = EditSubscriptionPlanModel().obs;
  EditSubscriptionPlanModel get data => _data.value;
  set data(value) => _data.value = value;

  void apicall(uuid) async {
    try {
      isLoader(true);
      var response = await Services.fetchDetail(uuid);
      if(response!.error != null){

      }else {
        _data.value = response;
        defaultCustomOccurance(response.subscription!.repeatsEvery);
        repeatsCount.text = response.subscription!.repeatsCount != null
            ? response.subscription!.repeatsCount.toString()
            : "1";
        orderOccurance(response.subscription!.occurance);
        if (response.subscription!.endsOn != null) {
          orderEndsOn(response.subscription!.endsOn);
        }
        if (response.subscription!.startsOn != null) {
          startDate = response.subscription!.startsOn;
        }
        if (response.subscription!.endsOnDate != null) {
          endsOnDate = response.subscription!.endsOnDate;
        }
        orderTimeSlot(response.subscription!.deliverySlotId.toString());
        if (response.subscription!.weeklyRepeatsOn != null){
          selectedWeekDays.assignAll(response.subscription!.weeklyRepeatsOn!);
        }
        if (response.subscription!.monthlyRepeatsOn != null) {
          selectedMonthDate.assignAll(response.subscription!.monthlyRepeatsOn!);
        }
        if (response.subscription!.endsOnCount != null) {
          endsOnCount.text = response.subscription!.endsOnCount.toString();
        }
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

  void updateSubscriptionPlan() {
    isLoader(true);
    Map dataObj = {
      "occurance": orderOccurance.value,
      "ends_on": orderEndsOn.value,
      "delivery_slot": orderTimeSlot.value,
    };
    if (data.subscription!.deliveryAddress != null) {
      dataObj["delivery_address"] =
          data.subscription!.deliveryAddress.toString();
    }
    if (orderOccurance.value == "Custom") {
      dataObj['repeats_count'] = repeatsCount.text;
      dataObj['repeats_every'] = defaultCustomOccurance.value;
      if (defaultCustomOccurance.value == "Weeks") {
        dataObj['weekly_repeats_on'] = selectedWeekDays.join(",");
      } else if (defaultCustomOccurance.value == "Months") {
        dataObj['monthly_repeats_on'] = selectedMonthDate.join(",");
      }
    }
    if (orderEndsOn.value == "On") {
      dataObj['ends_on_date'] = formatter.format(endsOnDate!);
    } else if (orderEndsOn.value == "After") {
      dataObj['ends_on_count'] = endsOnCount.text;
    }
    Services.updateSubscriptionPlan(uuid, dataObj).then((response) {
      Navigator.pushNamed(Get.context!, '/my-subscription');
    }).catchError((onError) {
      globals.toast(onError.toString());
    });
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
