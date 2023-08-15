import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class GuestDealsPage extends StatefulWidget {
  const GuestDealsPage({super.key});

  @override
  State<GuestDealsPage> createState() => _GuestDealsPageState();
}

class _GuestDealsPageState extends State<GuestDealsPage> {
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
                // CustomAppbar(title: TextStrings.textKey['deals']!),
                CustomListBox(
                    icon: 'assets/images/ic_message_24px@4x.png',
                    title: TextStrings.textKey['chat']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_import_contacts_24px@4x.png',
                    title: TextStrings.textKey['contract']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_local_atm_24-mdpi (1).png',
                    title: TextStrings.textKey['investment']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/pie-chart.png',
                    title: TextStrings.textKey['share']!,
                    imageHight: 40.0,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_compare_arrows_24px@4x.png',
                    title: TextStrings.textKey['update']!,
                    onPressad: () {
                      PageNavigateScreen().push(context, LoginLimitationPage());
                    }),
              ],
            ),
          ),
          CustomAppbar(
            title: TextStrings.textKey['deals']!,
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  GuestManuPage(
                    title: TextStrings.textKey['deals']!,
                    pageIndex: 3,
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
