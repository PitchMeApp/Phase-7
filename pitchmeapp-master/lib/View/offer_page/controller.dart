import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPageController extends GetxController {
  TextEditingController offrerTextController = TextEditingController();

  RxString selectedPerson = ''.obs;
  RxInt checkColor = 0.obs;

  List data = [
    {'value': 'Anyone', 'isSelected': false},
    {'value': 'Only Verified ID', 'isSelected': false},
    {'value': 'Only Verified Funds', 'isSelected': false},
    {'value': 'Only Verified Experience', 'isSelected': false},
    {'value': 'Only with NDA', 'isSelected': false},
  ];

  RxList selectedPersonType = RxList([].obs);

  onselectValue(value) {
    for (var i = 0; i < data.length; i++) {
      if (value == i) {
        // log(data[i].toString());
        if (data[i]['isSelected'] != true) {
          selectedPersonType.value.add(data[i]);
          data[i]['isSelected'] = true;

          update();
        } else {
          data[i]['isSelected'] = false;
          selectedPersonType.value.remove(data[i]);
          selectedPerson.value = '';

          update();
        }
      }
      // log(selectedPersonType.value.toString());
    }
    update();
  }
}
