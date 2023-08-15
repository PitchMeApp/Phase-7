import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../Custom header view/new_bottom_bar.dart';

class LeavePage extends StatefulWidget {
  int index;
  LeavePage({super.key, required this.index});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  bool selectbutton = false;
  bool selectbutton_Two = false;

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            SafeArea(
                child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: sizeW * 0.02,
                right: sizeW * 0.02,
              ),
              child: Center(
                child: Image.asset(
                  "assets/image/Group 12262.png",
                  height: sizeH * 0.09,
                ),
              ),
            )),
            Container(
                child: Padding(
              padding: EdgeInsets.only(left: sizeW * 0.02, right: sizeW * 0.02),
              child: Image.asset(
                "assets/image/Group 12261.png",
                height: sizeH * 0.13,
              ),
            )),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(
                      right: SizeConfig.getSize35(context: context)),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xff377EB4),
                  ),
                  // height: sizeH * 0.05,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 35,
                    ),
                  )),
            ),
            SizedBox(
              height: sizeH * 0.02,
            ),
            Text(
              "If you leave, you will loose all Progress. Are you Sure?",
              style: TextStyle(
                fontSize: sizeH * 0.028,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Color(0xff377EB4),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: sizeH * 0.05,
            ),
            InkWell(
              onTap: () {
                controller.PageIndexData.value = 0;
                // PageNavigateScreen().normalpushReplesh(context, Floatbar(0));
                PageNavigateScreen().pushRemovUntil(context, Floatbar(0));
              },
              child: Container(
                height: sizeH * 0.045,
                width: sizeW * 0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      selectbutton_Two ? Color(0xff000c61) : Color(0xff377EB4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: sizeW * 0.015,
                    ),
                    Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        NewCustomBottomBar(
          index: widget.index,
        ),
      ],
    ));
  }
}
