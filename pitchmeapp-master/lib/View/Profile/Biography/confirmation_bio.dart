import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';

class ConfirmationBio extends StatefulWidget {
  ConfirmationBio({
    super.key,
  });

  @override
  State<ConfirmationBio> createState() => _ConfirmationBioState();
}

class _ConfirmationBioState extends State<ConfirmationBio> {
  BiographyController biographyController = Get.put(BiographyController());
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    log(biographyController.idImagePath.path);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(
          onPressad: () {},
        ),
        body: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/17580.png',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02, top: 50),
                      child: Center(
                        child: Image.asset(
                          "assets/image/Group 12262.png",
                          height: sizeH * 0.08,
                        ),
                      ),
                    )),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02),
                      child: Image.asset(
                        "assets/image/Group 12261.png",
                        height: sizeH * 0.20,
                      ),
                    )),
                  ],
                ),
                // SizedBox(
                //   height: sizeH * 0.15,
                // ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'send this Biography for',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Approval?',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: sizeH * 0.30,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.24,
                child: Obx(() {
                  return biographyController.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: DynamicColor.blue),
                        )
                      : Container(
                          height: 36,
                        );
                }),
              ),
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
                Obx(() {
                  return biographyController.isLoading.value == true
                      ? Container()
                      : BackArrow(
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            biographyController.postBiography(context);
                          },
                          icon: Icons.arrow_forward_ios);
                }),
              ],
            ),
          ],
        ));
  }
}
