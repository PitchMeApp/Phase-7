import 'package:flutter/material.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_appsupports.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationChat extends StatefulWidget {
  dynamic id;
  dynamic name;
  dynamic img;
  dynamic recieverid;
  ConfirmationChat({
    super.key,
    this.id,
    this.recieverid,
    this.name,
    this.img,
  });

  @override
  State<ConfirmationChat> createState() => _ConfirmationChatState();
}

class _ConfirmationChatState extends State<ConfirmationChat> {
  dynamic chatData;
  dynamic adminchatID;
  dynamic adminmessage;
  dynamic adminunread = 0;
  @override
  void initState() {
    createChat();
    super.initState();
  }

  void createChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {'sendorid': senderID, 'recieverid': widget.recieverid};
    socket.emit('createchat', onCreate);
    socket.on('receive_user', (data) {
      chatData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(
          onPressad: () {},
        ),
        body: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/17580.png',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02, top: 50),
                      child: Center(
                        child: Image.asset(
                          "assets/image/Group 12262.png",
                          height: sizeH * 0.08,
                        ),
                      ),
                    )),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02),
                      child: Image.asset(
                        "assets/image/Group 12261.png",
                        height: sizeH * 0.20,
                      ),
                    )),
                  ],
                ),
                // SizedBox(
                //   height: sizeH * 0.15,
                // ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'start communication with',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'this Person?',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: sizeH * 0.30,
                )
              ],
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
                BackArrow(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      if (widget.name == 'Pitch Me App') {
                        PageNavigateScreen().normalpushReplesh(
                            context,
                            AppSupporterChatPage(
                              id: adminchatID,
                              recieverid: 'admin',
                              name: 'Pitch Me App',
                              img: '',
                            ));
                      } else {
                        PageNavigateScreen().normalpushReplesh(
                            context,
                            ChatPage(
                              id: chatData['messages']['_id'],
                              recieverid: widget.recieverid,
                              name: widget.name,
                              img: widget.img,
                              userID: widget.id,
                            ));
                      }
                    },
                    icon: Icons.arrow_forward_ios),
              ],
            ),
          ],
        ));
  }
}
