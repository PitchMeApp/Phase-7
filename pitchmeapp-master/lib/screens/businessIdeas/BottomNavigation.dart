import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Demo%20Video/demo_video.dart';
import 'package:pitch_me_app/View/Profile/profile.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/VideoScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/mainHome.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Floatbar extends StatefulWidget {
  // const Floatbar({super.key, var index = 3});
  var selectData;
  Floatbar(this.selectData);

  @override
  State<Floatbar> createState() => _FloatbarState();
}

String businesstype = '';

class _FloatbarState extends State<Floatbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  // Color _ContainerColor = Color.fromARGB(255, 225, 225, 225).withOpacity(0.3);
  // Color _CoColor = Color(0xff37B47E);
  // Color _xyz = Color(0xff375454);
  int selectIndex = 0;

  bool isSelectedScreen = true;

  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    changeColors();
    getUserType();
    if (widget.selectData != null) {
      controller.PageIndexData.value = widget.selectData;
    }
    super.initState();
    //getBoolValuesSF();
//Colors.white.withOpacity(0.3)
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorTween = ColorTween(begin: DynamicColor.blue, end: DynamicColor.blue)
        .animate(_animationController);
    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });
  }

  Future changeColors() async {
    await Future.delayed(const Duration(seconds: 0), () {
      _animationController.reset();
    });
  }

  List iconlist = [
    "assets/Phase 2 icons/ic_home_24px (1).png",
    "assets/Phase 2 icons/ic_subscriptions_24px.png",
    "assets/Phase 2 icons/ic_add_24px.png",
    "assets/Phase 2 icons/equalizer_light.png",
    "assets/Phase 2 icons/ic_person_24px.png",
  ];

  List filleIcons = [
    "assets/Phase 2 icons/ic_home_24px.png",
    "assets/Phase 2 icons/ic_subscriptions_24px (1).png",
    "assets/Phase 2 icons/ic_add_24px (1).png",
    "assets/Phase 2 icons/equalizer_dark.png",
    "assets/Phase 2 icons/ic_person_24px (1).png",
  ];
  List<Widget> pages = [
    MainHomeScreen(),
    mainHome_Two(),
    DemoVideoPage(),
    DealsPage(),
    ProfilePage(),
  ];

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      businesstype = prefs.getString('log_type').toString();
    });
  }

  var ColorChangerIndex;
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: pages.isEmpty
          ? Container()
          : Obx(() => pages[controller.PageIndexData.value]),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              bottom: sizeH * 0.066,
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
              top: sizeW * 0.05),

          // padding: EdgeInsets.only(
          //     bottom: sizeH * 0.040,
          //     left: sizeW * 0.015,
          //     right: sizeW * 0.015,
          //     top: sizeW * 0.05),
          child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return Container(
                  height: sizeH * 0.07,
                  width: sizeW * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: DynamicColor.blue,
                    //_colorTween.value,
                    boxShadow: [
                      // BoxShadow(
                      //   color: Color.fromARGB(109, 20, 20, 20).withOpacity(0.3),
                      //   blurRadius: 25.0,
                      //   spreadRadius: 25,
                      //   offset: Offset(
                      //     20,
                      //     20,
                      //   ),
                      // )
                    ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: iconlist.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: sizeW * 0.05,
                          ),
                          InkWell(
                            onTap: () async {
                              Future changeColors() async {
                                await Future.delayed(const Duration(seconds: 0),
                                    () {
                                  _animationController.status ==
                                          AnimationStatus.completed
                                      ? _animationController.reset()
                                      : _animationController.forward();
                                });
                              }

                              Duration(seconds: 0);
                              _colorTween = ColorTween(
                                      begin: DynamicColor.blue,
                                      end: Colors.white.withOpacity(0.3))
                                  .animate(_animationController);

                              _animationController.repeat();
                              changeColors();

                              setState(() {
                                isSelectedScreen = false;
                                controller.PageIndexData.value = index;

                                // controller.PageIndexData.value == 4
                                //     ? Get.offAll(() => LoginScreen(),
                                //         binding: LoginBinding())
                                //     : null;
                              });
                            },
                            child: Container(
                                height: sizeH * 0.08,
                                width: sizeW * 0.07,
                                child: Obx(() => Image.asset(
                                      controller.PageIndexData.value == index
                                          ? filleIcons[index]
                                          : iconlist[index],
                                    ))),
                          ),
                          SizedBox(
                            width: sizeW * 0.05,
                          )
                        ],
                      );
                    },
                  ),
                );
              })),
    );
  }

  @override
  void dispose() {
    _animationController.clearListeners();
    super.dispose();
  }
}
