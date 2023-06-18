

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';


@immutable
class Dimensions {


  late final double scale;

   /// Padding and margin values
  late final _Insets insets = _Insets(scale);

    /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  /// Animation Durations
  final _Times times = _Times();



  /// Shared sizes
  late final _Sizes sizes = _Sizes();

  
  Dimensions({
   Size? screenSize
  }) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;
    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = .9; // phone
    } else {
      scale = .85; // small phone
    }

    debugPrint('screenSize=$screenSize, scale=$scale');
  }



}


@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

class _Sizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;
  final Size minAppSize = Size(380, 675);
}



@immutable
class _Insets {
  _Insets(this._scale);
  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class _Times {
  final Duration fast = Duration(milliseconds: 300);
  final Duration med = Duration(milliseconds: 600);
  final Duration slow = Duration(milliseconds: 900);
  final Duration pageTransition = Duration(milliseconds: 200);
}
