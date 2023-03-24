part of '../pages/cocktail_details_page.dart';

class _ImageBtn extends StatelessWidget {
  const _ImageBtn({Key? key, required this.data}) : super(key: key);
  final CocktailObject data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomCenter(
          child: Transform.translate(
            offset: Offset(0, $dimensions.insets.xl - 1),
            child: VtGradient(
              Theme.of(context).brightness == Brightness.light ? 
              [AppColors.cardLight, Colors.grey.withOpacity(0)] : [AppColors.cardDark, Colors.grey.withOpacity(0)],
              const [0, 1],
              height: $dimensions.insets.xl,
            ),
          ),
        ),
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
                  scale: FullscreenUrlImgViewer.imageScale, // so the image isn't reloaded
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