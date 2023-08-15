import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pitch_me_app/core/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostApiServer {
  Future savedLikeVideoApi(postID, swipeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/addpost';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "userid": prefs.get('user_id').toString(),
            "postid": postID.toString(),
            "types": swipeType,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      dynamic data = jsonDecode(response.body);
      // log(url);
      // log('check = ' + data.toString());
      return data;
    } catch (e) {}
  }

  Future savedVideoApi(pitchID, receiverid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/addsaved';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "senderid": prefs.get('user_id').toString(),
            "receiverid": (receiverid == null)
                ? prefs.get('user_id').toString()
                : receiverid,
            "pitchid": pitchID.toString(),
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      dynamic data = jsonDecode(response.body);

      Fluttertoast.showToast(
          msg: 'Add Successfully', gravity: ToastGravity.CENTER);
      return data;
    } catch (e) {}
  }

  Future getChatDetailApi(receiverid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getchats';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
          "recieverid": receiverid,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    dynamic data = jsonDecode(response.body);

    return data;
  }
  // Future getSavedIntroVideoApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String url = '${BASE_URL}feedback/getintro';
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         body: jsonEncode({
  //           "senderid": prefs.get('user_id').toString(),
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         });
  //     dynamic data = jsonDecode(response.body);

  //     return data;
  //   } catch (e) {}
  // }

  // Future addSavedIntroVideoApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String url = '${BASE_URL}feedback/addsavedintro';
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         body: jsonEncode({
  //           "senderid": prefs.get('user_id').toString(),
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         });
  //     dynamic data = jsonDecode(response.body);
  //     log('add saved = ' + data.toString());

  //     return data;
  //   } catch (e) {}
  // }
}
