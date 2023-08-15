import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/selectionController.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionScreen extends GetView<SelectionController> {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool SectionData = false;

    print("DataFully Loaded");
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BannerWidget(onPressad: () {}),
      body: BackGroundWidget(
          imagebottom: true,
          fit: BoxFit.contain,
          backgroundImage: Assets.backgroundImage2,
          child: Container(
            width: width(context),
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.01)),
                  Padding(
                    padding: SizeConfig.leftRightPadding(context),
                    child: appLogoImage(
                        width: width(context) * 0.5,
                        //isDark: false,
                        height: SizeConfig.getSizeHeightBy(
                            context: context, by: 0.13)),
                  ),
                  whiteBorderContainer(
                      child: Image.asset(Assets.handshakeImage),
                      color: Colors.transparent,
                      height: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.15),
                      width: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.15),
                      cornerRadius: 25),
                  Center(
                      child: Text(
                    'What type of User are you?',
                    style: white21wBold,
                  )),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.02)),
                  NewButtonContainer(
                      heroTage: 1,
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();

                        SectionData = true;
                        preferences.setBool('sectionbool', SectionData);
                        print(
                            " ABCD bool ${preferences.setBool('sectionbool', SectionData)}");
                        controller.submit(1);
                      },
                      title: BUSINESSIDEA,
                      subTitle: 'Amazing Idea needs help to become a Reality'),
                  NewButtonContainer(
                      heroTage: 2,
                      onTap: () {
                        print('object');
                        controller.submit(2);
                        SectionData = true;
                      },
                      title: BUSINESSOWNER,
                      subTitle:
                          'Active Business needs help to Expand and Improve'),
                  NewButtonContainer(
                      heroTage: 3,
                      onTap: () {
                        SectionData = true;

                        controller.submit(3);
                      },
                      title: INVESTOR,
                      subTitle:
                          'Looking for Good Opportunity to Invest Capital'),
                  NewButtonContainer(
                      heroTage: 4,
                      onTap: () {
                        SectionData = true;

                        controller.submit(4);
                      },
                      title: "Facilitator",
                      subTitle:
                          'Your Services, Skills or Connections in Exchange of Partnership'),
                ],
              ),
            ),
          )),
    );
  }
}
