import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:video_viewer/video_viewer.dart';

class ShowFullVideoPage extends StatefulWidget {
  String url;
  dynamic arrowCheck;
  VoidCallback? onPressad;
  ShowFullVideoPage(
      {super.key, required this.url, this.arrowCheck, this.onPressad});

  @override
  State<ShowFullVideoPage> createState() => _ShowFullVideoPageState();
}

class _ShowFullVideoPageState extends State<ShowFullVideoPage> {
  VideoViewerController videoViewerController = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    print(widget.url);
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  video: VideoPlayerController.network(Uri.encodeFull(widget.url
                      .replaceAll('https://api.salespitchapp.com',
                          'http://191.101.229.245:9070'))),
                )
              },
            ),
          ),
          BackArrow(
              onPressed: () {
                Navigator.of(context).pop();
              },
              alignment: Alignment.centerLeft,
              icon: Icons.arrow_back_ios),
          widget.arrowCheck != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: widget.onPressad,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10, right: 7),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: DynamicColor.blue,
                            size: 30,
                          ),
                        )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    videoViewerController.pause();
    super.dispose();
  }
}
