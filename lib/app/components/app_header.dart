
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/app_icons.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'circle_buttons.dart';

class AppHeader extends StatelessWidget {
  const AppHeader(
      {Key? key,
        this.title,
        this.subtitle,
        this.showBackBtn = true,
        this.isTransparent = false,
        this.onBack,
        this.trailing,
        this.backIcon = AppIcons.prev,
        this.backBtnSemantics})
      : super(key: key);
  final String? title;
  final String? subtitle;
  final bool showBackBtn;
  final AppIcons backIcon;
  final String? backBtnSemantics;
  final bool isTransparent;
  final VoidCallback? onBack;
  final Widget Function(BuildContext context)? trailing;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isTransparent ? Colors.transparent : Theme.of(context).cardColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64 * $dimensions.scale,
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Row(children: [
                    Gap($dimensions.insets.sm),
                    if (showBackBtn)
                      BackBtn(
                        onPressed: onBack,
                        icon: backIcon,
                        semanticLabel: backBtnSemantics,
                      ),
                    const Spacer(),
                    if (trailing != null) trailing!.call(context),
                    Gap($dimensions.insets.sm),
                    //if (showBackBtn) Container(width: $styles.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
                  ]),
                ),
              ),
              MergeSemantics(
                child: Semantics(
                  header: true,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w500),),

                        if (subtitle != null)
                          Text(
                            subtitle!.toUpperCase(),

                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
