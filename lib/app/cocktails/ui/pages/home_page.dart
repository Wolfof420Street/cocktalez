import 'package:cocktalez/app/cocktails/ui/pages/categories_page.dart';
import 'package:cocktalez/app/cocktails/ui/pages/cocktails_page.dart';
import 'package:cocktalez/app/cocktails/ui/pages/glasses_page.dart';
import 'package:cocktalez/app/components/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:cocktalez/app/ingridients/ui/pages/ingredients_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Widget _child;


  @override
  void initState() {
    super.initState();
    _child = const CocktailsPage();
  }


    void _handleNavigationChange(int index) {
    setState(() {
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
        child: _child,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFF75B7E1),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
    );
  }
}
