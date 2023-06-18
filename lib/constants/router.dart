import 'dart:async';

import 'package:cocktalez/app/cocktails/ui/pages/cocktail_details_page.dart';
import 'package:cocktalez/app/cocktails/ui/pages/home_page.dart';
import 'package:cocktalez/app/ingridients/ui/pages/cocktails_by_ingridient_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/glass/ui/pages/cocktail_by_glass_page.dart';
import '../app/intro/intro_screen.dart';
import '../main.dart';

/// Shared paths / urls used across the app
class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = '/settings';
  static String cocktailDetails(String id) => '/cocktail/$id';
  static String searchPage = '/search';
  static String cocktailByIngredientScreen(String ingredient) => '/ingredient/$ingredient';
  static String cocktailByGlassScreen(String glass) => '/glasses/$glass';

}

/// Routing table, matches string paths to UI Screens, optionally parses params from the paths
final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    AppRoute(ScreenPaths.splash, (_) => Container(color: Colors.grey)), // This will be hidden
    AppRoute(ScreenPaths.home, (_) => const MyHomePage()),
    AppRoute(ScreenPaths.intro, (_) => const IntroScreen()),
    AppRoute('/ingredient/:ingredient', (s) {
      return CocktailsByIngridientPage(
        ingridient: s.pathParameters['ingredient']!,
      );
    }, useFade: true),
     AppRoute('/glasses/:glass', (s) {
      return CocktailByGlassPage(
        glass: s.pathParameters['glass']!,
      );
    }, useFade: true),
    AppRoute('/cocktail/:id', (s) {
      return CocktailDetailsPage(
        id: s.pathParameters['id']!,
      );
    }, useFade: true),
    
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

FutureOr<String?> _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}
  