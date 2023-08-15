import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../../screens/auth/signUpScreen.dart';
import '../Guest limitation pages/login_limitation.dart';

class GuestManuPage extends StatefulWidget {
  String title;
  int pageIndex;
  GuestManuPage({super.key, required this.title, required this.pageIndex});

  @override
  State<GuestManuPage> createState() => _GuestManuPageState();
}

class _GuestManuPageState extends State<GuestManuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: Stack(
        children: [
          _buildBodyView(),
          widget.title.isEmpty
              ? Container()
              : BackArrow(
                  alignment: Alignment.centerLeft,
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
          CustomAppbar(
            title: widget.title,
            isManuColor: 'check',
            onPressad: () {},
            onPressadForNotify: () {
              PageNavigateScreen().push(context, LoginLimitationPage());
            },
          ),
          widget.pageIndex == 0
              ? Container()
              : NewCustomBottomBar(
                  index: widget.pageIndex,
                  isBack: 'Guest',
                  isManuIcon: 'icon',
                ),
        ],
      ),
    );
  }

  Widget _buildBodyView() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.getSize15(context: context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['log_in']!,
              onPressad: () {
                Get.offAll(() => LoginScreen(), binding: LoginBinding());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['sign_up']!,
              onPressad: () {
                Get.to(() => SignUpScreen(), binding: SignUpBinding());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['tutorial']!,
              onPressad: () {
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['faq']!,
              onPressad: () {
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['advrise']!,
              onPressad: () {
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['buy_pitch']!,
              onPressad: () {
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['contact']!,
              onPressad: () {
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
        ],
      ),
    );
  }
}
