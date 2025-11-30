import 'package:cocktalez/app/cocktails/ui/pages/cocktails_page.dart';
import 'package:cocktalez/app/cocktails/ui/pages/glasses_page.dart';
import 'package:cocktalez/app/components/adaptive/adaptive_nav_item.dart';
import 'package:cocktalez/app/components/adaptive/adaptive_root_scaffold.dart';
import 'package:cocktalez/app/components/fluid_nav_bar/fluid_icon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ingredients/ui/pages/ingredients_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<AdaptiveNavItem> _navItems = [
    AdaptiveNavItem(
      label: 'Home',
      icon: CupertinoIcons.home,
      fluidIcon: FluidFillIcons.home,
      screen: const CocktailsPage(),
    ),
    AdaptiveNavItem(
      label: 'Feed',
      icon: CupertinoIcons.square_grid_2x2,
      fluidIcon: FluidFillIcons.window,
      screen: const IngridientsPage(),
    ),
    AdaptiveNavItem(
      label: 'Cocktails',
      icon: Icons.local_bar,
      fluidIcon: FluidFillIcons.glasses,
      screen: const GlassesPage(),
    ),
  ];

  void _handleNavigationChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveRootScaffold(
      items: _navItems,
      currentIndex: _currentIndex,
      onTabSelected: _handleNavigationChange,
    );
  }
}