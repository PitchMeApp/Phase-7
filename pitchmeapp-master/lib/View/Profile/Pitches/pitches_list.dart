import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Pitches/controller.dart';
import 'package:pitch_me_app/View/Profile/Pitches/detail_page.dart';
import 'package:pitch_me_app/View/Profile/Pitches/model.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/delete_sales_post.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../Feedback/controller.dart';

class PitchesListPage extends StatefulWidget {
  String notifyID;
  PitchesListPage({super.key, required this.notifyID});

  @override
  State<PitchesListPage> createState() => _PitchesListPageState();
}

class _PitchesListPageState extends State<PitchesListPage> {
  // late VideoPlayerController _videoPlayerController;

  PitcheController controller = Get.put(PitcheController());
  FeebackController feebackController = Get.put(FeebackController());

  @override
  void initState() {
    if (widget.notifyID.isNotEmpty) {
      feebackController.readAllNotiApi(widget.notifyID);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          SingleChildScrollView(child: _postListWidget()),
          BackArrow(
            alignment: Alignment.centerLeft,
            icon: Icons.arrow_back_ios,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CustomAppbar(
            title: 'Pitches',
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: 'Pitches',
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
          left: SizeConfig.getSize15(context: context),
          right: SizeConfig.getSize15(context: context)),
      child: FutureBuilder<SavedListModel>(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSize100(context: context) +
                          SizeConfig.getSize100(context: context)),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: DynamicColor.blue,
                  )),
                );
              default:
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.getSize100(context: context) +
                            SizeConfig.getSize100(context: context)),
                    child: const Center(child: Text('No pitches available')),
                  );
                } else if (snapshot.data!.result.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.getSize100(context: context) +
                            SizeConfig.getSize100(context: context)),
                    child: const Center(child: Text('No pitches available')),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      reverse: true,
                      itemCount: snapshot.data!.result.length,
                      itemBuilder: (context, index) {
                        SavedResult data = snapshot.data!.result[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => PitcheShowFullVideoPage(
                                    url: data.vid1,
                                    data: data,
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                _leadImgeAndTitle(data, index),
                                _removeButton(index, data.id)
                              ],
                            ),
                          ),
                        );
                      });
                }
            }
          }),
    );
  }

  Widget _leadImgeAndTitle(SavedResult data, int index) {
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: DynamicColor.blue, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  //  data.vid1.isNotEmpty
                  //     ?
                  Container(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.img1,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                        color: DynamicColor.white,
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/image_not.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // VideoViewer(
                //   controller: VideoViewerController(),
                //   autoPlay: false,
                //   enableHorizontalSwapingGesture: false,
                //   enableVerticalSwapingGesture: false,
                //   volumeManager: VideoViewerVolumeManager.device,
                //   onFullscreenFixLandscape: false,
                //   forwardAmount: 5,
                //   defaultAspectRatio: 9 / 16,
                //   rewindAmount: -5,
                //   looping: true,
                //   enableShowReplayIconAtVideoEnd: false,
                //   source: {
                //     "Source": VideoSource(
                //       video: VideoPlayerController.network(data.vid1),
                //     )
                //   },
                // ),
                //VideoPlayer(_videoPlayerController),
              )
              // : Image.asset(
              //     'assets/images/not_video.jpg',
              //     height: 100,
              //     width: 100,
              //     fit: BoxFit.cover,
              //   ),
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                title: Text(
                  data.title,
                  style: white15TextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      data.status == 1 ? 'Pending' : 'Approved',
                      style: darkBlue12,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.comment,
                      style: white15TextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _removeButton(int index, id) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => DeleteSalesPostPopUp(
                  id: id,
                  type: 'Pitches',
                )).then((value) {
          setState(() {});
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: DynamicColor.white,
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset(
              "assets/images/ic_add_24px.png",
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
