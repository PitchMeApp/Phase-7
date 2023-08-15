import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/under_progress_limitation.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class ManuPage extends StatefulWidget {
  String title;
  int pageIndex;
  dynamic isManu;
  ManuPage(
      {super.key, required this.title, required this.pageIndex, this.isManu});

  @override
  State<ManuPage> createState() => _ManuPageState();
}

class _ManuPageState extends State<ManuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: Stack(
        children: [
          _buildBodyView(),
          BackArrow(
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
            onPressadForNotify: () {},
          ),
          NewCustomBottomBar(
            index: widget.pageIndex,
            isBack: widget.isManu,
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
              title: TextStrings.textKey['tutorial']!,
              onPressad: () {
                PageNavigateScreen().push(context, UnderDevLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['faq']!,
              onPressad: () {
                PageNavigateScreen().push(context, UnderDevLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['advrise']!,
              onPressad: () {
                PageNavigateScreen().push(context, UnderDevLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['buy_pitch']!,
              onPressad: () {
                PageNavigateScreen().push(context, UnderDevLimitationPage());
              }),
          CustomListBox(
              icon: '',
              title: TextStrings.textKey['contact']!,
              onPressad: () {
                PageNavigateScreen().push(context, ChatListPage());
              }),
        ],
      ),
    );
  }
}
