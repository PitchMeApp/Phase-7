import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/under_progress_limitation.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
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
                      PageNavigateScreen().push(context, ChatListPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_import_contacts_24px@4x.png',
                    title: TextStrings.textKey['contract']!,
                    onPressad: () {
                      PageNavigateScreen()
                          .push(context, UnderDevLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_local_atm_24-mdpi (1).png',
                    title: TextStrings.textKey['investment']!,
                    onPressad: () {
                      PageNavigateScreen()
                          .push(context, UnderDevLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/pie-chart.png',
                    title: TextStrings.textKey['share']!,
                    imageHight: 40.0,
                    onPressad: () {
                      PageNavigateScreen()
                          .push(context, UnderDevLimitationPage());
                    }),
                CustomListBox(
                    icon: 'assets/images/ic_compare_arrows_24px@4x.png',
                    title: TextStrings.textKey['update']!,
                    onPressad: () {
                      PageNavigateScreen()
                          .push(context, UnderDevLimitationPage());
                    }),
              ],
            ),
          ),
          CustomAppbar(
            title: TextStrings.textKey['deals']!,
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: TextStrings.textKey['deals']!,
                    pageIndex: 3,
                    isManu: 'Manu',
                  ));
            },
            onPressadForNotify: () {},
          ),
        ],
      ),
    );
  }
}

class CustomListBox extends StatefulWidget {
  String icon;
  String title;
  bool? titleColor;
  VoidCallback onPressad;
  dynamic imageHight;
  CustomListBox({
    super.key,
    required this.icon,
    required this.title,
    this.titleColor,
    required this.onPressad,
    this.imageHight,
  });

  @override
  State<CustomListBox> createState() => _CustomListBoxState();
}

class _CustomListBoxState extends State<CustomListBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressad,
      child: Container(
        height: 5.h,
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.only(
            bottom: 15,
            left: SizeConfig.getFontSize25(context: context),
            right: SizeConfig.getFontSize25(context: context)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: DynamicColor.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.icon.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      widget.icon,
                      height:
                          (widget.imageHight == null) ? 25 : widget.imageHight,
                    ),
                  ),
                  Text(
                    widget.title.toUpperCase(),
                    style: white17wBold,
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              )
            : Center(
                child: Text(
                  widget.title.toUpperCase(),
                  style: widget.titleColor != null
                      ? widget.titleColor == true
                          ? darkBlue19
                          : white17wBold
                      : white17wBold,
                ),
              ),
      ),
    );
  }
}
