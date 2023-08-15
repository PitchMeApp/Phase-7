import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/feedbackscreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/interestedSwipe.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:video_viewer/video_viewer.dart';

class PostPageWidget extends StatefulWidget {
  const PostPageWidget({
    Key? key,
    required this.controller,
    required this.onSwipe,
    required this.postModel,
  }) : super(key: key);
  final PageController controller;
  final Function(int index, String title, bool isFinish) onSwipe;
  final SalesPitchListModel postModel;

  @override
  State<PostPageWidget> createState() => _PostPageWidgetState();
}

class _PostPageWidgetState extends State<PostPageWidget>
    with AutomaticKeepAliveClientMixin<PostPageWidget>, WidgetsBindingObserver {
  void _listenController() => setState(() {});
  PostPageController controller = Get.put(PostPageController());
  var directionn;
  String checkGuestType = '';
  String businesstype = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkGuest();

    controller.swipableStackController.addListener(_listenController);
    videoViewerControllerList.clear();

    videoViewerControllerList.addAll(List.generate(
        widget.postModel.result.docs.length,
        (index) => VideoViewerController()));
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
      businesstype = preferencesData.getString('log_type').toString();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: SwipableStack(
            swipeAssistDuration: Duration.zero,
            swipeAnchor: SwipeAnchor.bottom,
            dragStartDuration: Duration.zero,
            stackClipBehaviour: Clip.hardEdge,

            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            allowVerticalSwipe: false,
            controller: controller.swipableStackController,
            // stackClipBehaviour: Clip.hardEdge,
            onSwipeCompleted: (index, direction) {
              print("left123direction $index");

              if (direction == SwipeDirection.left) {
                controller.left.value = !controller.left.value;
              }
              if (direction == SwipeDirection.right) {
                controller.right.value = !controller.right.value;
              }
              if (!mounted) {
                return;
              }
              setState(() {
                directionn = direction;
                controller.updateProgressOfCard(0.0);
                controller.updateDirectionOfCard(null);
              });
              //if (businesstype == '3' || businesstype == '4') {
              print('index is $index, direction is $direction');
              controller.label =
                  direction == SwipeDirection.right ? 'Saved' : 'Seen';

              if (direction == SwipeDirection.right) {
                PageNavigateScreen()
                    .push(
                        context,
                        interestedSwipe(
                          userID: widget.postModel.result.docs[index].userid,
                        ))
                    .then((value) {
                  setState(() {
                    if (widget.postModel.result.docs.isEmpty) {
                      widget.onSwipe(index, "", true);
                    } else {
                      widget.onSwipe(
                          index + 1,
                          widget.postModel.result.docs[index + 1].title
                              .toString(),
                          false);
                      // widget.postModel.result.docs[index + 1];
                    }
                  });
                });
                controller.savedVideo(widget.postModel.result.docs[index].id,
                    widget.postModel.result.docs[index].userid);
              } else {
                PageNavigateScreen()
                    .push(
                        context,
                        ratingScreen(
                          receiverid:
                              widget.postModel.result.docs[index].userid,
                          postid: widget.postModel.result.docs[index].id,
                        ))
                    .then((value) {
                  setState(() {
                    if (widget.postModel.result.docs.isEmpty) {
                      widget.onSwipe(index, "", true);
                    } else {
                      widget.onSwipe(
                          index + 1,
                          widget.postModel.result.docs[index + 1].title
                              .toString(),
                          false);
                      // widget.postModel.result.docs[index + 1];
                    }
                  });
                });
              }

              controller.setVisibleSeen(true);
              Future.delayed(Duration(milliseconds: 200)).then((value) {
                controller.setVisibleSeen(false);
              });
              //SEND INDEX AND TITLE
              //}
              if (index != widget.postModel.result.docs.length) {
                widget.onSwipe(
                    index + 1,
                    widget.postModel.result.docs[index + 1].title.toString(),
                    false);
              } else {
                widget.onSwipe(index, "", true);
              }

              if (directionn == SwipeDirection.left &&
                  controller.left.value == true) {
                controller.swipableStackController.rewind();
              }
              if (directionn == SwipeDirection.right &&
                  controller.right.value == true) {
                controller.swipableStackController.rewind();
              }

              if (widget.postModel.result.docs[index].status == 2 &&
                  videoViewerControllerList[index].isPlaying) {
                videoViewerControllerList[index].pause();
                if (!mounted) {
                  return;
                }
                setState(() {});
              }
              controller.refreshed.value = false;
            },
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 0.8,

            itemCount: widget.postModel.result.docs.length,
            builder: (context, properties) {
              final itemIndex =
                  properties.index % widget.postModel.result.docs.length;

              if (mounted) {
                controller.updateProgressOfCard(properties.swipeProgress);
                controller.updateDirectionOfCard(properties.direction);
              }

              return Stack(
                children: [
                  // if (businesstype == '3' || businesstype == '4')
                  controller.getSliderWidget2(
                      post: widget.postModel.result.docs[itemIndex],
                      context: context,
                      itemIndex: itemIndex),
                  // if (businesstype == '1' || businesstype == '2')
                  //   directionn == SwipeDirection.left
                  //       ? controller.left.value == false
                  //           ? controller.getSliderWidget2(
                  //               post: widget.postModel.result.docs[itemIndex],
                  //               context: context,
                  //               itemIndex: itemIndex)
                  //           : UserTypeLimitationPage(
                  //               title1:
                  //                   'Only Investors or Facilitators can access "Watch Sales Pitch" Page',
                  //               title2:
                  //                   'Make sure after Signing Up with different email, you select Investors or Facilitators')
                  //       : controller.right.value == true
                  //           ? UserTypeLimitationPage(
                  //               title1:
                  //                   'Only Investors or Facilitators can access "Watch Sales Pitch" Page',
                  //               title2:
                  //                   'Make sure after Signing Up with different email, you select Investors or Facilitators')
                  //           : controller.getSliderWidget2(
                  //               post: widget.postModel.result.docs[itemIndex],
                  //               context: context,
                  //               itemIndex: itemIndex)
                ],
              );
            },
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: controller.progressOfCard.value.toStringAsFixed(2) == "0.00"
                /* &&
                      controller.direction == null */
                ? SizedBox()
                : AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: controller.progressOfCard.value * 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      height: 1,
                    ),
                    child: Text(
                      controller.direction == null
                          ? ''
                          : controller.direction == SwipeDirection.left
                              ? 'Not interested'
                              : 'Interested',
                    ),
                  )),
        Align(
          alignment: Alignment.bottomCenter,
          child: widget.postModel.result.docs[0].id
                  .contains('6448e9494ff8f4cb69599465')
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.getSize5(context: context), right: 8),
                  child: GestureDetector(
                    onTap: () {
                      widget.postModel.result.docs[0].id
                              .contains('6448e9494ff8f4cb69599465')
                          ? null
                          : widget.controller.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.linear);
                    },
                    child: Container(
                      height: SizeConfig.getSize35(context: context),
                      width: SizeConfig.getSize35(context: context),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(70, 51, 50, 50)
                                  .withOpacity(0.2),
                              blurRadius: 20,
                              offset: Offset(
                                0,
                                0,
                              ))
                        ],
                      ),
                      child: Image.asset(
                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.postModel.result.docs[0].id
                    .contains('6448e9494ff8f4cb69599465')
                ? Container()
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.swipableStackController
                            .next(swipeDirection: SwipeDirection.right);
                      },
                      child: Container(
                        height: SizeConfig.getSize35(context: context),
                        width: SizeConfig.getSize35(context: context),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(71, 60, 60, 60)
                                    .withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(
                                  0,
                                  0,
                                ))
                          ],
                        ),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                              "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
                        ),
                      ),
                    ),
                  ),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.swipableStackController
                      .next(swipeDirection: SwipeDirection.left);
                },
                child: Container(
                  height: SizeConfig.getSize35(context: context),
                  width: SizeConfig.getSize35(context: context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromARGB(71, 60, 60, 60).withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(
                            0,
                            0,
                          ))
                    ],
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      controller.appIsInBackground.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint(
          "App is resumed and visibility is ${controller.videoVisibilityPercent.value}");
      controller.appIsInBackground.value = false;
      setState(() {});
    }
  }
}
