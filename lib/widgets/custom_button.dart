import 'package:flutter/material.dart';
import 'package:mohasabi/config/config.dart';

import 'custom_text.dart';


class CustomButton extends StatelessWidget {
  final String text;

  final Color color;
  final Color textColor;


  final Function onPress;

  CustomButton({
    @required this.onPress,
    this.text = 'اكتب',
    this.color = AppColors.LightGold, this.textColor=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(10.0) ),
          backgroundColor: color,
        ),
        onPressed: onPress,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: textColor,
          height: 1.5,
        ),
      ),
    );
  }
}
