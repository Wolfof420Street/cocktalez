import 'package:cocktalez/constants/platform_info.dart';
import 'package:cocktalez/di/save_load_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final introLogicProvider = Provider<IntroLogic>((ref) => IntroLogic());
class IntroLogic with ThrottledSaveLoadMixin {
 
  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final isSearchPanelOpen = ValueNotifier<bool>(true)
    ..addListener(scheduleSave);

  final bool useBlurs = !PlatformInfo.isAndroid;
  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value = value['hasDismissedSearchMessage'] ?? false;
    isSearchPanelOpen.value = value['isSearchPanelOpen'] ?? false;
  }

  @override
  String get fileName => 'settings.dat';

  @override
  Map<String, dynamic> toJson() {
 return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
      'isSearchPanelOpen': isSearchPanelOpen.value,
    };
  }
}
