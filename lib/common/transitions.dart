import 'package:flutter/material.dart';

const DEFAULT_SLIDE_IN_DURATION = const Duration(milliseconds: 200);

class Transitions {
  static RouteTransitionsBuilder fadeTransitionsBuilder() {
    return (_, animation, __, child) {
      return FadeTransition(
        opacity: Tween(
          begin: 0.0,
          end: 1.1,
        ).animate(animation),
        child: child,
      );
    };
  }
}
