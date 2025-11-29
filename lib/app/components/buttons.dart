
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:cocktalez/app/components/adaptive/adaptive_button.dart';
import '../../constants/app_icons.dart';

/// Shared methods across button types
Widget _buildIcon(BuildContext context, AppIcons icon, {required bool isSecondary, required double? size}) =>
    AppIcon(icon, color: isSecondary ? Colors.black : Colors.white, size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.bgColor,
    this.border,
  })  : _builder = null;

  AppBtn.from({
    super.key,
    required this.onPressed,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.minimumSize,
    this.bgColor,
    this.border,
    String? semanticLabel,
    String? text,
    AppIcons? icon,
    double? iconSize,
  })  : child = null,
        circular = false {
    if (semanticLabel == null && text == null) throw ('AppBtn.from must include either text or semanticLabel');
    this.semanticLabel = semanticLabel ?? text ?? '';
    _builder = (context) {
      if (text == null && icon == null) return const SizedBox.shrink();
      Text? txt = text == null
          ? null
          : Text(text.toUpperCase(),
              );
      Widget? icn = icon == null ? null : _buildIcon(context, icon, isSecondary: isSecondary, size: iconSize);
      if (txt != null && icn != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [txt, Gap($dimensions.insets.xs), icn],
        );
      } else {
        return (txt ?? icn)!;
      }
    };
  }

  // ignore: prefer_const_constructors_in_immutables
  AppBtn.basic({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding = EdgeInsets.zero,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
  })  : expand = false,
        bgColor = Colors.transparent,
        border = null,
        _builder = null;

  // interaction:
  final VoidCallback? onPressed;
  late final String semanticLabel;
  final bool enableFeedback;

  // content:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // layout:
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;

  // style:
  final bool isSecondary;
  final BorderSide? border;
  final Color? bgColor;
  final bool pressEffect;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = isSecondary ? Colors.white : Colors.grey;
    Color textColor = isSecondary ? Colors.black : Colors.white;


    Widget content = _builder?.call(context) ?? child ?? const SizedBox.shrink();
    if (expand) content = Center(child: content);

    // Calculate borderRadius
    final borderRadius = circular
        ? BorderRadius.circular(100) // Large radius for circle
        : BorderRadius.circular($dimensions.corners.md);

    // Wrap content in DefaultTextStyle to ensure correct text color
    Widget styledContent = DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
      child: content,
    );

    Widget button = AdaptiveButton(
      onPressed: onPressed,
      color: bgColor ?? defaultColor,
      padding: padding ?? EdgeInsets.all($dimensions.insets.md),
      borderRadius: borderRadius,
      border: border,
      child: styledContent,
    );

    // Semantics
    if (semanticLabel.isEmpty) return button;
    return Semantics(
      label: semanticLabel,
      button: true,
      container: true,
      child: ExcludeSemantics(child: button),
    );
  }
}