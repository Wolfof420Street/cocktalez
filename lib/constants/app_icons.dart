import 'package:flutter/material.dart';


class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  @override
  Widget build(BuildContext context) {
    String i = icon.name.toLowerCase().replaceAll('_', '-');
    String path = 'assets/images/_common/icons/icon-$i.png';
    //print(path);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path,
            width: size, height: size, color: color ?? Colors.white12, filterQuality: FilterQuality.high),
      ),
    );
  }
}

enum AppIcons {
  close,
  closeLarge,
  collection,
  download,
  expand,
  fullscreen,
  fullscreenExit,
  info,
  menu,
  nextLarge,
  north,
  prev,
  resetLocation,
  search,
  shareAndroid,
  shareIos,
  timeline,
  wallpaper,
  zoomIn,
  zoomOut
}