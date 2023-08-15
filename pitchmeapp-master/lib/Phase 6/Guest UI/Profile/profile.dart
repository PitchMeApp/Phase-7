import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class GuestProfilePage extends StatefulWidget {
  const GuestProfilePage({super.key});

  @override
  State<GuestProfilePage> createState() => _GuestProfilePageState();
}

class _GuestProfilePageState extends State<GuestProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomListBox(
                    icon: 'assets/images/ic_account_circle_24px@4x.png',
                    title: TextStrings.textKey['biography']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_favorite_24px@4x.png',
                    title: TextStrings.textKey['likes']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_toc_24px@4x.png',
                    title: TextStrings.textKey['pitches']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
              ],
            ),
          ),
          CustomAppbar(
            title: TextStrings.textKey['profile']!,
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  GuestManuPage(
                    title: TextStrings.textKey['profile']!,
                    pageIndex: 4,
                  ));
            },
            onPressadForNotify: () {
              PageNavigateScreen().push(context, LoginLimitationPage());
            },
          ),
        ],
      ),
    );
  }
}
