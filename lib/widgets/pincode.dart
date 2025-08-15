import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/widgets/custom.dart';
import 'package:frugivore/models/pincode.dart';
import 'package:frugivore/controllers/pincode.dart';

class PinCodeContainer extends StatefulWidget {
  const PinCodeContainer({super.key});
  @override
  PinCodeContainerState createState() => PinCodeContainerState();
}

class PinCodeContainerState extends State<PinCodeContainer> {
  final PinCodeController controller = Get.put(PinCodeController());
  final GlobalKey<AutoCompleteTextFieldState<PinCodeSearchModel>> key = GlobalKey<AutoCompleteTextFieldState<PinCodeSearchModel>>();
  @override
  Widget build(BuildContext context) {
    
    return Container(
        margin: EdgeInsets.only(left: 5),
        decoration: shapeDecoration,
        child: Padding(
          padding: p10,
          child: AutoCompleteTextField<PinCodeSearchModel>(
            key: key,
            keyboardType: TextInputType.number,
            controller: PinCodeController.pinCodeController,
            focusNode: PinCodeController.pinCodeFocus,
            suggestions: controller.suggestions,
            style: TextStyle(fontSize: 12),
            textChanged: (text) => controller.changeType(text),
            itemSubmitted: (item) => controller.itemSubmitted(item),
            suggestionsAmount: 6,
            submitOnSuggestionTap: true,
            clearOnSubmit: false,
            itemSorter: (a, b) => -1,
            itemFilter: (suggestion, input) =>
                suggestion.pincode!.startsWith(input),
            itemBuilder: (context, suggestion) => Container(
                padding: plr15,
                decoration: boxDecorationBottomBorder,
                child: ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(suggestion.pincode!),
                )),
            decoration:
                InputDecoration.collapsed(hintText: "Type pincode to check"),
          ),
        ));
  }
}

class CitiesDropDown extends StatelessWidget {
  final PinCodeController controller = Get.put(PinCodeController());

  CitiesDropDown({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        decoration: shapeDecoration,
        child: Obx(() => Padding(
              padding: plr10,
              child: DropdownButton(
                  value: PinCodeController.defaultCities.value,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  underline: Container(height: 0),
                  iconSize: 30,
                  items: globals.cities.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 12.0)),
                    );
                  }).toList(),
                  onChanged: (val) => PinCodeController.changeCities(val)),
            )));
  }
}
