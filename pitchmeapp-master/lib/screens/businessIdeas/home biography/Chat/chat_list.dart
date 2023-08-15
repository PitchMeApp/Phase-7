import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/Model/model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_appsupports.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  final ChatController chatController = Get.put(ChatController());
  StreamController<ChatListModel> controller =
      StreamController<ChatListModel>();

  dynamic adminchatlist;
  dynamic adminmessage;
  dynamic adminunread = 0;
  String datetime = '';
  @override
  void initState() {
    //Colors.white.withOpacity(0.3)
    getUserList();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    _colorTween = ColorTween(begin: DynamicColor.white, end: DynamicColor.white)
        .animate(_animationController);

    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });

    super.initState();
  }

  void getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {'sendorid': senderID};
    socket.emit('join_user', onCreate);
    socket.emit('join_admin', onCreate);
    socket.on('receive_users_admin', (data) {
      //log('check = ' + data.toString());
      if (data['messages'].length > 0 && senderID == data['roomid']) {
        adminchatlist = data['messages'][0]['chat']['_id'];
        adminunread = data['messages'][0]['unread'];
        adminmessage = data['messages'][0]['message'];
      }
    });
    socket.on('receive_users', (data) {
      ChatListModel chatListModel = ChatListModel.fromJson(data);
      controller.add(chatListModel);
      log(data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar:
        body: Stack(children: [
          SizedBox(
            child: Image.asset(
              'assets/images/17580.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(160),
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          color: DynamicColor.blue,
                          height: MediaQuery.of(context).size.height * 0.235,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.getSize60(
                                            context: context) +
                                        SizeConfig.getSize20(context: context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: SizeConfig.getFontSize25(
                                            context: context),
                                        right: SizeConfig.getFontSize25(
                                            context: context)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppBarIconContainer(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          height: SizeConfig.getSize50(
                                              context: context),
                                          width: SizeConfig.getSize50(
                                              context: context),
                                          colorTween: _colorTween,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: DynamicColor.blue,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Image.asset(
                                "assets/image/handshake.png",
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      aapSupporter(),
                      list(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomAppbar(
            title: 'CHATS',
            colorTween: 'BIOGRAPHY',
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: 'CHATS',
                    pageIndex: 4,
                    isManu: 'Manu',
                  ));
            },
            onPressadForNotify: () {},
          ),
          NewCustomBottomBar(
            index: 3,
            isBack: true,
          ),
        ]));
  }

  Widget list() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize20(context: context),
          right: SizeConfig.getFontSize20(context: context)),
      child: StreamBuilder<ChatListModel>(
          stream: controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSize100(context: context),
                      bottom: SizeConfig.getSize60(context: context)),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: DynamicColor.blue,
                  )),
                );
              default:
                if (snapshot.hasError) {
                  // log(snapshot.error.toString());
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.getSize60(context: context)),
                      child: const Center(child: Text('No chats available')));
                } else if (snapshot.data!.messages.isEmpty) {
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.getSize60(context: context)),
                      child: const Center(child: Text('No chats available')));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.messages.length,
                      itemBuilder: (context, index) {
                        Message data = snapshot.data!.messages[index];
                        //log('cht = ' + data.toJson().toString());
                        if (data.message != null) {
                          int ts = data.message!.time;
                          DateTime tsdate =
                              DateTime.fromMillisecondsSinceEpoch(ts * 1000);
                          datetime = DateFormat('h:mm a').format(tsdate);
                        }

                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                PageNavigateScreen().push(
                                    context,
                                    ChatPage(
                                      id: data.chat.id,
                                      recieverid: data.user.id,
                                      img: data.user.profilePic,
                                      name: data.user.username,
                                      userID: data.user.id,
                                      back: 'back',
                                    ));
                              },
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 5.0,
                              minLeadingWidth: 0.0,
                              leading: CachedNetworkImage(
                                height: 12.h,
                                width: 12.w,
                                imageUrl: data.user.profilePic,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: DynamicColor.white,
                                        backgroundImage: imageProvider),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                  color: DynamicColor.blue,
                                )),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: DynamicColor.white,
                                  child: Icon(
                                    Icons.person,
                                    size: 28,
                                    color: DynamicColor.blue,
                                  ),
                                ),
                              ),
                              title: Text(
                                data.user.username,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (data.message) != null
                                      ? data.message!.voice != ''
                                          ? Text(
                                              'Audio',
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                  (data.message) != null
                                      ? data.message!.image != ''
                                          ? Text(
                                              'Image',
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                  (data.message) != null
                                      ? data.message!.message != ''
                                          ? Text(
                                              data.message!.message,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    child: Text(
                                      datetime,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: DynamicColor.hintclr),
                                    ),
                                  ),
                                  data.unread != 0
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: DynamicColor.blue,
                                            child: Text(
                                              data.unread.toString(),
                                              style: white13TextStyle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0,
                            )
                          ],
                        );
                      });
                }
            }
          }),
    );
  }

  Widget aapSupporter() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize20(context: context),
          right: SizeConfig.getFontSize20(context: context)),
      child: Column(
        children: [
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {
              PageNavigateScreen().push(
                  context,
                  AppSupporterChatPage(
                    img: '',
                    name: 'Pitch Me App',
                    id: adminchatlist,
                    recieverid: 'admin',
                    back: 'back',
                  ));
            },
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 5.0,
            minLeadingWidth: 0.0,
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('assets/image/handshake.png'),
              backgroundColor: DynamicColor.blue,
            ),
            title: Text(
              'Pitch Me App Support',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'How can we help?',
              // adminmessage != null
              //     ? adminmessage['message']
              //     : 'How can we help?',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: DynamicColor.hintclr, fontWeight: FontWeight.w400),
            ),
            trailing: Column(
              children: [
                adminunread != 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: DynamicColor.blue,
                          child: Text(
                            adminunread.toString(),
                            style: white13TextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //controller.close();
    _animationController.dispose();

    super.dispose();
  }
}
