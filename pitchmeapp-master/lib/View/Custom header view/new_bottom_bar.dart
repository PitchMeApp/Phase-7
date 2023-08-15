import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/BottomNavigation.dart';
import 'package:pitch_me_app/View/Leave%20Page/leave_page.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class NewCustomBottomBar extends StatefulWidget {
  int index;
  var isBack;
  var isManuIcon;
  NewCustomBottomBar(
      {super.key, required this.index, this.isBack, this.isManuIcon});

  @override
  State<NewCustomBottomBar> createState() => _NewCustomBottomBarState();
}

class _NewCustomBottomBarState extends State<NewCustomBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  final _controller = PageController();

  int selectIndex = 2;

  @override
  void initState() {
    selectIndex = widget.index;
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

    super.initState();
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
    //"assets/Phase 2 icons/ic_add_24px (1).png",
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
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
//if(Platform.isAndroid)
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: EdgeInsets.only(
              bottom: sizeH * 0.066,
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
              top: sizeW * 0.05),
          child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return Container(
                  height: sizeH * 0.07,
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
                              onTap: widget.index == index
                                  ? null
                                  : () async {
                                      // setState(() {
                                      //   selectIndex = index;
                                      // });

                                      Future changeColors() async {
                                        await Future.delayed(
                                            const Duration(seconds: 0), () {
                                          _animationController.status ==
                                                  AnimationStatus.completed
                                              ? _animationController.reset()
                                              : _animationController.forward();
                                        });
                                      }

                                      Duration(seconds: 0);
                                      _colorTween = ColorTween(
                                              begin: DynamicColor.blue,
                                              end:
                                                  Colors.white.withOpacity(0.3))
                                          .animate(_animationController);

                                      _animationController.repeat();
                                      changeColors();
                                      if (widget.isBack == 'Guest') {
                                        Get.offAll(() => GuestFloatbar(index));
                                      } else {
                                        if (widget.isBack != null) {
                                          Get.offAll(() => Floatbar(index));
                                        } else {
                                          if (index != 2) {
                                            PageNavigateScreen().push(
                                                context,
                                                LeavePage(
                                                  index: index,
                                                ));
                                          }
                                        }
                                      }
                                    },
                              child: Container(
                                  height: sizeH * 0.08,
                                  width: sizeW * 0.07,
                                  child: Image.asset(
                                    selectIndex == index
                                        ? filleIcons[index]
                                        : iconlist[index],
                                  ))),
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
    _animationController.dispose();
    super.dispose();
  }
}
