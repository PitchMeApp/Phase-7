import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Likes/model.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';

class LikesController extends GetxController {
  RxBool isLoading = false.obs;
  late SavedLikeListModel savedLikeListModel;

  Future<SavedLikeListModel> getSavedLikeListApi() async {
    isLoading.value = true;
    try {
      await GetApiService().getsavedLikeVideoApi().then((value) {
        savedLikeListModel = value;
        isLoading.value = false;
      });
    } catch (e) {
      savedLikeListModel.result = [];
      isLoading.value = false;
    }
    return savedLikeListModel;
  }

  void deleteApiCall(id, context) async {
    isLoading.value = true;

    try {
      await GetApiService().deleteLikeVideoApi(id).then((value) {
        if (value['message'] != "Not Found") {
          Fluttertoast.showToast(
              msg: value['message'], gravity: ToastGravity.CENTER);

          Navigator.of(context).pop();
        }
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
