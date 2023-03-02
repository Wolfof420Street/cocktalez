import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app/cocktails/ui/pages/home_page.dart';

void main() async {
 
 WidgetsFlutterBinding.ensureInitialized();
 final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));
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
            builder: (theme, darkTheme) => GetMaterialApp(
                  title: 'Cocktalez',
                  theme: theme,
                  darkTheme: darkTheme,
                  debugShowCheckedModeBanner: false,
                  home: const MyHomePage(),
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

