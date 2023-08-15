import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/View/Feedback/feedback_detail.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/noti.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Profile/Biography/biography.dart';
import '../Profile/Pitches/pitches_list.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  VoidCallback onPressad;
  VoidCallback onPressadForNotify;
  dynamic isManuColor;
  dynamic colorTween;
  CustomAppbar({
    super.key,
    required this.title,
    required this.onPressad,
    required this.onPressadForNotify,
    this.isManuColor,
    this.colorTween,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  Timer timer = Timer(Duration(seconds: 0), () {});
  bool _isInitialValue = false;

  String checkGuestType = '';
  @override
  void initState() {
    //Colors.white.withOpacity(0.3)
    checkGuest();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    if (widget.colorTween != null) {
      _colorTween =
          ColorTween(begin: DynamicColor.white, end: DynamicColor.white)
              .animate(_animationController);
    } else {
      _colorTween = ColorTween(begin: DynamicColor.blue, end: DynamicColor.blue)
          .animate(_animationController);
    }

    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      final postModel = Provider.of<DataClass>(context, listen: false);
      postModel.getPostData();
    });
    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.getSize30(context: context) +
                    MediaQuery.of(context).size.height * 0.021,
                left: SizeConfig.getFontSize25(context: context),
                right: SizeConfig.getFontSize25(context: context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.getSize50(context: context),
                  width: SizeConfig.getSize50(context: context),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  // decoration: widget.title != 'Profile'
                  //     ? BoxDecoration(
                  //         color: DynamicColor.blue,
                  //         borderRadius: BorderRadius.circular(8.0))
                  //     : null,
                  child: Text(
                    widget.title,
                    style: widget.colorTween == 'BIOGRAPHY'
                        ? white17wBold
                        : blue16bold,
                  ),
                ),
                AppBarIconContainer(
                  onTap: widget.onPressad,
                  height: SizeConfig.getSize50(context: context),
                  width: SizeConfig.getSize50(context: context),
                  colorTween: _colorTween,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: loadSvg(
                        image: 'assets/image/menu.svg',
                        color: widget.colorTween == 'BIOGRAPHY'
                            ? DynamicColor.blue
                            : widget.isManuColor == null
                                ? null
                                : DynamicColor.darkBlue),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.getSize30(context: context) +
                  MediaQuery.of(context).size.height * 0.021,
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context)),
          child: Stack(
            children: [
              AnimatedBuilder(
                  animation: _colorTween,
                  builder: (context, child) {
                    return AnimatedContainer(
                      height: _isInitialValue ? sizeH * 0.5 : sizeH * 0.06,
                      width: _isInitialValue
                          ? sizeW * 0.65
                          : SizeConfig.getSize50(context: context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(_isInitialValue ? 20 : 10),
                        color:
                            //_colorTween.value
                            _isInitialValue
                                ? DynamicColor.blue
                                : _colorTween.value,
                      ),
                      duration: Duration(milliseconds: 300),
                      child: InkWell(
                        onTap: () {
                          if (checkGuestType.isNotEmpty &&
                              checkGuestType != 'null') {
                            setState(() {
                              _isInitialValue = !_isInitialValue;
                            });
                          } else {
                            Get.to(() => LoginLimitationPage());
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: _isInitialValue
                              ? Consumer<DataClass>(builder:
                                  (BuildContext context, value, Widget? child) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: value.post!.result!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return value.loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                print("Click in notification");
                                                setState(() {
                                                  _isInitialValue == true;
                                                  _isInitialValue = false;
                                                });
                                                if (value.post?.result![index]
                                                        .type ==
                                                    5) {
                                                  PageNavigateScreen().push(
                                                      context,
                                                      HomeBiographyPage(
                                                        type: 'Notification',
                                                        notifyID: value
                                                            .post!
                                                            .result![index]
                                                            .sId!,
                                                        userID: value
                                                            .post!
                                                            .result![index]
                                                            .senderID!,
                                                      ));
                                                } else if (value.post
                                                        ?.result![index].type ==
                                                    6) {
                                                  PageNavigateScreen().push(
                                                      context,
                                                      FeedbackPage(
                                                        type: 'home',
                                                        notifyID: value
                                                            .post!
                                                            .result![index]
                                                            .sId!,
                                                        data: value.post!
                                                            .result![index],
                                                      ));
                                                } else if (value.post
                                                        ?.result![index].type ==
                                                    7) {
                                                  PageNavigateScreen().push(
                                                      context,
                                                      PitchesListPage(
                                                          notifyID: value
                                                              .post!
                                                              .result![index]
                                                              .sId!));
                                                } else if (value.post
                                                        ?.result![index].type ==
                                                    8) {
                                                  PageNavigateScreen().push(
                                                      context,
                                                      BiographyPage(
                                                        type: '',
                                                      ));
                                                }
                                              },
                                              child: Container(
                                                height: sizeH * 0.06,
                                                width: sizeW * 0.65,
                                                // color: Colors.red,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(children: [
                                                    Icon(
                                                        Icons
                                                            .notifications_active_outlined,
                                                        color:
                                                            Color(0xff000a5e)),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: sizeW * 0.03,
                                                        //top: sizeH * 0.01
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height:
                                                                sizeH * 0.02,
                                                            width: sizeW * 0.45,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Color
                                                            //     .fromARGB(
                                                            //         255,
                                                            //         39,
                                                            //         221,
                                                            //         23),
                                                            child: Text(
                                                              value
                                                                      .post
                                                                      ?.result?[
                                                                          index]
                                                                      .title
                                                                      .toString() ??
                                                                  "",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   value
                                                          //           .post
                                                          //           ?.result?[
                                                          //               index]
                                                          //           .text!
                                                          //           .toString() ??
                                                          //       "",
                                                          //   overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //   style: TextStyle(
                                                          //       color: Colors
                                                          //           .white,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .bold,
                                                          //       fontSize: 10),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: sizeW * 0.02,
                                            right: sizeW * 0.02),
                                        child: Divider(
                                          height: 2,
                                          color: Color(0xff000a5e),
                                        ),
                                      );
                                    },
                                  );
                                })
                              : loadSvg(
                                  image: 'assets/image/notifications.svg',
                                  color: widget.colorTween == 'BIOGRAPHY'
                                      ? DynamicColor.blue
                                      : null),
                        ),
                      ),
                    );
                  }),
              _isInitialValue == true
                  ? Container()
                  : Consumer<DataClass>(
                      builder: (BuildContext context, value, Widget? child) {
                      return Visibility(
                        visible: value.totalNotiCount == 0 ? false : true,
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(left: 25, bottom: 20),
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: DynamicColor.darkBlue,
                              borderRadius: BorderRadius.circular(50)),
                          child: FittedBox(
                            child: Text(
                              value.totalNotiCount.toString(),
                              style: TextStyle(color: DynamicColor.white),
                            ),
                          ),
                        ),
                      );
                    })
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
