import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Need%20page/need_page.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Fund Page/funds_page.dart';

class WhatNeedPage extends StatefulWidget {
  const WhatNeedPage({super.key});

  @override
  State<WhatNeedPage> createState() => _WhatNeedPageState();
}

class _WhatNeedPageState extends State<WhatNeedPage> {
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize55(context: context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: SizeConfig.getFontSize25(context: context),
                      right: SizeConfig.getFontSize25(context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: customBox(
                        10.0,
                        10.0,
                        0.0,
                        0.0,
                        _whoNeedController.data[0]['icon'],
                        _whoNeedController.data[0]['value'],
                        _whoNeedController.data[0]['isSelected'],
                        onPressad: () {
                          setState(() {});
                          _whoNeedController
                              .onselectItem(_whoNeedController.data[0]);
                        },
                      )),
                      Container(
                        width: 2,
                        height: 6.h,
                        color: DynamicColor.white,
                      ),
                      Expanded(
                          child: customBox(
                        0.0,
                        0.0,
                        10.0,
                        10.0,
                        _whoNeedController.data[1]['icon'],
                        _whoNeedController.data[1]['value'],
                        _whoNeedController.data[1]['isSelected'],
                        onPressad: () {
                          setState(() {
                            _whoNeedController
                                .onselectItem(_whoNeedController.data[1]);
                          });
                        },
                      )),
                    ],
                  ),
                ),
                _whoNeedController.isSelectedItem.value.isNotEmpty
                    ? _footerHint()
                    : Container()
              ],
            ),
          ),
          CustomHeaderView(
            title: TextStrings.textKey['what_need']!,
            icon: 'assets/icons/people.png',
            subTitle: 'Select 1 or Both options',
            progressPersent: 0.3,
            padding: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackArrow(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios),
              _whoNeedController.isSelectedItem.value.isNotEmpty
                  ? BackArrow(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        try {
                          if (_navigationController.navigationType.value ==
                              'Post') {
                            if (_whoNeedController.checkColor == 1) {
                              PageNavigateScreen().push(
                                  context,
                                  FundsPage(
                                    key: abcKey,
                                  ));
                            } else if (_whoNeedController.checkColor2 == 2) {
                              PageNavigateScreen().push(
                                  context,
                                  NeedPage(
                                    key: abcKey,
                                  ));
                            } else {
                              PageNavigateScreen().push(
                                  context,
                                  FundsPage(
                                    key: abcKey,
                                  ));
                            }
                          } else {
                            Navigator.of(context).pop();
                          }
                        } catch (e) {}
                      },
                      icon: Icons.arrow_forward_ios)
                  : Container(),
            ],
          ),
          NewCustomBottomBar(
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _footerHint() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context), right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextStrings.textKey['sub_what_need']!,
            style: blue15,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            TextStrings.textKey['sub_what_need2']!,
            style: blue15,
          ),
        ],
      ),
    );
  }

  Widget customBox(topLeft, bottomLeft, topRight, bottomRight,
      IconData iconData, String string, isCheck,
      {required VoidCallback onPressad}) {
    return GestureDetector(
      onTap: onPressad,
      child: Container(
        height: 5.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: DynamicColor.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              bottomLeft: Radius.circular(bottomLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: isCheck ? DynamicColor.darkBlue : DynamicColor.white,
            ),
            Text(
              string,
              style: isCheck ? darkBlue15 : white15TextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
