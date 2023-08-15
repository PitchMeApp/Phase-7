import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/signUpScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth/loginController.dart';
import '../../../screens/auth/loginScreen.dart';

class LoginLimitationPage extends StatefulWidget {
  LoginLimitationPage({super.key});

  @override
  State<LoginLimitationPage> createState() => _LoginLimitationPageState();
}

class _LoginLimitationPageState extends State<LoginLimitationPage> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(
          onPressad: () {},
        ),
        body: Column(
          children: [
            SafeArea(
              child: Container(
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
            ),
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
            Column(
              children: [
                Text("Please Log in to perform this",
                    style: TextStyle(
                      fontSize: sizeH * 0.025,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: Color(0xff377EB4),
                    )),
                Text(
                  'action.',
                  style: TextStyle(
                    fontSize: sizeH * 0.025,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    color: Color(0xff377EB4),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeH * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen(),
                            binding: LoginBinding());
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color(0xff377EB4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/logout.png",
                              height: 25,
                            ),
                            SizedBox(
                              width: sizeW * 0.015,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 6.h,
                    color: DynamicColor.white,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SignUpScreen(), binding: SignUpBinding());
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
