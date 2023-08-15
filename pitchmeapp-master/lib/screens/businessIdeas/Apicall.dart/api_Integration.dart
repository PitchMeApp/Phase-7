import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/notification_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<notification?> getSinglePostData() async {
  notification? result;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await http.get(
      Uri.parse(
          "${BASE_URL}notification/getlimited?id=${prefs.get('user_id')}"),

      // headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      // },
    );
    // log('${BASE_URL}notification/getlimited?id=${prefs.get('user_id')}');
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      //log('noti =' + item.toString());

      result = notification.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    print("jkufkufrtkufrt ${e.toString()}");
  }
  return result;
}
