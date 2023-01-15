import 'package:flutter/material.dart';
import 'package:mohasabi/config/config.dart';


import '../utils/helper_functions.dart';
import '../animations/change_screen_animation.dart';
import 'login_content.dart';

class TopText extends StatefulWidget {
  const TopText({Key key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: Text(
        ChangeScreenAnimation.currentScreen == Screens.createAccount
            ? 'انشاء\nحساب'
            : 'مرحبا \nبعودتك',
        style: const TextStyle(
        color: AppColors.White,
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
