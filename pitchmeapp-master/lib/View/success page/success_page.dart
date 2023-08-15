import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/success%20page/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../utils/styles/styles.dart';
import '../posts/posts.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({
    super.key,
  });

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  final SuccessPageController _controller = Get.put(SuccessPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.blue,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/complete.png",
                height: 120,
              ),
              Image.asset(
                "assets/image/handshake.png",
                // height: MediaQuery.of(context).size.height * 0.3,
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Image.asset(
              //       "assets/images/handshake.png",
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 18, bottom: 20),
              //       child: Image.asset(
              //         "assets/images/wing.png",
              //         width: 80,
              //         height: 80,
              //       ),
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "You have successfully sent your Sales Pitch for Approval.",
                  style: white21wBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Obx(() {
            return _controller.isLoading.value == true
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: InkWell(
                        onTap: () {
                          PageNavigateScreen()
                              .pushRemovUntil(context, PostPage());
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                          color: Color.fromARGB(255, 177, 206, 229),
                        ),
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
