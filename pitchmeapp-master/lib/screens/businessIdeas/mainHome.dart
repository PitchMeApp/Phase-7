import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Feedback/feedback_detail.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/noti.dart';
import 'package:pitch_me_app/screens/businessIdeas/dashBoardScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/screens/businessIdeas/home_filter.dart';
import 'package:pitch_me_app/screens/businessIdeas/home_manu.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Profile/Biography/biography.dart';
import '../../View/Profile/Pitches/pitches_list.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin {
  double boxHeight = 100;
  double boxWidth = 100;

  bool ChangeBotton = false;

  Color _ContainerColor = DynamicColor.blue;
  Color _CoColor = DynamicColor.blue;
  late AnimationController _animationController;
  late Animation _colorTween;

  final _controller = PageController();
  String title = '';
  int currentIndexOfDashboard = 0;
  //int totalNotiCount = 0;
  late Widget currentScreen;

  int selectIndex = 0;

  Timer timer = Timer(Duration(seconds: 0), () {});

  bool colorChnage = false;

  void _expandBox() {
    boxHeight = 300;
    boxWidth = 300;
  }

  @override
  void initState() {
    getUserType();
    // Colors.white.withOpacity(0.3)
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorTween = ColorTween(begin: DynamicColor.blue, end: DynamicColor.blue)
        .animate(_animationController);
    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });
    Future.delayed(Duration(seconds: 4), () {
      //  setState(() {
      selectIndex;
      _ContainerColor = Color.fromARGB(255, 225, 225, 225).withOpacity(0.3);
      //  });
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        final postModel = Provider.of<DataClass>(context, listen: false);
        postModel.getPostData();
      });
    });

    super.initState();
    currentScreen = DashBoardScreen(
      currentPage: (int index) {
        currentIndexOfDashboard = index;
        setState(() {});
      },
      onSwipe: (int index, String _title, bool isFinish) {
        print("index is $index and title is $title");
        title = _title;
        //setState(() {});
      },
    );
    //setState(() {});
  }

  bool _isInitialValue = false;
  bool isFilter = false;
  bool isManu = false;

  String checkGuestType = '';
  int swipeCount = 0;

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    setState(() {
      checkGuestType = prefs.getString('guest').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Material(
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Stack(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      _isInitialValue == true;
                      _isInitialValue = false;
                    });
                  },
                  child: isManu
                      ? checkGuestType.isNotEmpty && checkGuestType != 'null'
                          ? HomeManuPage()
                          : GuestManuPage(title: '', pageIndex: 0)
                      : isFilter
                          ? HomePageFilter()
                          : currentScreen),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.getSize50(context: context)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: isFilter
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: roboto(
                                size:
                                    SizeConfig.getFontSize20(context: context),
                                text: "Filter",
                                fontWeight: FontWeight.w700,
                                color: DynamicColor.blue),
                          )
                        : roboto(
                            size: SizeConfig.getFontSize28(context: context),
                            text: currentIndexOfDashboard == 0
                                ? ''
                                : "App Statistics",
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.getSize30(context: context) +
                        MediaQuery.of(context).size.height * 0.021,
                    bottom: SizeConfig.getSize20(context: context),
                    left: SizeConfig.getFontSize25(context: context),
                    right: SizeConfig.getFontSize25(context: context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentIndexOfDashboard == 0
                        ? Stack(
                            children: [
                              AnimatedBuilder(
                                  animation: _colorTween,
                                  builder: (context, child) {
                                    return AnimatedContainer(
                                      height: _isInitialValue
                                          ? sizeH * 0.5
                                          : sizeH * 0.06,
                                      width: _isInitialValue
                                          ? sizeW * 0.65
                                          : SizeConfig.getSize50(
                                              context: context),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              _isInitialValue ? 20 : 10),
                                          color: _colorTween.value
                                          //  _isInitialValue
                                          //     ? Color(0xff377eb4)
                                          //     : _colorTween.value,
                                          ),
                                      duration: Duration(milliseconds: 300),
                                      child: InkWell(
                                        onTap: () {
                                          if (checkGuestType.isNotEmpty &&
                                              checkGuestType != 'null') {
                                            setState(() {
                                              _isInitialValue =
                                                  !_isInitialValue;
                                            });
                                          } else {
                                            Get.to(() => LoginLimitationPage());
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: _isInitialValue
                                              ? Consumer<DataClass>(builder:
                                                  (BuildContext context, value,
                                                      Widget? child) {
                                                  return ListView.separated(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemCount: value
                                                        .post!.result!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return value.loading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                print(
                                                                    "Click in notification");
                                                                setState(() {
                                                                  _isInitialValue ==
                                                                      true;
                                                                  _isInitialValue =
                                                                      false;
                                                                });
                                                                if (value
                                                                        .post
                                                                        ?.result![
                                                                            index]
                                                                        .type ==
                                                                    5) {
                                                                  PageNavigateScreen().push(
                                                                      context,
                                                                      HomeBiographyPage(
                                                                        type:
                                                                            'Notification',
                                                                        notifyID: value
                                                                            .post!
                                                                            .result![index]
                                                                            .sId!,
                                                                        userID: value
                                                                            .post!
                                                                            .result![index]
                                                                            .senderID!,
                                                                      ));
                                                                } else if (value
                                                                        .post
                                                                        ?.result![
                                                                            index]
                                                                        .type ==
                                                                    6) {
                                                                  PageNavigateScreen().push(
                                                                      context,
                                                                      FeedbackPage(
                                                                        type:
                                                                            'home',
                                                                        notifyID: value
                                                                            .post!
                                                                            .result![index]
                                                                            .sId!,
                                                                        data: value
                                                                            .post!
                                                                            .result![index],
                                                                      ));
                                                                } else if (value
                                                                        .post
                                                                        ?.result![
                                                                            index]
                                                                        .type ==
                                                                    7) {
                                                                  PageNavigateScreen().push(
                                                                      context,
                                                                      PitchesListPage(
                                                                          notifyID: value
                                                                              .post!
                                                                              .result![index]
                                                                              .sId!));
                                                                } else if (value
                                                                        .post
                                                                        ?.result![
                                                                            index]
                                                                        .type ==
                                                                    8) {
                                                                  PageNavigateScreen().push(
                                                                      context,
                                                                      BiographyPage(
                                                                        type:
                                                                            '',
                                                                      ));
                                                                }
                                                              },
                                                              child: Container(
                                                                height: sizeH *
                                                                    0.06,
                                                                width: sizeW *
                                                                    0.65,
                                                                // color: Colors.red,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .notifications_active_outlined,
                                                                            color:
                                                                                Color(0xff000a5e)),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                sizeW * 0.03,
                                                                            // top: sizeH * 0.01,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                height: sizeH * 0.02,
                                                                                width: sizeW * 0.45,
                                                                                alignment: Alignment.centerLeft,
                                                                                // color: Color
                                                                                //     .fromARGB(
                                                                                //         255,
                                                                                //         39,
                                                                                //         221,
                                                                                //         23),
                                                                                child: Text(
                                                                                  value.post?.result?[index].title.toString() ?? "",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              // Text(
                                                                              //   value.post?.result?[index].text!.toString() ?? "",
                                                                              //   overflow: TextOverflow.ellipsis,
                                                                              //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
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
                                                        (BuildContext context,
                                                            int index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: sizeW *
                                                                    0.02,
                                                                right: sizeW *
                                                                    0.02),
                                                        child: Divider(
                                                          height: 2,
                                                          color:
                                                              Color(0xff000a5e),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                })
                                              : loadSvg(
                                                  image:
                                                      'assets/image/notifications.svg'),
                                        ),
                                      ),
                                    );
                                  }),
                              _isInitialValue == false
                                  ? Consumer<DataClass>(builder:
                                      (BuildContext context, value,
                                          Widget? child) {
                                      return Visibility(
                                        visible: value.totalNotiCount == 0
                                            ? false
                                            : true,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          margin: const EdgeInsets.only(
                                              left: 25, bottom: 20),
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 3),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: DynamicColor.darkBlue,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: FittedBox(
                                            child: Text(
                                              value.totalNotiCount.toString(),
                                              style: TextStyle(
                                                  color: DynamicColor.white),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  : Container()
                            ],
                          )
                        : buttonContainer(
                            height: SizeConfig.getSize50(context: context),
                            width: SizeConfig.getSize50(context: context),
                            fromAppBar: true,
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: loadSvg(
                                  image: 'assets/image/notifications.svg'),
                            )),
                    Column(
                      children: [
                        currentIndexOfDashboard == 0
                            ? AppBarIconContainer(
                                height: SizeConfig.getSize50(context: context),
                                width: SizeConfig.getSize50(context: context),
                                colorTween: _colorTween,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: loadSvg(
                                      image: 'assets/image/menu.svg',
                                      color: isManu == true
                                          ? DynamicColor.darkBlue
                                          : null),
                                ),
                                onTap: () {
                                  setState(() {
                                    isManu = !isManu;
                                    isFilter = false;
                                  });
                                },
                              )
                            : buttonContainer(
                                height: SizeConfig.getSize50(context: context),
                                width: SizeConfig.getSize50(context: context),
                                fromAppBar: true,
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child:
                                      loadSvg(image: 'assets/image/menu.svg'),
                                )),
                        spaceHeight(10),
                        if (currentIndexOfDashboard == 0)
                          Align(
                              alignment: Alignment.bottomRight,
                              child: AppBarIconContainer(
                                height: SizeConfig.getSize50(context: context),
                                width: SizeConfig.getSize50(context: context),
                                colorTween: _colorTween,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: loadSvg(
                                      image: 'assets/image/setting.svg',
                                      color: isFilter == true
                                          ? DynamicColor.darkBlue
                                          : null),
                                ),
                                onTap: () {
                                  if (checkGuestType.isNotEmpty &&
                                      checkGuestType != 'null') {
                                    setState(() {
                                      isFilter = !isFilter;
                                      isManu = false;
                                    });
                                  } else {
                                    Get.to(() => LoginLimitationPage());
                                  }
                                },
                              )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
