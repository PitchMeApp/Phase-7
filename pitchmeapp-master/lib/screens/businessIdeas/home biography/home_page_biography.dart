import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/under_progress_limitation.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Feedback/controller.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/devApi%20Service/post_api.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/confirmation_chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBiographyPage extends StatefulWidget {
  String type;
  String userID;
  String notifyID;
  HomeBiographyPage(
      {super.key,
      required this.type,
      required this.userID,
      required this.notifyID});

  @override
  State<HomeBiographyPage> createState() => _HomeBiographyPageState();
}

class _HomeBiographyPageState extends State<HomeBiographyPage> {
  HomeBiographyController controller = Get.put(HomeBiographyController());
  FeebackController feebackController = Get.put(FeebackController());
  List getChat = [];
  dynamic chatData;
  @override
  void initState() {
    if (widget.notifyID.isNotEmpty) {
      feebackController.readAllNotiApi(widget.notifyID);
    }

    controller.getBioApi(widget.userID);
    getChatApi(widget.userID);

    super.initState();
  }

  Future getChatApi(reseverID) async {
    try {
      await PostApiServer().getChatDetailApi(reseverID).then((value) {
        getChat = value['result'];
        if (getChat.isNotEmpty) {
          createChat();
        }
        // isLoading.value = false;
        //log(getChat.toString());
      });
    } catch (e) {
      getChat = [];
      //isLoading.value = false;
    }
  }

  void createChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {'sendorid': senderID, 'recieverid': widget.userID};
    socket.emit('createchat', onCreate);
    socket.on('receive_user', (data) {
      chatData = data;
      //log('chat create = ' + chatData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              color: DynamicColor.blue,
              height: MediaQuery.of(context).size.height * 0.235,
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: DynamicColor.blue,
                  ))
                : Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.getSize60(context: context) +
                                SizeConfig.getSize20(context: context),
                          ),
                          msgText(),
                          biodata(),
                          //    SizedBox(height: 15),
                          userDataFields()
                        ],
                      ),
                      CustomAppbar(
                        title: 'BIOGRAPHY',
                        colorTween: 'BIOGRAPHY',
                        onPressad: () {
                          PageNavigateScreen().push(
                              context,
                              ManuPage(
                                title: 'BIOGRAPHY',
                                pageIndex: 4,
                                isManu: 'Manu',
                              ));
                        },
                        onPressadForNotify: () {},
                      ),
                    ],
                  );
          }),
          NewCustomBottomBar(
            index: 4,
            isBack: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackArrow(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    if (widget.type == 'watch') {
                      PageNavigateScreen()
                          .normalpushReplesh(context, Floatbar(1));
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icons.arrow_back_ios),
              widget.type == 'back'
                  ? Container()
                  : BackArrow(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        if (controller.bioDoc != null) {
                          if (getChat.isNotEmpty) {
                            PageNavigateScreen().normalpushReplesh(
                                context,
                                ChatPage(
                                  id: chatData['messages']['_id'],
                                  recieverid: controller.bioDoc == null
                                      ? ''
                                      : controller.bioDoc!.userid,
                                  name: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.user.username,
                                  img: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.picture,
                                  userID: controller.bioDoc == null
                                      ? ''
                                      : controller.bioDoc!.userid,
                                ));
                          } else {
                            PageNavigateScreen().normalpushReplesh(
                                context,
                                ConfirmationChat(
                                  id: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.userid,
                                  recieverid: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.userid,
                                  name: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.user.username,
                                  img: controller.bioDoc == null
                                      ? null
                                      : controller.bioDoc!.picture,
                                ));
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Profile not verified for chat',
                              gravity: ToastGravity.CENTER);
                        }
                      },
                      icon: Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }

  Widget msgText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          TextStrings.textKey['bio_text']!,
          style: white13TextStyle,
          textAlign: TextAlign.center,
        ),
        Text(TextStrings.textKey['bio_text2']!,
            style: white13TextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget biodata() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HomeCircleBox(
                title: 'ID',
                title2: '',
                checkApprove: controller.idImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: blue17,
              ),
              SizedBox(
                height: 10,
              ),
              HomeCircleBox(
                title: 'Face',
                title2: 'Check',
                checkApprove: controller.fackCheckImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: blue10,
              )
            ],
          ),
          profilePitcher(),
          Column(
            children: [
              HomeCircleBox(
                title: 'Skill',
                title2: 'Certificate',
                checkApprove: controller.skillImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: blue10,
              ),
              SizedBox(
                height: 10,
              ),
              HomeCircleBox(
                title: 'Proof',
                title2: 'Funds',
                checkApprove: controller.proofImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: blue10,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profilePitcher() {
    return Container(
      height: SizeConfig.getSize100(context: context),
      width: SizeConfig.getSize100(context: context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: DynamicColor.white, borderRadius: BorderRadius.circular(100)),
      child: controller.bioDoc != null &&
              controller.bioDoc!.picture.contains('https')
          ? Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 63,
                  backgroundColor: DynamicColor.white,
                  backgroundImage: NetworkImage(controller.bioDoc!.picture),
                ),
                Container(
                  height: SizeConfig.getSize30(context: context),
                  width: SizeConfig.getSize30(context: context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.check,
                    color: DynamicColor.white,
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(7),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DynamicColor.darkBlue,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'Pending',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: DynamicColor.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: SizeConfig.getSize30(context: context),
                    width: SizeConfig.getSize30(context: context),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DynamicColor.redColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.close,
                      color: DynamicColor.white,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget userDataFields() {
    return Column(
      children: [
        Obx(() {
          return Text(
            'Name:' + controller.userName.value,
            style: TextStyle(
              color: DynamicColor.blue,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          );
        }),
        CustomBioFields(
          image: 'assets/images/people.png',
          isHttp: controller.logType.value.isNotEmpty
              ? controller.logType.value
              : null,
          title: controller.logType.value.isNotEmpty
              ? controller.logType.value
              : 'USER TYPE',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_place_24px.png',
          title: 'LOCATION',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/maintenance.png',
          title: 'SKILL',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/education-cap-svgrepo-com.png',
          title: 'EDUCATION',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/business-svgrepo-com.png',
          title: 'EXPERIENCE',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_monetization_on_24px.png',
          title: 'WEALTH',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_cancel_24px.png',
          title: 'ADD',
          onTap: () {
            PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        Text(
          'ID, Face Check, Funds and Certificate will not be visible to Users',
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.fackCheckImageStatus = 0;
    controller.idImageStatus = 0;
    controller.proofImageStatus = 0;
    controller.skillImageStatus = 0;
    controller.userName.value = '';
    super.dispose();
  }
}
