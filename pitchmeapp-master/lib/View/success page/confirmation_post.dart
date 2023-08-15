import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/custom_header_view.dart';
import 'package:pitch_me_app/View/success%20page/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';

class ConfirmationPost extends StatefulWidget {
  const ConfirmationPost({super.key});

  @override
  State<ConfirmationPost> createState() => _ConfirmationPostState();
}

class _ConfirmationPostState extends State<ConfirmationPost> {
  final SuccessPageController _controller = Get.put(SuccessPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BannerWidget(onPressad: () {
        print('object');
      }),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.getSize100(context: context) +
                    SizeConfig.getSize55(context: context),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text(
                    "Are you sure you want to send this Sales Pitch for Approval?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Color(0xff377EB4)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.24,
                padding: EdgeInsets.only(bottom: 20),
                child: Obx(() {
                  return _controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: DynamicColor.blue),
                        )
                      : Container(
                          height: 36,
                        );
                }),
              )
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
            child: whiteBorderContainer(
                child: Image.asset('assets/image/Group 12261.png'),
                color: Colors.transparent,
                height: SizeConfig.getSizeHeightBy(context: context, by: 0.15),
                width: SizeConfig.getSizeHeightBy(context: context, by: 0.15),
                cornerRadius: 25),
          ),
          CustomHeaderView(
            title: '',
            icon: '',
            subTitle: '',
            progressPersent: 1,
            padding: 0,
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
                return _controller.isLoading.value == true
                    ? Container()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: InkWell(
                            onTap: () {
                              _controller.postSalesPitch(context);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: DynamicColor.blue,
                            ),
                          ),
                        ),
                      );
              })
            ],
          )
        ],
      ),
    );
  }
}
//Color.fromARGB(255, 177, 206, 229)