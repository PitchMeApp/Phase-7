// dev

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pitch_me_app/View/Profile/Biography/model/model.dart';
import 'package:pitch_me_app/View/Profile/Likes/model.dart';
import 'package:pitch_me_app/View/Profile/Pitches/model.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/industry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetApiService {
  Future<IndustryModel> getIndusrtyApi() async {
    String url = '${BASE_URL}industry';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    IndustryModel data = industryModelFromJson(response.body.toString());

    return data;
  }

  Future<IndustryModel> getServiceApi() async {
    String url = '${BASE_URL}services';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    IndustryModel data = industryModelFromJson(response.body.toString());

    return data;
  }

  Future<SalesPitchListModel> getSalesPiitchListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}salespitch?userid=${prefs.get('user_id')}';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    //log(jsonDecode(response.body).toString());
    SalesPitchListModel data = salesPitchListModelFromJson(response.body);

    return data;
  }

  Future<SavedListModel> getsavedVideoApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getsaved';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
        });
    // log(jsonDecode(response.body).toString());
    SavedListModel data = savedListModelFromJson(response.body);

    return data;
  }

  Future<SavedListModel> getsavedOwnerPitchesApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getownerpitches';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
        });
    //  log(jsonDecode(response.body).toString());
    SavedListModel data = savedListModelFromJson(response.body);

    return data;
  }

  Future<SavedLikeListModel> getsavedLikeVideoApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getsavedpost';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(
            {"senderid": prefs.get('user_id').toString(), "types": 1}),
        headers: {
          'Content-Type': 'application/json',
        });

    SavedLikeListModel data = savedLikeListModelFromJson(response.body);

    return data;
  }

  Future<BiogaphyModel> getUserBioGraphyApi(userId) async {
    String url = '${BASE_URL}biography?userid=$userId';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    // log(jsonDecode(response.body).toString());
    BiogaphyModel data = biogaphyModelFromJson(response.body);

    return data;
  }

  Future getUserDetailApi(id) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/user/$id';
    // log(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    //SavedListModel data = savedListModelFromJson(response.body);
    dynamic data = jsonDecode(response.body);
    // log('userdata = ' + data.toString());
    return data;
  }

  // DELETE

  Future deleteSalesPittchApi(id) async {
    String url = '${BASE_URL}salespitch/$id';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future deleteLikeVideoApi(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/post/$id/${prefs.get('user_id')}';
    // log(url);
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    //log(response.body);
    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future deleteSavedVideoApi(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/pitch/$id/${prefs.get('user_id')}';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  // put
  Future readNotificationApi(id) async {
    String url = '${BASE_URL}notification/read/$id';

    final response = await http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future readAllNotificationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}notification/readall/${prefs.get('user_id')}';

    final response = await http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }
}
