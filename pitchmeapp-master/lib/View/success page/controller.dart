import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pitch_me_app/View/Add%20Image%20Page/controller.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Location%20Page/location_page_con.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_controller.dart';
import 'package:pitch_me_app/View/Select%20industry/industry_controller.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/View/selected_data_view/selected_controller.dart';
import 'package:pitch_me_app/View/success%20page/success_page.dart';
import 'package:pitch_me_app/View/video%20page/Controller/controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPageController extends GetxController {
  SelectedController controller = Get.put(SelectedController());
  final InsdustryController insdustryController =
      Get.put(InsdustryController());
  final LocationPageController _locationPageController =
      Get.put(LocationPageController());
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  final FundNacessaryController _fundNacessaryController =
      Get.put(FundNacessaryController());
  final NeedPageController _needPageController = Get.put(NeedPageController());
  final OfferPageController _offerPageController =
      Get.put(OfferPageController());
  final AddImageController _addImageController = Get.put(AddImageController());
  final VideoFirstPageController _videoFirstPageController =
      Get.put(VideoFirstPageController());

  List serviceList = [];
  List serviceDetaisList = [];
  List typeList = [];
  List whoCanWatchList = [];

  RxBool isLoading = false.obs;

  String userID = '';

  Future postSalesPitch(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.get('user_id').toString();
    serviceList.clear();
    typeList.clear();
    serviceDetaisList.clear();
    whoCanWatchList.clear();
    isLoading.value = true;
    for (var element in _needPageController.selectedNeedType.value) {
      serviceList.add(element['value']);
    }
    if (_needPageController.searchingSelectedItems.value.isNotEmpty) {
      for (var element in _needPageController.searchingSelectedItems.value) {
        serviceDetaisList.add(element);
      }
    }

    // for (var element in _whoNeedController.isSelectedItem.value) {
    //   typeList.add(element['value']);
    // }
    for (var element in _offerPageController.selectedPersonType.value) {
      whoCanWatchList.add(element['value']);
    }
    try {
      String url = '${BASE_URL}salespitch';
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        'userid': userID,
        'type': _whoNeedController.isSelectedItem.value.toString(),
        'title': _videoFirstPageController.editingController.text,
        'industry': insdustryController.selectedIndustry.value,
        'location': _locationPageController.selectedType.value == 'Place'
            ? _locationPageController.searchController.text
            : _locationPageController.selectedType.value,
        'valueamount': _fundNacessaryController.selectedValue.value,
        'services': serviceList.toString(),
        'servicesDetail': serviceDetaisList.toString(),
        'description': _offerPageController.offrerTextController.text,
        'status': 1.toString(),
        'whocanwatch': whoCanWatchList.toString(),
      });
      // log(request.fields.toString());
      request.files.add(await http.MultipartFile.fromPath(
          'vid1', _videoFirstPageController.videoUrl.value.toString(),
          filename: _videoFirstPageController.videoUrl.value.split('/').last));
      request.files.add(await http.MultipartFile.fromPath(
        'img1',
        _addImageController.listImagePaths[0],
        filename:
            _addImageController.listImagePaths[0].toString().split('/').last,
      ));
      if (_addImageController.listImagePaths.length > 1) {
        request.files.add(await http.MultipartFile.fromPath(
          'img2',
          _addImageController.listImagePaths[1],
          filename:
              _addImageController.listImagePaths[1].toString().split('/').last,
        ));
      }
      if (_addImageController.listImagePaths.length > 2) {
        request.files.add(await http.MultipartFile.fromPath(
          'img3',
          _addImageController.listImagePaths[2],
          filename:
              _addImageController.listImagePaths[2].toString().split('/').last,
        ));
      }
      if (_addImageController.listImagePaths.length > 3) {
        request.files.add(await http.MultipartFile.fromPath(
          'img4',
          _addImageController.listImagePaths[3],
          filename:
              _addImageController.listImagePaths[3].toString().split('/').last,
        ));
      }
      if (_addImageController.filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          _addImageController.fileFullPath.path,
          filename: 'file.pdf',
        ));
      }

      var res = await request.send();
      var response = await res.stream.bytesToString();
      isLoading.value = false;
      var jsonData = jsonDecode(response);

      if (res.statusCode == 201) {
        Get.delete<InsdustryController>(force: true);
        Get.delete<LocationPageController>(force: true);
        Get.delete<WhoNeedController>(force: true);
        Get.delete<FundNacessaryController>(force: true);
        Get.delete<NeedPageController>(force: true);
        Get.delete<OfferPageController>(force: true);
        Get.delete<AddImageController>(force: true);
        Get.delete<VideoFirstPageController>(force: true);
        Get.delete<NavigationController>(force: true);

        Fluttertoast.showToast(
            msg: jsonData['message'], gravity: ToastGravity.CENTER);
        PageNavigateScreen().pushRemovUntil(context, SuccessPage());
      } else {
        Fluttertoast.showToast(
            msg: jsonData['message'], gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      isLoading.value = false;
      // log('error = ' + _addImageController.fileFullPath.path.toString());
    }
  }
}
