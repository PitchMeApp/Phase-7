// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:io';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

Widget appLogoImage({double? height, double? width, bool isDark = true}) {
  return Image.asset(
    isDark ? Assets.appLogoDarkBluePng : Assets.appLogoPng,
    height: height,
    width: width,
    fit: BoxFit.fitWidth,
  );
}

Widget textFieldContainer(
    {double? height,
    double? width,
    required Widget child,
    double? cornerRadius = 24}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(width: 1.0, color: colors.white),
    ),
    child: child,
  );
}

Widget whiteBorderContainer(
    {Color? color,
    double? height,
    double? width,
    required Widget child,
    double cornerRadius = 30}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: (color == null) ? const Color(0xffffffff) : color,
      border: (color != null)
          ? null
          : Border.all(width: 1.0, color: const Color(0xff707070)),
    ),
    child: child,
  );
}

Widget whiteContainer(
    {double? height,
    double? width,
    required Widget child,
    double cornerRadius = 4}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: colors.white,
    ),
    child: child,
  );
}

class buttonContainer extends StatefulWidget {
  double? height;
  double? width;
  Widget child;
  bool? fromAppBar = false;
  double? cornerRadius = 10;
  Function() onTap;

  buttonContainer(
      {Key? key,
      this.height,
      this.width,
      required this.child,
      this.fromAppBar,
      required this.onTap,
      this.cornerRadius})
      : super(key: key);

  @override
  State<buttonContainer> createState() => _buttonContainerState();
}

class _buttonContainerState extends State<buttonContainer> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.cornerRadius == null) {
      widget.cornerRadius = 10;
    }
    if (widget.fromAppBar == null) {
      widget.fromAppBar = false;
    }
    return InkWell(
      onTap: () {
        isPressed = !isPressed;
        setState(() {});
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          widget.onTap();
          isPressed = !isPressed;
          setState(() {});
        });
      },
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.cornerRadius!),
              color: const Color(0xff377eb4),
              boxShadow: [
                if (!isPressed)
                  BoxShadow(
                    color: const Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 20,
                  ),
              ],
            ),
          ),
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.cornerRadius!),
              color: const Color(0xff377eb4),
              boxShadow: isPressed
                  ? [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(5, 5),
                        spreadRadius: 2,
                        inset: true,
                      ),
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                        offset: -Offset(5, 5),
                        inset: true,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: DynamicColor.blue,
                        offset: Offset(5, 5),
                        blurRadius: 20,
                      ),
                      BoxShadow(
                        color: DynamicColor.blue,
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                      ),
                      if (!widget.fromAppBar!)
                        BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 0.5,
                          color: colors.white.withOpacity(0.3),
                          offset: Offset(-8, -8),
                        )
                    ],
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class NewButtonContainer extends StatefulWidget {
  String title;
  String subTitle;
  int heroTage;
  VoidCallback onTap;
  NewButtonContainer({
    super.key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.heroTage,
  });

  @override
  State<NewButtonContainer> createState() => _NewButtonContainerState();
}

class _NewButtonContainerState extends State<NewButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          child: FloatingActionButton.extended(
              heroTag: widget.heroTage,
              backgroundColor: DynamicColor.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: widget.onTap,
              label: Text(
                widget.title,
                style: blue17,
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              widget.subTitle,
              style: white13TextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class BottomMenuContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget child;
  double cornerRadius;
  Function() onTap;

  BottomMenuContainer(
      {Key? key,
      this.height,
      this.width,
      required this.onTap,
      required this.child,
      this.cornerRadius = 50})
      : super(key: key);

  @override
  State<BottomMenuContainer> createState() => _BottomMenuContainerState();
}

class _BottomMenuContainerState extends State<BottomMenuContainer> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isPressed = !isPressed;
        setState(() {});
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          isPressed = !isPressed;
          widget.onTap();
          setState(() {});
        });
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        child: widget.child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          color: const Color(0xffe2e2e2),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                      color: colors.black.withOpacity(0.6),
                      offset: Offset(2, 2),
                      blurRadius: 7,
                      inset: true),
                  BoxShadow(
                      color: colors.black.withOpacity(0.6),
                      offset: Offset(-2, -2),
                      blurRadius: 7,
                      inset: true),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xffffffff),
                    offset: Offset(5, 5),
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: const Color(0xffffffff),
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                  ),
                ],
        ),
      ),
    );
  }
}

class AppBarIconContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget child;
  double cornerRadius;
  Animation? colorTween;
  VoidCallback? onTap;
  AppBarIconContainer({
    Key? key,
    this.height,
    this.width,
    required this.child,
    this.cornerRadius = 10,
    required this.colorTween,
    this.onTap,
  }) : super(key: key);

  @override
  State<AppBarIconContainer> createState() => _AppBarIconContainerState();
}

class _AppBarIconContainerState extends State<AppBarIconContainer> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.colorTween!,
        builder: (context, child) {
          return InkWell(
            onTap: widget.onTap,
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.cornerRadius),
                  color: widget.colorTween!.value,
                  boxShadow: isPressed
                      ? [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(5, 5),
                            spreadRadius: 2,
                            inset: true,
                          ),
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.3),
                            offset: -Offset(5, 5),
                            inset: true,
                          ),
                        ]
                      : []),
              child: widget.child,
            ),
          );
        });
  }
  // dev
}

class CircleBox extends StatelessWidget {
  String title;
  String title2;
  String imageType;
  dynamic isHttp;
  dynamic checkApprove;
  TextStyle textStyle;
  VoidCallback onPressad;
  CircleBox(
      {super.key,
      required this.title,
      required this.title2,
      required this.imageType,
      this.isHttp,
      this.checkApprove,
      required this.textStyle,
      required this.onPressad});

  @override
  Widget build(BuildContext context) {
    return isHttp != null && imageType.contains('https')
        ? Stack(
            alignment: Alignment.bottomRight,
            children: [
              InkWell(
                onTap: onPressad,
                child: Container(
                    height: SizeConfig.getSize60(context: context),
                    width: SizeConfig.getSize60(context: context),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DynamicColor.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: isHttp != null
                          ? imageType.contains('pdf')
                              ? Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  //padding: EdgeInsets.only(bottom: 10),
                                  child: Image.asset(
                                    'assets/images/pdf.png',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : imageType.contains('https://api')
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundColor: DynamicColor.white,
                                      backgroundImage: NetworkImage(imageType),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffE6E6E6),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            title,
                                            style: textStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                          title2.isEmpty
                                              ? Container()
                                              : Text(
                                                  title2,
                                                  style: textStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                        ],
                                      ),
                                    )
                          //  Container(
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //         color: checkApprove == 2 &&
                          //                 imageType.contains('https')
                          //             ? DynamicColor.blue
                          //             : DynamicColor.darkBlue,
                          //         borderRadius: BorderRadius.circular(100)),
                          //     child: Text(
                          //       checkApprove == 2 && imageType.contains('https')
                          //           ? 'Verified'
                          //           : checkApprove == 3
                          //               ? 'Not Verified'
                          //               : 'Pending',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 12,
                          //           color: DynamicColor.white),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   )
                          : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffE6E6E6),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: textStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  title2.isEmpty
                                      ? Container()
                                      : Text(
                                          title2,
                                          style: textStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                ],
                              ),
                            ),
                    )),
              ),
              checkApprove == 2 && imageType.contains('https')
                  ? Container(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: DynamicColor.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.check,
                        color: DynamicColor.white,
                        size: 18,
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: DynamicColor.redColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.close,
                          color: DynamicColor.white,
                          size: 18,
                        ),
                      ),
                    ),
            ],
          )
        : InkWell(
            onTap: onPressad,
            child: Container(
              height: SizeConfig.getSize60(context: context),
              width: SizeConfig.getSize60(context: context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: DynamicColor.white,
                  borderRadius: BorderRadius.circular(100)),
              child: imageType.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(100)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                            title2.isEmpty
                                ? Container()
                                : Text(
                                    title2,
                                    style: textStyle,
                                    textAlign: TextAlign.center,
                                  ),
                          ],
                        ),
                      ),
                    )
                  : imageType.contains('pdf')
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          //padding: EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assets/images/pdf.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: DynamicColor.white,
                          backgroundImage: FileImage(File(imageType)),
                        ),
            ),
          );
  }
}

class HomeCircleBox extends StatelessWidget {
  String title;
  String title2;

  dynamic isHttp;
  dynamic checkApprove;
  TextStyle textStyle;
  //VoidCallback onPressad;
  HomeCircleBox({
    super.key,
    required this.title,
    required this.title2,
    this.isHttp,
    this.checkApprove,
    required this.textStyle,
    // required this.onPressad
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        InkWell(
          //onTap: onPressad,
          child: Container(
              height: SizeConfig.getSize60(context: context),
              width: SizeConfig.getSize60(context: context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: DynamicColor.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                  padding: const EdgeInsets.all(7),
                  child:
                      // isHttp != null
                      //     ?
                      Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: checkApprove == 2
                            ? DynamicColor.blue
                            : DynamicColor.darkBlue,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      checkApprove == 2
                          ? 'Verified'
                          : checkApprove == 3
                              ? 'Not Verified'
                              : 'Pending',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: DynamicColor.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                  // : Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffE6E6E6),
                  //         borderRadius: BorderRadius.circular(100)),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           title,
                  //           style: textStyle,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         title2.isEmpty
                  //             ? Container()
                  //             : Text(
                  //                 title2,
                  //                 style: textStyle,
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //  ],
                  //),
                  //),
                  )),
        ),
        checkApprove == 2
            ? Container(
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: DynamicColor.blue,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.check,
                  color: DynamicColor.white,
                  size: 18,
                ),
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.redColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.close,
                    color: DynamicColor.white,
                    size: 18,
                  ),
                ),
              ),
      ],
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomBioFields extends StatelessWidget {
  String image;
  String title;
  dynamic isHttp;
  VoidCallback onTap;
  CustomBioFields({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.isHttp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize40(context: context),
          right: SizeConfig.getSize40(context: context)),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                decoration: BoxDecoration(
                    color: DynamicColor.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Image.asset(
                  image,
                  height: 25,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    color: isHttp != null
                        ? DynamicColor.blue
                        : DynamicColor.lightwhite,
                    fontSize: 16),
              ),
              Container(
                height: 40,
                width: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
