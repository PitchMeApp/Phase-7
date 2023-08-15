import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/FeedbackApi.dart/postApi.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ratingScreen extends StatefulWidget {
  String receiverid;
  String postid;
  ratingScreen({
    super.key,
    required this.receiverid,
    required this.postid,
  });

  @override
  State<ratingScreen> createState() => _ratingScreenState();
}

class _ratingScreenState extends State<ratingScreen> {
  final formkey = GlobalKey<FormState>();
  var rating = 0.0;
  var rating_Two = 0.0;
  bool selectbutton = false;
  bool selectbutton_Two = false;

  String description = '';

  PostPageController _pageController = Get.put(PostPageController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    _pageController.notVideo = true;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(onPressad: () {}),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(children: [
                  SizedBox(
                    height: sizeH * 0.06,
                  ),
                  Image.asset(
                    "assets/image/Group 12262.png",
                    height: sizeH * 0.09,
                  ),
                  Image.asset(
                    "assets/image/Group 12261.png",
                    height: sizeH * 0.13,
                  ),
                  SizedBox(
                    height: sizeH * 0.09,
                  ),
                  Text(
                    "Please give a Feedback so they",
                    style: TextStyle(
                        fontSize: sizeH * 0.025,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Color(0xff377EB4)),
                  ),
                  Text(
                    "can improve",
                    style: TextStyle(
                        fontSize: sizeH * 0.025,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Color(0xff377EB4)),
                  ),
                  SizedBox(
                    height: sizeH * 0.02,
                  ),
                  Center(
                    child: Text(
                      "The Business",
                      style: TextStyle(
                          fontSize: sizeH * 0.016,
                          letterSpacing: 0.5,
                          color: Color(0xff377EB4)),
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.013,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                      starCount: 5,
                      rating: rating,
                      size: 30.0,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_border,
                      color: Color(0xff377EB4),
                      borderColor: Color(0xff377EB4),
                      spacing: 0.0),
                  SizedBox(
                    height: sizeH * 0.015,
                  ),
                  Center(
                    child: Text(
                      "The Sales Pitch",
                      style: TextStyle(
                          fontSize: sizeH * 0.016,
                          letterSpacing: 0.5,
                          color: Color(0xff377EB4)),
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.013,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (value) {
                        setState(() {
                          rating_Two = value;
                        });
                      },
                      starCount: 5,
                      rating: rating_Two,
                      size: 30.0,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_border,
                      color: Color(0xff377EB4),
                      borderColor: Color(0xff377EB4),
                      spacing: 0.0),
                  SizedBox(
                    height: sizeH * 0.02,
                  ),
                  SizedBox(
                    height: 45,
                    width: sizeW - 40,
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Give a Brief Advice',
                        contentPadding:
                            EdgeInsets.only(top: 5, left: 5, right: 5),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff377EB4),
                              width: 2,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff377EB4),
                              width: 2,
                            )),
                      ),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      final isvalidation = formkey.currentState!.validate();

                      print(" rating star ${rating_Two}");

                      ///
                      /// Sign Up
                      ///

                      if (description.isNotEmpty &&
                          rating_Two != 0.0 &&
                          rating != 0.0) {
                        // Navigator.of(context).pop();
                        postfeedback(widget.receiverid, widget.postid, rating,
                            rating_Two, description);
                        // Get.offAll(Floatbar(1));
                        // _pageController.swipableStackController
                        //     .next(swipeDirection: SwipeDirection.left);
                        // setState(() {
                        //   _pageController.left = false;
                        // });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please give star and feedback",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: DynamicColor.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        selectbutton = true;
                      }
                    },
                    child: Container(
                        height: 48,
                        width: sizeW - 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectbutton
                              ? Color(0xff000c61)
                              : Color(0xff377EB4),
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(
                  onPressed: () {
                    // _pageController.swipableStackController
                    //     .next(swipeDirection: SwipeDirection.left);
                    setState(() {
                      _pageController.left.value = false;
                    });
                    Navigator.of(context).pop();
                    // Get.offAll(Floatbar(1));
                  },
                  icon: Icons.arrow_back_ios,
                  alignment: Alignment.centerLeft,
                ),
                BackArrow(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // _pageController.swipableStackController
                    //     .next(swipeDirection: SwipeDirection.left);
                    // Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_forward_ios,
                  alignment: Alignment.centerRight,
                ),
              ],
            )
          ],
        ));
  }
}
