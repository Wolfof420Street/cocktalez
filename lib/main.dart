
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cocktalez/app/components/app_scaffold.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/dimensions.dart';
import 'package:cocktalez/constants/theme_data.dart';
import 'package:cocktalez/di/app_logic.dart';
import 'package:cocktalez/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'constants/router.dart';
import 'di/intro_logic.dart';



Future<void> main() async {

   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  
  await SentryFlutter.init(
    (options) {
      options.dsn = sentryDsn;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)))

  );

  
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
        overlayWidgetBuilder: (ctx) => _overlayWidget(),
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



final container = ProviderContainer();


/// Add syntax sugar for quickly accessing the main "logic" controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.

AppLogic get appLogic => container.read(appLogicProvider);

IntroLogic get introLogic => container.read(introLogicProvider);

Dimensions get $dimensions => CocktaleAppScaffold.dimensions;
