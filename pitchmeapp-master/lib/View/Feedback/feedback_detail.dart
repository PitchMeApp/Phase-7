import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Feedback/controller.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/notification_Model.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class FeedbackPage extends StatefulWidget {
  // String receiverid;
  // String postid;
  NotifyResult data;
  String type;
  String notifyID;
  FeedbackPage({
    super.key,
    // required this.receiverid,
    // required this.postid,
    required this.data,
    required this.type,
    required this.notifyID,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final formkey = GlobalKey<FormState>();
  FeebackController feebackController = Get.put(FeebackController());

  @override
  void initState() {
    feebackController.readAllNotiApi(widget.notifyID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(children: [
          SizedBox(
            height: sizeH * 0.1,
          ),
          Image.asset(
            "assets/image/Group 12262.png",
            height: sizeH * 0.09,
          ),
          SizedBox(
            height: sizeH * 0.065,
          ),
          Image.asset(
            "assets/image/Group 12261.png",
            height: sizeH * 0.13,
          ),
          SizedBox(
            height: sizeH * 0.01,
          ),
          Text(
            " Overall Rating ",
            style: TextStyle(
                fontSize: sizeH * 0.027,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Color(0xff377EB4)),
          ),
          SizedBox(
            height: sizeH * 0.017,
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
              starCount: 5,
              rating: double.parse('${widget.data.star}'),
              size: 40.0,
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
              starCount: 5,
              rating: double.parse('${widget.data.videoStar}'),
              size: 40.0,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_border,
              color: Color(0xff377EB4),
              borderColor: Color(0xff377EB4),
              spacing: 0.0),
          SizedBox(
            height: sizeH * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: sizeW * 0.035, right: sizeW * 0.035),
            child: TextFormField(
              autofocus: false,
              initialValue: widget.data.text,
              readOnly: true,
              maxLines: 5,
              // style: TextStyle(color: DynamicColor.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xff377EB4),
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xff377EB4),
                      width: 1,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: sizeH * 0.02,
          ),
          InkWell(
            onTap: () {
              if (widget.type == 'watch') {
                PageNavigateScreen().normalpushReplesh(context, Floatbar(1));
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: sizeH * 0.045,
              width: sizeW * 0.26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff377EB4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: sizeW * 0.015,
                  ),
                  Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
