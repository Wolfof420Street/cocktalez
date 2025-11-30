import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../fluid_nav_bar/fluid_nav_bar.dart';
import 'adaptive_nav_item.dart';
import 'platform_provider.dart';

class AdaptiveRootScaffold extends ConsumerWidget {
  const AdaptiveRootScaffold({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final List<AdaptiveNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;

    if (isIos) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            );
          }).toList(),
          currentIndex: currentIndex,
          onTap: onTabSelected,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) => items[index].screen,
          );
        },
      );
    } else {
      return Scaffold(
        body: items[currentIndex].screen,
        bottomNavigationBar: FluidNavBar(
          icons: items.map((e) => e.fluidIcon).toList(),
          onChange: onTabSelected,
        ),
      );
    }
  }
}
