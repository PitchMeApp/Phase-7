import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/controller/businessIdeas/home_filter_controller.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

class HomePageFilter extends StatefulWidget {
  const HomePageFilter({super.key});

  @override
  State<HomePageFilter> createState() => _HomePageFilterState();
}

class _HomePageFilterState extends State<HomePageFilter> {
  HomeFilterController controller = Get.put(HomeFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Choose what type of Videos you want to see',
                style: blue12,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.119),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  dynamic data = controller.data[index];
                  return CustomListBox(
                      icon: '',
                      title: data['value'],
                      titleColor: data['isSelected'],
                      onPressad: () {
                        setState(() {
                          controller.onselectValue(index);
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
