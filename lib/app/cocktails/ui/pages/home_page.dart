import 'package:cocktalez/app/cocktails/ui/pages/cocktails_page.dart';
import 'package:cocktalez/app/cocktails/ui/pages/glasses_page.dart';
import 'package:cocktalez/app/components/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../ingredients/ui/pages/ingredients_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget _child;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _child = const CocktailsPage();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _child = const CocktailsPage();
          break;
        case 1:
          _child = const IngridientsPage();
          break;
        case 2:
          _child = const GlassesPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    if (isTablet) {
      // Tablet layout with side navigation
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Row(
          children: [
            // Side Navigation Rail
            NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: _handleNavigationChange,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.local_bar_outlined),
                  selectedIcon: Icon(Icons.local_bar),
                  label: Text('Cocktails'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.liquor_outlined),
                  selectedIcon: Icon(Icons.liquor),
                  label: Text('Ingredients'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.wine_bar_outlined),
                  selectedIcon: Icon(Icons.wine_bar),
                  label: Text('Glasses'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // Main content area
            Expanded(
              child: _child,
            ),
          ],
        ),
      );
    }

    // Phone layout with bottom navigation
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
    );
  }
}