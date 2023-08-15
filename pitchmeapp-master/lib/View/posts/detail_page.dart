import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Pitches/controller.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/show_image_popup.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors/colors.dart';

class PostDetailPage extends StatefulWidget {
  final data;
  dynamic arrowCheck;
  String userID;
  VoidCallback? onPressad;
  PostDetailPage(
      {super.key,
      this.data,
      this.arrowCheck,
      this.onPressad,
      required this.userID});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  dynamic data;
  List typeList = [];
  List serviceList = [];
  List serviceDetailList = [];
  //List whocanwatchList = [];

  String userType = '';
  final PitcheController pitcheController = Get.put(PitcheController());
  dynamic userDetail;
  @override
  void initState() {
    data = widget.data;
    getUserDetailApi();
    var type = data.type.toString().replaceAll('[', '').replaceAll(']', '');

    if (type.contains(' ')) {
      typeList = type.split(', ');
    } else {
      typeList = type.split(',');
    }

    var service = data.services.replaceAll('[', '').replaceAll(']', '');
    if (service.isNotEmpty) {
      serviceList = service.split(', ');
    }
    var serviceDetail =
        data.servicesDetail.replaceAll('[', '').replaceAll(']', '');
    if (serviceDetail.isNotEmpty) {
      serviceDetailList = serviceDetail.split(', ');
    }
    // var whoCanWatch = data.whocanwatch.replaceAll('[', '').replaceAll(']', '');
    // if (whoCanWatch.isNotEmpty) {
    //   whocanwatchList = whoCanWatch.split(', ');
    // }

    super.initState();
  }

  void getUserDetailApi() async {
    try {
      await GetApiService().getUserDetailApi(widget.userID).then((value) {
        if (value != null) {
          setState(() {
            userDetail = value['result'];
            getUserType(value['result']['log_type']);
          });
        }
      });
    } catch (e) {
      userType = 'No user type';
    }
  }

  Future getUserType(type) async {
    if (type == 1) {
      userType = 'Business Idea';
    } else if (type == 2) {
      userType = 'Business Owner';
    } else if (type == 3) {
      userType = 'Investor';
    } else {
      userType = 'Facilitator';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: BannerWidget(onPressad: () {}),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  spaceHeight(SizeConfig.getSize40(context: context)),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.arrowCheck != null
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: widget.onPressad,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, right: 7),
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: DynamicColor.blue,
                                          size: 30,
                                        ),
                                      )),
                                ),
                              )
                            : Container(),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(bottom: 10, left: 10),
                        //     child: IconButton(
                        //         onPressed: () {
                        //           Navigator.of(context).pop();
                        //         },
                        //         icon: Icon(Icons.arrow_back)),
                        //   ),
                        // ),
                        appStatistics(context: context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.arrowCheck == null
                ? BackArrow(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    alignment: Alignment.centerLeft,
                    icon: Icons.arrow_back_ios)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    return Center(
        child: Column(
      children: [
        customWidget("assets/images/industry-mdpi.png", data.industry,
            onPressad: () {
          //PageNavigateScreen().push(context, SelectIndustryPage());
        }),
        customWidget("assets/images/ic_place_24px-mdpi.png", data.location,
            onPressad: () {
          // PageNavigateScreen().push(context, LocationPage());
        }),
        typeList.length > 0
            ? customWidget("assets/images/ic_local_atm_24-mdpi (1).png",
                typeList[0].replaceAll(',', ''), onPressad: () {
                //PageNavigateScreen().push(context, WhatNeedPage());
              })
            : Container(),
        data.valueamount.isNotEmpty
            ? customWidget(
                "assets/images/ic_monetization.png", data.valueamount,
                onPressad: () {
                // PageNavigateScreen().push(context, FundsPage());
              })
            : Container(),
        typeList.length > 1 && typeList[1].isNotEmpty
            ? customWidget("assets/images/_Group_-mdpi.png", typeList[1],
                onPressad: () {
                // PageNavigateScreen().push(context, WhatNeedPage());
              })
            : Container(),
        serviceList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  return customWidget("assets/images/ic_content_past-mdpi.png",
                      serviceList[index], onPressad: () {
                    //PageNavigateScreen().push(context, NeedPage());
                  });
                })
            : Container(),
        serviceDetailList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: serviceDetailList.length,
                itemBuilder: (context, index) {
                  return customWidget("assets/images/ic_check_circle-mdpi.png",
                      serviceDetailList[index], onPressad: () {
                    //PageNavigateScreen().push(context, NeedPage());
                  });
                })
            : Container(),
        // whocanwatchList.isNotEmpty
        //     ? ListView.builder(
        //         shrinkWrap: true,
        //         primary: false,
        //         padding: EdgeInsets.zero,
        //         itemCount: whocanwatchList.length,
        //         itemBuilder: (context, index) {
        //           return customWidget("assets/images/ic_visibility_24px.png",
        //               whocanwatchList[index], onPressad: () {
        //             //PageNavigateScreen().push(context, NeedPage());
        //           });
        //         })
        //     : Container(),
        customWidget("", data.description, onPressad: () {
          //PageNavigateScreen().push(context, OfferPage());
        }),
        customWidget("", userType, onPressad: () {
          //PageNavigateScreen().push(context, OfferPage());
        }),
        customWidget("", 'Biography', onPressad: () {
          PageNavigateScreen().normalpushReplesh(
              context,
              HomeBiographyPage(
                type: 'Biography',
                userID: userDetail['_id'],
                notifyID: '',
              ));
        }),
        _imagesGridView()
      ],
    ));
  }

  Widget _imagesGridView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Wrap(
          runSpacing: 10,
          children: [
            data.img1.isNotEmpty
                ? imageWidget(data.img1)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            data.img2.isNotEmpty
                ? imageWidget(data.img2)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            data.img3.isNotEmpty
                ? imageWidget(data.img3)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            data.img4.isNotEmpty
                ? imageWidget(data.img4)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            data.file.isNotEmpty
                ? pdfWidget(data.file)
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget(url) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowFullImagePopup(image_url: url));
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Image.network(
          url,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget pdfWidget(url) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
      child: Container(
        height: 120,
        width: 90,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(bottom: 10),
        child: Image.asset(
          'assets/images/pdf.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget customWidget(iconImage, name, {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressad,
      child: Container(
          height: sizeH * 0.068,
          margin: EdgeInsets.only(
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
              bottom: sizeH * 0.015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff377EB4),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.getFontSize14(context: context),
              right: SizeConfig.getFontSize14(context: context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconImage.isNotEmpty
                    ? Image.asset(
                        iconImage,
                        height: sizeH * 0.04,
                        width: sizeW * 0.08,
                        color: DynamicColor.white,
                        alignment: Alignment.centerLeft,
                      )
                    : Container(
                        width: 30,
                      ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: 30,
                )
              ],
            ),
          )),
    );
  }
}
