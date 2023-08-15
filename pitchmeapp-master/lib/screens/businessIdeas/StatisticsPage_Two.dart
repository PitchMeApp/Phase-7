import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/show_image_popup.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/widgets/Navigation/custom_navigation.dart';

class StatisticsPage_Two extends StatefulWidget {
  const StatisticsPage_Two({
    Key? key,
    required this.pagecont,
    required this.salesDoc,
  }) : super(key: key);
  final PageController pagecont;
  final SalesDoc salesDoc;

  @override
  State<StatisticsPage_Two> createState() => _StatisticsPage_TwoState();
}

class _StatisticsPage_TwoState extends State<StatisticsPage_Two> {
  List typeList = [];
  List serviceList = [];
  List serviceDetailList = [];
  late SalesDoc salesDoc;

  String userType = '';

  @override
  void initState() {
    salesDoc = widget.salesDoc;

    var type = salesDoc.type.replaceAll('[', '').replaceAll(']', '');
    if (type.contains(' ')) {
      typeList = type.split(', ');
    } else {
      typeList = type.split(',');
    }

    var service = salesDoc.services.replaceAll('[', '').replaceAll(']', '');
    if (service.isNotEmpty) {
      serviceList = service.split(', ');
    }
    var serviceDetail =
        salesDoc.servicesDetail.replaceAll('[', '').replaceAll(']', '');
    if (serviceDetail.isNotEmpty) {
      serviceDetailList = serviceDetail.split(', ');
    }
    checkUserType();
    super.initState();
  }

  void checkUserType() {
    if (salesDoc.user.logType == 1) {
      userType = 'Business Idea';
    } else if (salesDoc.user.logType == 2) {
      userType = 'Business Owner';
    } else if (salesDoc.user.logType == 3) {
      userType = 'Investor';
    } else {
      userType = 'Facilitator';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Stack(
          children: [
            Column(
              children: [
                spaceHeight(SizeConfig.getSize60(context: context)),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.pagecont.previousPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10, right: 7),
                                child: /* SvgPicture.asset(Assets.tiktokPreviousIco),*/
                                    RotatedBox(
                                  quarterTurns: 6,
                                  child: Image.asset(
                                    "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                    color: Color(0xff377EB4),
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Expanded(child: appStatistics(context: context)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          customWidget('assets/images/industry-mdpi.png', salesDoc.industry,
              onPressad: () {}),
          customWidget(
              'assets/images/ic_place_24px-mdpi.png', salesDoc.location,
              onPressad: () {}),
          typeList.length > 0
              ? customWidget('assets/images/ic_local_atm_24-mdpi (1).png',
                  typeList[0].replaceAll(',', ''),
                  onPressad: () {})
              : Container(),
          salesDoc.valueamount.isNotEmpty
              ? customWidget(
                  'assets/images/ic_monetization.png', salesDoc.valueamount,
                  onPressad: () {})
              : Container(),
          typeList.length > 1 && typeList[1].isNotEmpty
              ? customWidget('assets/images/_Group_-mdpi.png', typeList[1],
                  onPressad: () {})
              : Container(),
          serviceList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceList.length,
                  itemBuilder: (context, index) {
                    return customWidget(
                        "assets/images/ic_content_past-mdpi.png",
                        serviceList[index],
                        onPressad: () {});
                  })
              : Container(),
          serviceDetailList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceDetailList.length,
                  itemBuilder: (context, index) {
                    return customWidget(
                        "assets/images/ic_check_circle-mdpi.png",
                        serviceDetailList[index],
                        onPressad: () {});
                  })
              : Container(),
          customWidget('', userType, onPressad: () {}),
          customWidget('', 'Biography', onPressad: () {
            PageNavigateScreen().push(
                context,
                HomeBiographyPage(
                  type: 'Biography',
                  userID: salesDoc.userid,
                  notifyID: '',
                ));
          }),
          customWidget('', widget.salesDoc.description, onPressad: () {}),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Wrap(
                runSpacing: 10,
                children: [
                  salesDoc.img1.isNotEmpty
                      ? imageWidget(salesDoc.img1)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img2.isNotEmpty
                      ? imageWidget(salesDoc.img2)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img3.isNotEmpty
                      ? imageWidget(salesDoc.img3)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img4.isNotEmpty
                      ? imageWidget(salesDoc.img4)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.file.isNotEmpty
                      ? pdfWidget(salesDoc.file)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
          ),
          spaceHeight(SizeConfig.getSize80(context: context)),
        ],
      )),
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
                        alignment: Alignment.centerLeft,
                        color: DynamicColor.white,
                      )
                    : Container(
                        width: 30,
                      ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 1,
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
}
