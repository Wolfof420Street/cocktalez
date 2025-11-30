import 'package:flutter/widgets.dart';
import '../fluid_nav_bar/fluid_icon_data.dart';

class AdaptiveNavItem {
  const AdaptiveNavItem({
    required this.label,
    required this.icon,
    required this.fluidIcon,
    required this.screen,
  });

  final String label;
  final IconData icon;          // For iOS (Cupertino)
  final FluidFillIconData fluidIcon; // For Android (FluidNavBar)
  final Widget screen;          // The page to show
}
