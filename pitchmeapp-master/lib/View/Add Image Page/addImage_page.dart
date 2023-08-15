import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/controller.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';

import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../Custom header view/custom_header_view.dart';
import '../video page/video_page.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({super.key});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final AddImageController _addImageController = Get.put(AddImageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddImageController>(builder: (controller) {
      return Scaffold(
          body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize55(context: context),
                ),

                selectImages(),
                const SizedBox(height: 20),
                _imagesGridView(),
                // const SizedBox(height: 10),
                // Text(_addImageController.filePath)
                // _addFileButton()
              ],
            ),
          ),
          CustomHeaderView(
            title: TextStrings.textKey['add_image']!,
            icon: 'assets/images/add image.png',
            subTitle: TextStrings.textKey["add_image_sub"]!,
            progressPersent: 0.7,
            padding: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackArrow(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios),
              _addImageController.listImagePaths.isNotEmpty ||
                      _addImageController.filePath.isNotEmpty
                  ? BackArrow(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        if (_navigationController.navigationType.value ==
                            'Post') {
                          PageNavigateScreen().push(
                              context,
                              VideoPageMain(
                                key: abcKey,
                              ));
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icons.arrow_forward_ios)
                  : Container(),
            ],
          ),
          NewCustomBottomBar(
            index: 2,
          ),
        ],
      ));
    });
  }

  Widget selectImages() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _addImageController.selectImage(0);
          },
          child: Container(
            height: 44,
            // width: MediaQuery.of(context).size.width - 55,
            margin: EdgeInsets.only(
                top: 10,
                left: SizeConfig.getFontSize25(context: context),
                right: SizeConfig.getFontSize25(context: context)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.blue,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Picture 1',
              style: _addImageController.ischackIndex[0]['check']
                  ? darkBlue19
                  : white17wBold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _addImageController.selectImage(1);
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width - 55,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.blue,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Picture 2',
              style: _addImageController.ischackIndex[1]['check']
                  ? darkBlue19
                  : white17wBold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _addImageController.selectImage(2);
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width - 55,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.blue,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Picture 3',
              style: _addImageController.ischackIndex[2]['check']
                  ? darkBlue19
                  : white17wBold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _addImageController.selectImage(3);
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width - 55,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.blue,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Picture 4',
              style: _addImageController.ischackIndex[3]['check']
                  ? darkBlue19
                  : white17wBold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _addImageController.getDocumnetFile();
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width - 55,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.blue,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'File',
              style: _addImageController.filePath.isNotEmpty
                  ? darkBlue19
                  : white17wBold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _imagesGridView() {
    return _addImageController.listImagePaths.isEmpty &&
            _addImageController.filePath.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GridView.builder(
                padding: const EdgeInsets.only(left: 20, right: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _addImageController.listImagePaths.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 130,
                ),
                itemBuilder: (context, index) {
                  if (index == _addImageController.listImagePaths.length) {
                    return _addImageController.filePath.isNotEmpty
                        ? Container(
                            height: 120,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.only(bottom: 10),
                            child: Image.asset(
                              'assets/images/pdf.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container();
                  }
                  return Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Image.file(
                      File(
                          _addImageController.listImagePaths[index].toString()),
                      fit: BoxFit.contain,
                    ),
                  );
                }),
          );
  }

  // Widget _addButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       // setState(() {
  //       _addImageController.selectImages();
  //       //});
  //     },
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: 18, top: 18),
  //           child: Image.asset("assets/images/addback img.png"),
  //         ),
  //         Container(
  //           child: Image.asset(
  //             "assets/images/add icon.png",
  //             height: 30,
  //             width: 30,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _addFileButton() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         "Add a File",
  //         style: blue17,
  //       ),
  //       const SizedBox(height: 10),
  //       GestureDetector(
  //         onTap: () {
  //           //  setState(() {
  //           _addImageController.getDocumnetFile();
  //           //  });
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 10),
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               Image.asset(
  //                 'assets/images/ic_folder_open_.png',
  //                 height: 50,
  //                 width: 50,
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.only(bottom: 13, right: 17),
  //                 child: Image.asset(
  //                   "assets/images/add icon.png",
  //                   height: 14,
  //                   width: 14,
  //                   color: DynamicColor.blue,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Text(_addImageController.filePath)
  //     ],
  //   );
  // }
}
