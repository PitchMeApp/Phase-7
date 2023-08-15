import 'package:get/get.dart';
import 'package:pitch_me_app/core/apis/authApis.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionController extends GetxController {
  bool selectedIndexPage = false;
  AuthApis authApis = AuthApis();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  submit(int type) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    Get.dialog(Loading());
    bool? result = await authApis.setUserType(type: type);
    Get.back();
    if (result != null) {
      preferencesData.setString('log_type', type.toString());
      preferencesData.setString("guest", 'Guest');
      preferencesData.setString('count_swipe', '0');
      preferencesData.setString('new_user', 'New User');
      Get.offAll(() => Floatbar(0));
    }
  }
}

class SelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectionController>(
      () => SelectionController(),
    );
  }
}
