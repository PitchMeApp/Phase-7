import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/user_type_limitation.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

class DemoWatchSalesPitch extends StatefulWidget {
  const DemoWatchSalesPitch({super.key});

  @override
  State<DemoWatchSalesPitch> createState() => _DemoWatchSalesPitchState();
}

class _DemoWatchSalesPitchState extends State<DemoWatchSalesPitch> {
  VideoViewerController videoViewerController = VideoViewerController();
  String newUser = '';
  String businesstype = '';
  @override
  void initState() {
    getUserType();
    super.initState();
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      businesstype = prefs.getString('log_type').toString();
      newUser = prefs.getString('new_user').toString();
    });
  }

  removeUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('new_user').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          video(),
          BackArrow(
              onPressed: () {
                videoViewerController.pause();
                if (newUser == 'New User' &&
                    (businesstype == '3' || businesstype == '4')) {
                  removeUserType();
                  Get.offAll(() => Floatbar(1));
                } else {
                  PageNavigateScreen().push(
                      context,
                      UserTypeLimitationPage(
                          title1:
                              'Only Investors or Facilitators can access "Watch Sales Pitch" Page',
                          title2:
                              'Make sure after Signing Up with different email, you select Investors or Facilitators'));
                }
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
                child: Icon(
                  Icons.pause,
                  size: 80,
                  color: DynamicColor.white,
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

  @override
  void dispose() {
    videoViewerController.dispose();

    super.dispose();
  }
}
