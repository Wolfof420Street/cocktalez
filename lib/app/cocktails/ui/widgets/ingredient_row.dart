import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/app_sizes.dart';
import 'package:flutter/material.dart';


class IngredientRow extends StatelessWidget {
  const IngredientRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: value.isEmpty,
      child: MergeSemantics(
        child: Padding(
          padding: EdgeInsets.only(bottom: $dimensions.insets.sm),
          child: Row(children: [
            Expanded(
              flex: 40,
              child: Text(
                label.toUpperCase(),
                style: const TextStyle(color: AppColors.accent),
              ),
            ),
            Expanded(
              flex: 60,
              child: Text(
                value.isEmpty ? '--' : value,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
