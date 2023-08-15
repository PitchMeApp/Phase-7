import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/selected_data_view/selected_page.dart';
import 'package:pitch_me_app/View/success%20page/confirmation_post.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:video_player/video_player.dart';

import '../../utils/colors/colors.dart';
import '../../utils/styles/styles.dart';
import '../Custom header view/custom_header_view.dart';
import 'Controller/controller.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final String title;
  const VideoPage({Key? key, required this.filePath, required this.title})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  final VideoFirstPageController _videoFirstPageController =
      Get.put(VideoFirstPageController());

  final _controller = PageController();

  int selectIndex = 2;
  int nextPage = 0;

  bool isSelectedScreen = true;
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
      _videoFirstPageController.videoUrl.value = widget.filePath;
    });

    _initVideoPlayer();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    //await _videoPlayerController.play();
  }

  repalyVideo() async {
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: DynamicColor.blue,
            ))
          : Stack(
              children: [
                PageView(
                  controller: _controller,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  onPageChanged: (value) {
                    setState(() {
                      nextPage = value;
                    });
                  },
                  children: [
                    Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                _videoPlayerController.value.isPlaying
                                    ? _videoPlayerController.pause()
                                    : _videoPlayerController.play();
                              });
                            },
                            child: VideoPlayer(_videoPlayerController)),
                        SizedBox(
                          height: SizeConfig.getSize100(context: context) +
                              SizeConfig.getSize55(context: context),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.23),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    widget.title,
                                    style: white21wBold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _videoPlayerController.value.isPlaying
                                        ? _videoPlayerController.pause()
                                        : _videoPlayerController.play();
                                  });
                                },
                                child: _videoPlayerController.value.isPlaying
                                    ? Container()
                                    : Icon(
                                        _videoPlayerController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: DynamicColor.blue,
                                        size: 50,
                                      ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.24),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.getSize10(context: context),
                                right: 7),
                            child: GestureDetector(
                              onTap: () {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              },
                              child: RotatedBox(
                                  quarterTurns: 4,
                                  child: Image.asset(
                                    "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                    color: DynamicColor.white,
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SelectedPage(
                      showIcon: nextPage,
                      pageController: _controller,
                    )
                  ],
                ),
                CustomHeaderView(
                  title: TextStrings.textKey['record']!,
                  icon: 'assets/images/videoc.png',
                  subTitle: '',
                  progressPersent: 1,
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
                    nextPage == 0
                        ? BackArrow(
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              // _videoPlayerController.removeListener(() {});
                              // _videoPlayerController.dispose();
                              _videoPlayerController.pause();
                              Get.to(() => const ConfirmationPost());
                              //     .then((value) {
                              //   setState(() {});
                              // });
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

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _videoPlayerController.pause();

    super.dispose();
  }
}
