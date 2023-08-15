import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/demo%20watch%20sales%20pitch/demo_watch_sales.dart';
import 'package:pitch_me_app/controller/businessIdeas/dashBoardController.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/StatisticsPage_Two.dart';
import 'package:pitch_me_app/screens/businessIdeas/postPage.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen_Two extends StatefulWidget {
  final Function(int index) currentPage;
  final Function(int index, String title, bool isFinish) onSwipe;
  String userType;
  DashBoardScreen_Two(
      {Key? key,
      required this.currentPage,
      required this.onSwipe,
      required this.userType})
      : super(key: key);

  @override
  State<DashBoardScreen_Two> createState() => _DashBoardScreen_TwoState();
}

class _DashBoardScreen_TwoState extends State<DashBoardScreen_Two> {
  final _controller = PageController();
  DashboardController controller = Get.put(DashboardController());
  PostPageController postPageController = Get.put(PostPageController());
  bool ChangeButton = false;

  String businesstype = '';
  String newUser = '';
  @override
  void initState() {
    super.initState();
    getUserType();
    controller.getPost2(widget.onSwipe,
        postPageController.swipableStackController.currentIndex);
    controller.getStatic();

    _controller.addListener(() {
      widget.currentPage(_controller.page!.toInt());
      setState(() {});
    });
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      businesstype = prefs.getString('log_type').toString();
      newUser = prefs.getString('new_user').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return PageView(
        controller: _controller,
        physics: (businesstype == '1' || businesstype == '2') ||
                newUser == 'New User'
            ? NeverScrollableScrollPhysics()
            : ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          controller.isLoadingPost2.value == true
              ? Center(child: CircularProgressIndicator())
              : controller.hasError.value
                  ? Center(
                      child: roboto(size: 20, text: 'Something went wrong'))
                  : controller.isFinish2.value
                      ? Stack(
                          children: [
                            Center(
                                child: roboto(
                                    size: 20, text: 'No more post available')),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.getSize10(context: context)),
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                      height: SizeConfig.getSize35(
                                          context: context),
                                      width: SizeConfig.getSize35(
                                          context: context),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Color.fromARGB(156, 0, 0, 0)
                                                        .withOpacity(0.5),
                                                blurRadius: 20,
                                                offset: Offset(
                                                  0,
                                                  0,
                                                ))
                                          ],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png")))),
                                ),
                              ),
                            ),
                          ],
                        )
                      : businesstype == '1' ||
                              businesstype == '2' ||
                              ((businesstype == '3' || businesstype == '4') &&
                                  (newUser == 'New User'))
                          ? DemoWatchSalesPitch(
                              // postModel: controller.salespitch!,
                              )
                          : PostPageWidget(
                              controller: _controller,
                              onSwipe:
                                  (int index, String title, bool isFinish) {
                                print("Is finish is $isFinish");
                                controller.isFinish2.value = isFinish;
                                widget.onSwipe(index, title, isFinish);
                              },
                              postModel: controller.salespitch!,
                            ),
          controller.isLoadingStats.value == true
              ? Center(child: CircularProgressIndicator())
              : controller.salespitch != null
                  ? StatisticsPage_Two(
                      pagecont: _controller,
                      salesDoc: controller.salespitch!.result.docs[
                          postPageController
                              .swipableStackController.currentIndex],
                    )
                  : Container()
        ],
      );
    }));
  }
}
