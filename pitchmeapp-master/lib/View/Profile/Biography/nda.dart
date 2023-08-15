import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/confirmation_bio.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class NDAPage extends StatefulWidget {
  const NDAPage({super.key});

  @override
  State<NDAPage> createState() => _NDAPageState();
}

class _NDAPageState extends State<NDAPage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BannerWidget(onPressad: () {}),
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/images/17580.png',
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  },
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: DynamicColor.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.getSize25(context: context),
                    right: SizeConfig.getSize25(context: context)),
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: Text(
                        'NDA',
                        style: TextStyle(
                          color: DynamicColor.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Text(
                              'c. No failure or delay by any Party in exercising any right, power or privilege hereunder will operate as a waiver thereof nor will any single or partial exercise thereof preclude any other or further exercise thereof or the exercise of any other right, power or privilege that such Party may be entitled to under this Agreement or the law.',
                              style: TextStyle(
                                fontSize: sizeH * 0.022,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: Color(0xff377EB4),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'd. Either Party shall not assign its benefits, rights, duties and obligations under this Agreement, in whole or in part, to any third party without the prior written consent of the other Party.',
                              style: TextStyle(
                                fontSize: sizeH * 0.022,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: Color(0xff377EB4),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'e. This Agreement, including all attachments hereto, constitutes the entire agreement of the Parties with respect to the subject matter herein. This Agreement supersedesin its entirety any and all other agreements or negotiations, oral or written between the Parties. The headings in this Agreement are for convenience of reference only and will not control or affect the meaning or construction of any provisions hereof.',
                              style: TextStyle(
                                fontSize: sizeH * 0.022,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: Color(0xff377EB4),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              BackArrow(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios),
            ],
          ),
          NDA2Page(pageController: pageController)
        ],
      ),
    );
  }
}

class NDA2Page extends StatefulWidget {
  PageController pageController;
  NDA2Page({super.key, required this.pageController});

  @override
  State<NDA2Page> createState() => _NDA2PageState();
}

class _NDA2PageState extends State<NDA2Page> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  BiographyController biographyController = Get.put(BiographyController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/17580.png',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.getSize25(context: context),
                  right: SizeConfig.getSize25(context: context)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.getSize50(context: context)),
                  InkWell(
                    onTap: () {
                      widget.pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: DynamicColor.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'e. This Agreement, including all attachments hereto, constitutes the entire agreement of the Parties with respect to the subject matter herein. This Agreement supersedesin its entirety any and all other agreements or negotiations, oral or written between the Parties. The headings in this Agreement are for convenience of reference only and will not control or affect the meaning or construction of any provisions hereof.',
                    style: TextStyle(
                      fontSize: sizeH * 0.022,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: Color(0xff377EB4),
                    ),
                  ),
                  SizedBox(height: 30),
                  // biographyController.signature.path.contains('https')
                  biographyController.signatureStatus == 2
                      ? Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 160,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: DynamicColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: DynamicColor.darkBlue, width: 2)),
                              child: Text(
                                // biographyController.signatureStatus == 2
                                //     ?
                                'signature verified'.toUpperCase(),
                                //: 'signature not verified'.toUpperCase(),
                                style: blue19,
                              ),
                            ),
                            Container(
                              height: SizeConfig.getSize35(context: context),
                              width: SizeConfig.getSize35(context: context),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      // biographyController.signatureStatus == 2
                                      //     ?
                                      DynamicColor.blue,
                                  //: DynamicColor.redColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                // biographyController.signatureStatus == 2
                                //     ?
                                Icons.check,
                                //: Icons.close,
                                color: DynamicColor.white,
                              ),
                            )
                          ],
                        )
                      : Container(
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: DynamicColor.darkBlue, width: 2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SfSignaturePad(
                              key: _signaturePadKey,
                              minimumStrokeWidth: 1,
                              maximumStrokeWidth: 3,
                              strokeColor: DynamicColor.blue,
                              backgroundColor: DynamicColor.white,
                              onDraw: (offset, time) {
                                setState(() {
                                  biographyController.isSignature.value = true;
                                });
                              },
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  biographyController.signature.path.contains('https')
                      ? Container()
                      : Text('Signature'.toUpperCase(), style: darkBlue19),
                  SizedBox(height: 50),
                  biographyController.signature.path.contains('https')
                      ? InkWell(
                          onTap: () {
                            Get.to(() => ConfirmationBio());
                          },
                          child: Container(
                            height: 6.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff377EB4),
                            ),
                            child: Text(
                              "Accepted",
                              style: white15TextStyle,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  //_signaturePadKey.currentState!.clear();
                                  setState(() {
                                    if (biographyController.isSignature.value) {
                                      biographyController
                                          .handleSaveButtonPressed(
                                              _signaturePadKey, 'NotAccept');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please give your signature',
                                          gravity: ToastGravity.CENTER);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 6.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Color(0xff377EB4),
                                  ),
                                  child: Text(
                                    "Do Not Accept",
                                    style: white15TextStyle,
                                  ), // the sorcerer's apprentice
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
                                  setState(() {
                                    if (biographyController.isSignature.value) {
                                      biographyController
                                          .handleSaveButtonPressed(
                                              _signaturePadKey, 'Accept');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please give your signature',
                                          gravity: ToastGravity.CENTER);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 6.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    color: Color(0xff377EB4),
                                  ),
                                  child: Text(
                                    "Accept",
                                    style: white15TextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    biographyController.isSignature.value = false;
    _signaturePadKey.currentState!.clear();
    super.dispose();
  }
}
