part of '../pages/cocktail_details_page.dart';

class _ImageBtn extends StatelessWidget {
  const _ImageBtn({required this.data});
  final CocktailObject data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        Container(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.cardLight
              : AppColors.cardDark,
          alignment: Alignment.center,
          child: AppBtn.basic(
            semanticLabel: data.strDrink,
            onPressed: () => _handleImagePressed(context),
            child: SafeArea(
              bottom: false,
              minimum: EdgeInsets.symmetric(vertical: $dimensions.insets.sm),
              child: Hero(
                tag: data.strDrinkThumb,
                child: AppImage(
                  image: NetworkImage(data.strDrinkThumb),
                  fit: BoxFit.contain,
                  distractor: true,
                  width: double.infinity,
                  height: 300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleImagePressed(BuildContext context) {
    appLogic.showFullscreenDialogRoute(context, FullscreenUrlImgViewer(urls: [data.strDrinkThumb]));
  }
}