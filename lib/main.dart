import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cocktalez/app/components/app_scaffold.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/dimensions.dart';
import 'package:cocktalez/constants/theme_data.dart';
import 'package:cocktalez/di/app_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app/cocktails/ui/pages/home_page.dart';
import 'constants/router.dart';
import 'di/intro_logic.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  registerSingletons();
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));

   await appLogic.bootstrap();

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 933),
      minTextAdapt: true,
      builder: (context, child) => child!,
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: _overlayWidget(),
        child: AdaptiveTheme(
            dark: AppTheme.darkTheme,
            light: AppTheme.lightTheme,
            initial: widget.savedThemeMode ?? AdaptiveThemeMode.system,
            builder: (theme, darkTheme) => MaterialApp.router(
                  title: 'Cocktalez',
                  theme: theme,
                  darkTheme: darkTheme,
                  debugShowCheckedModeBanner: false,
                  routerDelegate: appRouter.routerDelegate,
                  routeInformationProvider: appRouter.routeInformationProvider,
                  routeInformationParser: appRouter.routeInformationParser,
                )),
      ),
    );
  }
}

Widget _overlayWidget() {
  return const Center(
    child: CircularProgressIndicator(
      color: AppColors.secondary,
    ),
  );
}

void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());

  // Intro
  GetIt.I.registerLazySingleton<IntroLogic>(() => IntroLogic());
}


/// Add syntax sugar for quickly accessing the main "logic" controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.

AppLogic get appLogic => GetIt.I.get<AppLogic>();

IntroLogic get introLogic => GetIt.I.get<IntroLogic>();

Dimensions get $dimensions => CocktaleAppScaffold.dimensions;
