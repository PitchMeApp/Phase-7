import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Likes/controller.dart';
import 'package:pitch_me_app/View/Profile/Likes/detail_page.dart';
import 'package:pitch_me_app/View/Profile/Likes/model.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:video_viewer/video_viewer.dart';

class LikesListPage extends StatefulWidget {
  const LikesListPage({super.key});

  @override
  State<LikesListPage> createState() => _LikesListPageState();
}

class _LikesListPageState extends State<LikesListPage> {
  VideoViewerController _videoPlayerController = VideoViewerController();

  LikesController controller = Get.put(LikesController());

  // Future _initVideoPlayer(url) async {
  //   //videoViewerControllerList = [];
  //   try {
  //     _videoPlayerController = VideoPlayerController.network(url);
  //     await _videoPlayerController.initialize();
  //     await _videoPlayerController.setLooping(true);
  //     await _videoPlayerController.pause();
  //   } catch (e) {
  //     log('message = ' + e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _postListWidget(),
          BackArrow(
            alignment: Alignment.centerLeft,
            icon: Icons.arrow_back_ios,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CustomAppbar(
            title: 'Likes',
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: 'Likes',
                    pageIndex: 4,
                    isManu: 'Manu',
                  ));
            },
            onPressadForNotify: () {},
          ),
          NewCustomBottomBar(
            index: 4,
            isBack: true,
          ),
        ],
      ),
    );
  }

  Widget _postListWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.getSize60(context: context),
          left: SizeConfig.getSize25(context: context),
          right: SizeConfig.getSize25(context: context)),
      child: FutureBuilder<SavedLikeListModel>(
          future: controller.getSavedLikeListApi(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                  color: DynamicColor.blue,
                ));
              default:
                if (snapshot.hasError) {
                  // log(snapshot.error.toString());
                  return const Center(child: Text('No likes available'));
                } else if (snapshot.data!.result.isEmpty) {
                  return const Center(child: Text('No likes available'));
                } else {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 0.70),
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.result.length,
                      itemBuilder: (context, index) {
                        LikeResult data = snapshot.data!.result[index];
                        String url = Uri.encodeFull(
                            'http://191.101.229.245:9070/' + data.file);
                        // _initVideoPlayer(url);

                        return Card(
                          color: DynamicColor.blue,
                          child: data.file.isNotEmpty
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: VideoViewer(
                                        // controller: _videoPlayerController,
                                        autoPlay: false,
                                        enableHorizontalSwapingGesture: false,
                                        enableVerticalSwapingGesture: false,
                                        volumeManager:
                                            VideoViewerVolumeManager.device,
                                        onFullscreenFixLandscape: false,
                                        forwardAmount: 5,
                                        defaultAspectRatio: 9 / 16,
                                        rewindAmount: -5,
                                        looping: true,
                                        enableChat: true,
                                        enableShowReplayIconAtVideoEnd: false,
                                        source: {
                                          "Source": VideoSource(
                                            video:
                                                VideoPlayerController.network(
                                                    url),
                                          )
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        PageNavigateScreen().push(context,
                                            ShowFullVideoPage(url: url));
                                      },
                                      // child: Container(
                                      //     height: 100,
                                      //     alignment: Alignment.center,
                                      //     color: Color.fromARGB(
                                      //         157, 252, 252, 252)),
                                    )
                                  ],
                                )
                              //VideoPlayer(_videoPlayerController),
                              //):
                              : Image.asset(
                                  'assets/images/not_video.jpg',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        );
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // Get.to(() => PostDetailPage(
                        //       //       data: data,
                        //       //     ));
                        //     },
                        //     child: Stack(
                        //       alignment: Alignment.topRight,
                        //       children: [
                        //         _leadImgeAndTitle(data, index),
                        //         _removeButton(index, data.id)
                        //       ],
                        //     ),
                        //   ),
                        // );
                      });
                }
            }
          }),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    super.dispose();
  }
}
