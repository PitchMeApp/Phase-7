import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/addImage_page.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/custom_header_view.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

class SelectionPersonPage extends StatefulWidget {
  const SelectionPersonPage({super.key});

  @override
  State<SelectionPersonPage> createState() => _SelectionPersonPageState();
}

class _SelectionPersonPageState extends State<SelectionPersonPage> {
  OfferPageController controller = Get.put(OfferPageController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  final NavigationController _navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: SizeConfig.getSize100(context: context) +
                    SizeConfig.getSize55(context: context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.075),
              customBox(
                  controller.data[0]['value'], controller.data[0]['isSelected'],
                  onPressad: () {
                controller.selectedPerson.value = 'Anyone';
                setState(() {
                  if (controller.selectedPersonType.value.isNotEmpty &&
                      controller.selectedPersonType.value[0]['value'] !=
                          'Anyone') {
                    for (var element in controller.selectedPersonType.value) {
                      element['isSelected'] = false;
                    }
                    controller.selectedPersonType.value.clear();
                  }

                  controller.onselectValue(0);
                });
              }),
              SizedBox(height: 10),
              customBox(
                  controller.data[1]['value'], controller.data[1]['isSelected'],
                  onPressad: () {
                if (controller.selectedPerson.value != 'Anyone') {
                  controller.selectedPerson.value = 'Only Verified ID';
                  setState(() {
                    controller.onselectValue(1);
                  });
                }
              }),
              SizedBox(height: 10),
              customBox(
                  controller.data[2]['value'], controller.data[2]['isSelected'],
                  onPressad: () {
                if (controller.selectedPerson.value != 'Anyone') {
                  controller.selectedPerson.value = 'Only Verified Funds';
                  setState(() {
                    controller.onselectValue(2);
                  });
                }
              }),
              SizedBox(height: 10),
              customBox(
                  controller.data[3]['value'], controller.data[3]['isSelected'],
                  onPressad: () {
                if (controller.selectedPerson.value != 'Anyone') {
                  controller.selectedPerson.value = 'Only Verified Experience';
                  setState(() {
                    controller.onselectValue(3);
                  });
                }
              }),
              SizedBox(height: 10),
              customBox(
                  controller.data[4]['value'], controller.data[4]['isSelected'],
                  onPressad: () {
                if (controller.selectedPerson.value != 'Anyone') {
                  controller.selectedPerson.value = 'Only with NDA';
                  setState(() {
                    controller.onselectValue(4);
                  });
                }
              }),
            ],
          ),
          CustomHeaderView(
            title: TextStrings.textKey['who_can']!,
            icon: 'assets/images/ic_visibility_24px.png',
            subTitle: '',
            progressPersent: 0.6,
            padding: 1,
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
              controller.selectedPersonType.value.isNotEmpty
                  ? BackArrow(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        try {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_navigationController.navigationType.value ==
                              'Post') {
                            PageNavigateScreen().push(
                                context,
                                AddImagePage(
                                  key: abcKey,
                                ));
                          } else {
                            Navigator.of(context).pop();
                          }
                        } catch (e) {}
                      },
                      icon: Icons.arrow_forward_ios)
                  : Container(),
            ],
          ),
          NewCustomBottomBar(
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget customBox(String string, bool isSelected,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Container(
        height: 6.h,
        margin: EdgeInsets.only(
            left: SizeConfig.getSize40(context: context),
            right: SizeConfig.getSize40(context: context)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: DynamicColor.blue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          string,
          style: isSelected ? darkBlue15 : white15TextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
