import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

class SuccessBioPage extends StatefulWidget {
  const SuccessBioPage({
    super.key,
  });

  @override
  State<SuccessBioPage> createState() => _SuccessBioPageState();
}

class _SuccessBioPageState extends State<SuccessBioPage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.blue,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(
                "assets/images/complete.png",
                height: 120,
              ),
              Image.asset(
                "assets/image/handshake.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "You have successfully sent your Biography for Approval.",
                  style: white21wBold,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.delete<BiographyController>(force: true);
                  Get.offAll(() => Floatbar(0));
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width - 45,
                    decoration: BoxDecoration(
                        color: DynamicColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Great',
                      style: blue28,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
