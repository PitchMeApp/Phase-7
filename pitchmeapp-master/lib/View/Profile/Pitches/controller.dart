import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Pitches/model.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PitcheController extends GetxController {
  RxBool isLoading = false.obs;
  late SavedListModel savedListModel;
  String userType = '';

  Future<SavedListModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.get('log_type').toString();

    if (userType == '1') {
      return getSavedOwnerPitchesListApi();
    } else if (userType == '2') {
      return getSavedOwnerPitchesListApi();
    } else if (userType == '3') {
      return getSavedVideoListApi();
    } else {
      return getSavedVideoListApi();
    }
  }

  deleteData(id, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.get('log_type').toString();

    if (userType == '1') {
      return deleteApiCall(id, context);
    } else if (userType == '2') {
      return deleteApiCall(id, context);
    } else if (userType == '3') {
      return deleteSavedVideoApiCall(id, context);
    } else {
      return deleteApiCall(id, context);
    }
  }

  Future<SavedListModel> getSavedVideoListApi() async {
    isLoading.value = true;
    try {
      await GetApiService().getsavedVideoApi().then((value) {
        savedListModel = value;
        isLoading.value = false;
      });
    } catch (e) {
      savedListModel.result = [];
      isLoading.value = false;
    }
    return savedListModel;
  }

  Future<SavedListModel> getSavedOwnerPitchesListApi() async {
    isLoading.value = true;
    try {
      await GetApiService().getsavedOwnerPitchesApi().then((value) {
        savedListModel = value;
        isLoading.value = false;
      });
    } catch (e) {
      savedListModel.result = [];
      isLoading.value = false;
    }
    return savedListModel;
  }

  void deleteApiCall(id, context) async {
    isLoading.value = true;

    try {
      await GetApiService().deleteSalesPittchApi(id).then((value) {
        if (value != null) {
          Fluttertoast.showToast(
              msg: 'Deleted successfully', gravity: ToastGravity.CENTER);

          Navigator.of(context).pop();
        }
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void deleteSavedVideoApiCall(id, context) async {
    isLoading.value = true;

    try {
      await GetApiService().deleteSavedVideoApi(id).then((value) {
        if (value != null) {
          Fluttertoast.showToast(
              msg: 'Deleted successfully', gravity: ToastGravity.CENTER);

          Navigator.of(context).pop();
        }
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
