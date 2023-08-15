import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';

class UnderDevLimitationPage extends StatefulWidget {
  UnderDevLimitationPage({
    super.key,
  });

  @override
  State<UnderDevLimitationPage> createState() => _UnderDevLimitationPageState();
}

class _UnderDevLimitationPageState extends State<UnderDevLimitationPage> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(
          onPressad: () {},
        ),
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
                height: sizeH * 0.15,
              ),
              SizedBox(
                width: sizeW - 40,
                child: Text(
                  'The page you are trying to access is currently under Development.',
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
