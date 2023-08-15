import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class BackArrow extends StatelessWidget {
  Alignment? alignment;
  VoidCallback onPressed;
  IconData icon;
  BackArrow({
    super.key,
    this.alignment,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            icon,
            size: 30,
            color: DynamicColor.blue,
          ),
        ),
      ),
    );
  }
}
