

import 'package:cocktalez/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_context/sized_context.dart';

import '../../main.dart';
import 'app_scroll_behavior.dart';

class CocktaleAppScaffold extends StatelessWidget {
  const CocktaleAppScaffold({super.key, required this.child});
  final Widget child;
  static Dimensions get dimensions => _dimensions;
  static Dimensions _dimensions = Dimensions();

  @override
  Widget build(BuildContext context) {
    // Listen to the device size, and update AppStyle when it changes
    _dimensions = Dimensions(screenSize: context.sizePx);
    Animate.defaultDuration = _dimensions.times.fast;
    appLogic.handleAppSizeChanged(context.mq.size);
    return KeyedSubtree(
      key: ValueKey($dimensions.scale),
      child: Theme(
        data: Theme.of(context),
        // Provide a default texts style to allow Hero's to render text properly
        child: DefaultTextStyle(
          style: GoogleFonts.inter(
            fontSize: 13,
            
          ),
          // Use a custom scroll behavior across entire app
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}