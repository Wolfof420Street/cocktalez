part of '../pages/cocktails_by_ingridient_page.dart';


class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(Drinks data) onPressed;
  final Drinks data;

  @override
  Widget build(BuildContext context) {
    
    final Widget image = AppImage(
      key: ValueKey(data.idDrink),
      image: NetworkImage(data.strDrinkThumb),
      fit: BoxFit.cover,
      scale: 0.5,
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
                image,
                Gap($dimensions.insets.md),
                Text(data.strDrink,
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.displaySmall?.color
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

