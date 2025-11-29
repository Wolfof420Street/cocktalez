part of '../pages/cocktail_by_glass_page.dart';

class _GlassTile extends StatelessWidget {
  const _GlassTile({required this.onPressed, required this.data});

  final void Function(Drinks data) onPressed;
  final Drinks data;

  @override
  Widget build(BuildContext context) {
    
    final Widget image = AppImage(
      key: ValueKey(data.idDrink),
      image: NetworkImage(data.strDrinkThumb),
      fit: BoxFit.cover,
      distractor: true,
      color: Theme.of(context).cardColor,
    );

    return AspectRatio(
      aspectRatio: 3/4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular($dimensions.insets.xs),
        child: AppBtn.basic(
          semanticLabel: data.strDrink,
          onPressed: () => onPressed(data),
          child: Container(
            color: Theme.of(context).cardColor,
            width: double.infinity, // force image to fill area
            height: double.infinity,
            child: Column(
              children: [
                Expanded(child: image),
                Gap($dimensions.insets.md),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.xs),
                  child: Text(
                    data.strDrink,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Gap($dimensions.insets.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

