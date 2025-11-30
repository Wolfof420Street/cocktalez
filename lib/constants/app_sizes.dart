

class AppSizes {
  final insets = const _Insets();
  final times = const _Times();
}

class _Insets {
  const _Insets();
  final double xs = 4;
  final double sm = 8;
  final double md = 12;
  final double lg = 16;
  final double xl = 24;
  final double xxl = 32;
  final double offset = 40;
}

class _Times {
  const _Times();
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
}

final $dimensions = AppSizes();
