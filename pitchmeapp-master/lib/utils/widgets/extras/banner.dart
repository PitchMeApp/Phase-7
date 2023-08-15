import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class BannerWidget extends StatelessWidget {
  VoidCallback onPressad;
  BannerWidget({super.key, required this.onPressad});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width - 40,
      child: InkWell(
        onTap: null,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            // width: Get.width,
            // height: Get.height * 0.065,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.bannerColor,
            ),
            child: Center(
              child: Text(
                'Banner',
                style: TextStyle(
                    color: colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
