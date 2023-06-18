part of '../pages/cocktail_details_page.dart';

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({Key? key, required this.data}) : super(key: key);
  final CocktailObject data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.lg),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap($dimensions.insets.xl),
            if (data.strCategory.isNotEmpty) ...[
              Text(
                data.strCategory.toUpperCase(),
                style: const TextStyle(color: AppColors.accent),
              ).animate().fade(delay: 150.ms, duration: 600.ms),
              Gap($dimensions.insets.xs),
            ],
            Semantics(
              header: true,
              child: Text(
                data.strDrink,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ).animate().fade(delay: 250.ms, duration: 600.ms),
            ),
            Gap($dimensions.insets.lg),
            Animate().toggle(
                delay: 500.ms,
                builder: (_, value, __) {
                  return CocktailDivider(
                      isExpanded: !value, duration: $dimensions.times.med);
                }),
            Gap($dimensions.insets.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...[
                  _InfoRow(data.strIngredient1, data.strMeasure1),
                  _InfoRow(data.strIngredient2, data.strMeasure2),
                  _InfoRow(data.strIngredient3, data.strMeasure3),
                  _InfoRow(data.strIngredient4, data.strMeasure4 ?? ""),
                  _InfoRow(data.strIngredient5 ?? "", data.strMeasure5 ?? ""),
                  _InfoRow(data.strIngredient6 ?? "", data.strMeasure6 ?? ""),
                ]
                    .animate(interval: 100.ms)
                    .fadeIn(delay: 600.ms, duration: $dimensions.times.med)
                    .slide(begin: const Offset(0.2, 0), curve: Curves.easeOut),
              ],
            ),
            Gap($dimensions.insets.md),
            Text(
              data.strInstructions,
             style: const TextStyle(color: AppColors.accent),
            )
                .animate(delay: GetNumUtils(1.5).seconds)
                .fadeIn()
                .slide(begin: const Offset(0.2, 0), curve: Curves.easeOut),
            Gap($dimensions.insets.offset),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value, {Key? key}) : super(key: key);

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
