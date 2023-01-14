import 'package:flutter/material.dart';

class HelperFunctions {
  static Widget wrapWithAnimatedBuilder({
     Animation<Offset> animation,
     Widget child,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => FractionalTranslation(
        translation: animation.value,
        child: child,
      ),
    );
  }
}
