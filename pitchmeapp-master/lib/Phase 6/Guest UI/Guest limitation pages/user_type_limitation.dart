import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/signUpScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:sizer/sizer.dart';

class UserTypeLimitationPage extends StatefulWidget {
  String title1;
  String title2;
  UserTypeLimitationPage({
    super.key,
    required this.title1,
    required this.title2,
  });

  @override
  State<UserTypeLimitationPage> createState() => _UserTypeLimitationPageState();
}

class _UserTypeLimitationPageState extends State<UserTypeLimitationPage> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton:
        //     widget.title1.contains('Investors or Facilitators')
        //         ? null
        //         : BannerWidget(
        //             onPressad: () {},
        //           ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: sizeW * 0.02, right: sizeW * 0.02, top: 20),
                child: Center(
                  child: Image.asset(
                    "assets/image/Group 12262.png",
                    height: sizeH * 0.08,
                  ),
                ),
              )),
              Container(
                  child: Padding(
                padding:
                    EdgeInsets.only(left: sizeW * 0.02, right: sizeW * 0.02),
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
                        Get.offAll(() => Floatbar(0));
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
              SizedBox(
                width: sizeW - 40,
                child: Text(
                  widget.title1,
                  style: TextStyle(
                    fontSize: sizeH * 0.025,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    color: Color(0xff377EB4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: sizeH * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: InkWell(
                  onTap: () {
                    Get.to(() => SignUpScreen(), binding: SignUpBinding());
                  },
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff377EB4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: sizeW * 0.015,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeH * 0.05,
              ),
              SizedBox(
                width: sizeW - 40,
                child: Text(
                  widget.title2,
                  style: TextStyle(
                    fontSize: sizeH * 0.025,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    color: Color(0xff377EB4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
