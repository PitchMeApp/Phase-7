import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:video_viewer/video_viewer.dart';

class WatchSalesPitch extends StatefulWidget {
  const WatchSalesPitch({super.key});

  @override
  State<WatchSalesPitch> createState() => _WatchSalesPitchState();
}

class _WatchSalesPitchState extends State<WatchSalesPitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  VideoViewerController videoViewerController = VideoViewerController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          video(),
          header(),
          BackArrow(
              onPressed: () {
                videoViewerController.pause();
                PageNavigateScreen()
                    .push(context, LoginLimitationPage())
                    .then((value) {
                  setState(() {
                    videoViewerController.play();
                  });
                });
              },
              alignment: Alignment.centerRight,
              icon: Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  Widget video() {
    return Container(
      width: width(context),
      height: height(context),
      color: Color.fromARGB(255, 254, 254, 254),
      child: VideoViewer(
        controller: videoViewerController,
        autoPlay: true,
        enableHorizontalSwapingGesture: false,
        enableVerticalSwapingGesture: false,
        volumeManager: VideoViewerVolumeManager.device,
        onFullscreenFixLandscape: false,
        forwardAmount: 5,
        defaultAspectRatio: 9 / 16,
        rewindAmount: -5,
        looping: true,
        enableShowReplayIconAtVideoEnd: false,
        style: VideoViewerStyle(
            playAndPauseStyle: PlayAndPauseWidgetStyle(
              background: Colors.transparent,
              circleRadius: 80.0,
              play: Center(
                child: Icon(
                  Icons.play_arrow,
                  size: 80,
                  color: DynamicColor.white,
                ),
              ),
              pause: Center(
                child: InkWell(
                  onTap: () {
                    videoViewerController.pause();
                  },
                  child: Icon(
                    Icons.pause,
                    size: 80,
                    color: DynamicColor.white,
                  ),
                ),
              ),
            ),
            thumbnail: Image.network(''),
            loading: CircularProgressIndicator(
              color: Colors.blue,
            )),
        source: {
          "Source": VideoSource(
            video: VideoPlayerController.network(
                'https://ciu.ody.mybluehostin.me/ringbell/watchsales.mp4'),
          )
        },
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.getSize30(context: context) +
              SizeConfig.getSize20(context: context),
          bottom: SizeConfig.getSize20(context: context),
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarIconContainer(
                  height: SizeConfig.getSize50(context: context),
                  width: SizeConfig.getSize50(context: context),
                  colorTween: _colorTween,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: loadSvg(
                      image: 'assets/image/notifications.svg',
                    ),
                  ),
                  onTap: () {
                    videoViewerController.pause();
                    PageNavigateScreen()
                        .push(context, LoginLimitationPage())
                        .then((value) {
                      setState(() {
                        videoViewerController.play();
                      });
                    });
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 8),

                  height: MediaQuery.of(context).size.height * 0.04,
                  // width: MediaQuery.of(context).size.width * 0.35,
                  child: Center(
                    child: Text(
                      'Sales Pitch Tutorial',
                      style: TextStyle(
                          color: DynamicColor.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppBarIconContainer(
                      height: SizeConfig.getSize50(context: context),
                      width: SizeConfig.getSize50(context: context),
                      colorTween: _colorTween,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: loadSvg(
                          image: 'assets/image/menu.svg',
                        ),
                      ),
                      onTap: () {
                        videoViewerController.pause();
                        PageNavigateScreen()
                            .push(
                                context,
                                GuestManuPage(
                                  title: 'Watch Sales Pitch',
                                  pageIndex: 1,
                                ))
                            .then((value) {
                          setState(() {
                            videoViewerController.play();
                          });
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    AppBarIconContainer(
                      height: SizeConfig.getSize50(context: context),
                      width: SizeConfig.getSize50(context: context),
                      colorTween: _colorTween,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: loadSvg(
                          image: 'assets/image/setting.svg',
                        ),
                      ),
                      onTap: () {
                        videoViewerController.pause();
                        PageNavigateScreen()
                            .push(context, LoginLimitationPage())
                            .then((value) {
                          setState(() {
                            videoViewerController.play();
                          });
                        });
                      },
                    )
                  ],
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    videoViewerController.pause();
    _animationController.dispose();
    super.dispose();
  }
}
