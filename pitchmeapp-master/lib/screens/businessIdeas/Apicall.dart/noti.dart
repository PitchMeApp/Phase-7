import 'package:flutter/cupertino.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/api_Integration.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/notification_Model.dart';

class DataClass extends ChangeNotifier {
  notification? post;
  int totalNotiCount = 0;
  bool loading = false;

  getPostData() async {
    loading = false;
    post = (await getSinglePostData())!;
    totalNotiCount = post!.unreadNotification!;
    loading = false;

    notifyListeners();
  }
}
