import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/under_progress_limitation.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import 'home biography/Chat/chat_list.dart';

class HomeManuPage extends StatefulWidget {
  HomeManuPage({super.key});

  @override
  State<HomeManuPage> createState() => _HomeManuPageState();
}

class _HomeManuPageState extends State<HomeManuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: DynamicColor.white,
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Column(
            children: [
              CustomListBox(
                  icon: '',
                  title: TextStrings.textKey['tutorial']!,
                  onPressad: () {
                    PageNavigateScreen()
                        .push(context, UnderDevLimitationPage());
                  }),
              CustomListBox(
                  icon: '',
                  title: TextStrings.textKey['faq']!,
                  onPressad: () {
                    PageNavigateScreen()
                        .push(context, UnderDevLimitationPage());
                  }),
              CustomListBox(
                  icon: '',
                  title: TextStrings.textKey['advrise']!,
                  onPressad: () {
                    PageNavigateScreen()
                        .push(context, UnderDevLimitationPage());
                  }),
              CustomListBox(
                  icon: '',
                  title: TextStrings.textKey['buy_pitch']!,
                  onPressad: () {
                    PageNavigateScreen()
                        .push(context, UnderDevLimitationPage());
                  }),
              CustomListBox(
                  icon: '',
                  title: TextStrings.textKey['contact']!,
                  onPressad: () {
                    PageNavigateScreen().push(context, ChatListPage());
                  }),
            ],
          )
        ],
      ),
    );
  }
}
