import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/under_progress_limitation.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/View/Profile/Biography/face_camera.dart';
import 'package:pitch_me_app/View/Profile/Biography/nda.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiographyPage extends StatefulWidget {
  String type;
  BiographyPage({super.key, required this.type});

  @override
  State<BiographyPage> createState() => _BiographyPageState();
}

class _BiographyPageState extends State<BiographyPage> {
  final BiographyController controller = Get.put(BiographyController());
  String userName = '';
  String userType = '';
  @override
  void initState() {
    userData();
    controller.getBioApi();
    super.initState();
  }

  void userData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.get('user_name').toString();
      var usertype = prefs.get('log_type').toString();
      if (usertype == "1") {
        userType = 'Business Idea';
      } else if (usertype == "2") {
        userType = 'Business Owner';
      } else if (usertype == "3") {
        userType = 'Investor';
      } else {
        userType = 'Facilitator';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/17580.png',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              color: DynamicColor.blue,
              height: MediaQuery.of(context).size.height * 0.235,
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: DynamicColor.blue,
                  ))
                : Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.getSize60(context: context) +
                                SizeConfig.getSize20(context: context),
                          ),
                          msgText(),
                          biodata(),
                          // SizedBox(height: 15),
                          userDataFields(),
                        ],
                      ),
                      CustomAppbar(
                        title: 'BIOGRAPHY',
                        colorTween: 'BIOGRAPHY',
                        onPressad: () {
                          PageNavigateScreen().push(
                              context,
                              ManuPage(
                                title: 'BIOGRAPHY',
                                pageIndex: 4,
                                isManu: 'Manu',
                              ));
                        },
                        onPressadForNotify: () {},
                      ),
                    ],
                  );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackArrow(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios),
              BackArrow(
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    controller.profileImagePath.path.isNotEmpty
                        ? PageNavigateScreen().push(context, NDAPage())
                        : null;
                  },
                  icon: Icons.arrow_forward_ios),
            ],
          ),
          NewCustomBottomBar(
            index: 4,
            isBack: true,
          ),
        ],
      ),
    );
  }

  Widget msgText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          TextStrings.textKey['bio_text']!,
          style: white13TextStyle,
          textAlign: TextAlign.center,
        ),
        Text(TextStrings.textKey['bio_text2']!,
            style: white13TextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget biodata() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CircleBox(
                title: 'ID',
                title2: '',
                textStyle: blue17,
                checkApprove: controller.idImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.idImagePath.path,
                onPressad: () {
                  controller.selectImage('Id').then((value) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CircleBox(
                title: 'Face',
                title2: 'Check',
                textStyle: blue10,
                checkApprove: controller.fackCheckImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.fackCheckImagePath.path,
                onPressad: () {
                  PageNavigateScreen()
                      .push(context, FaceCameraPage())
                      .then((value) {
                    setState(() {});
                  });
                },
              )
            ],
          ),
          profilePitcher(),
          Column(
            children: [
              CircleBox(
                title: 'Skill',
                title2: 'Certificate',
                textStyle: blue10,
                checkApprove: controller.skillImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.skillImagePath.path,
                onPressad: () {
                  controller.selectImage('Skill').then((value) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CircleBox(
                title: 'Proof',
                title2: 'Funds',
                textStyle: blue10,
                checkApprove: controller.proofImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.proofImagePath.path,
                onPressad: () {
                  controller.getDocumnetFile().then((value) {
                    setState(() {});
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profilePitcher() {
    return SizedBox(
      child: InkWell(
        onTap: () {
          controller.selectImage('Profile').then((value) {
            setState(() {});
          });
        },
        child: Container(
          height: SizeConfig.getSize100(context: context),
          width: SizeConfig.getSize100(context: context),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              borderRadius: BorderRadius.circular(100)),
          child: controller.bioDoc != null &&
                  controller.profileImagePath.path.contains('https')
              ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: DynamicColor.white,
                      backgroundImage: NetworkImage(controller.bioDoc!.picture),
                    ),
                    Container(
                      height: SizeConfig.getSize30(context: context),
                      width: SizeConfig.getSize30(context: context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: DynamicColor.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.check,
                        color: DynamicColor.white,
                      ),
                    )
                  ],
                )
              : controller.profileImagePath.path.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          'Profile Picture',
                          style: TextStyle(
                            color: DynamicColor.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 63,
                      backgroundColor: DynamicColor.white,
                      backgroundImage: FileImage(controller.profileImagePath),
                    ),
        ),
      ),
    );
  }

  Widget userDataFields() {
    return Column(
      children: [
        Text(
          'Name:' + userName,
          style: TextStyle(
            color: DynamicColor.blue,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        CustomBioFields(
          image: 'assets/images/people.png',
          isHttp: userType.isNotEmpty ? userType : null,
          title: userType.isNotEmpty ? userType : '',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_place_24px.png',
          title: 'LOCATION',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/maintenance.png',
          title: 'SKILL',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/education-cap-svgrepo-com.png',
          title: 'EDUCATION',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/business-svgrepo-com.png',
          title: 'EXPERIENCE',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_monetization_on_24px.png',
          title: 'WEALTH',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_cancel_24px.png',
          title: 'ADD',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        Text(
          'ID, Face Check, Funds and Certificate will not be visible to Users',
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
