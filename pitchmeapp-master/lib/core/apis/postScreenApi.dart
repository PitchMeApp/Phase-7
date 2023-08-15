import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/models/statisticsModel/statisticsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessIdeasApi extends GetConnect {
  Future<PostModel?> getPost(filter) async {
    String category = filter
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var res;

      var userID = prefs.getString('user_id').toString();
      if (userID.isNotEmpty && userID != 'null') {
        //res = await get('${BASE_URL}salespitch?type=2');
        res = await get('$GET_POST_DATA_URL?user=$userID&category=$category');

        //res = await get(GET_POST_DATA_URL);
      } else {
        res = await get(GET_POST_DATA_URL);
      }

      // log("Res is at getPost ${'$GET_POST_DATA_URL?user=$userID&category=$category'}");
      if (res.statusCode == 200) {
        return PostModel.fromJson(res.body);
      }
    } catch (e) {
      log('error = ' + e.toString());
      return null;
    }

    return null;
  }

  Future<SalesPitchListModel?> getPost2(int pageCount) async {
    //&user=6446703bc5ede4e5e1838933
    var res;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString('user_id').toString();
    var bussinessType = prefs.getString('log_type').toString();
    if (userID.isNotEmpty && userID != 'null') {
      //res = await get('${BASE_URL}salespitch?type=2');

      res = await get(
          '${BASE_URL}salespitch?type=2&user=$userID&usertype=$bussinessType');
    } else {
      res = await get('${BASE_URL}salespitch?type=2');
    }

    // log("Res is at getPost ${'${BASE_URL}salespitch?type=2&user=$userID&usertype=$bussinessType'}");
    if (res.statusCode == 200) {
      return SalesPitchListModel.fromJson(res.body);
    }
    return null;
  }

  Future<StatisticsModel?> getStatistics() async {
    var res = await get(GET_STASTICS_URL);
    //log("Res is at getStatistics ${res.body}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      return StatisticsModel.fromJson(res.body);
    }
    return null;
  }
}
