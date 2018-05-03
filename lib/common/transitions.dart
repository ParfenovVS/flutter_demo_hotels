import 'package:flutter/material.dart';

const DEFAULT_SLIDE_IN_DURATION = const Duration(milliseconds: 100);

class Transitions {
  static RouteTransitionsBuilder slideInTransitionsBuilder() {
    return (_, animation, __, child) {
      return new SlideTransition(
        position: new Tween(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    };
  }
}
