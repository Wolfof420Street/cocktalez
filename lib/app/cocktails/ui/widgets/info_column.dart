part of '../pages/cocktail_details_page.dart';



class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.data, required this.locale});
  final CocktailObject data;
  final Locale locale;

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
                ...data.ingredients.map((e) => IngredientRow(label: e.ingredient, value: e.measure))
                    .toList()
                    .animate(interval: 100.ms)
                    .fadeIn(delay: 600.ms, duration: $dimensions.times.med)
                    .slide(begin: const Offset(0.2, 0), curve: Curves.easeOut),
              ],
            ),
            Gap($dimensions.insets.md),
            Text(
              data.instructionFor(locale),
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
