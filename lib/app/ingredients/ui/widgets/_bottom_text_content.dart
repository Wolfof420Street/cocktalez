part of '../pages/ingredients_page.dart';

class _BottomTextContent extends StatelessWidget {
  const _BottomTextContent(
      {required this.ingridient, required this.height, required this.state, required this.shortMode});

  final Drinks ingridient;
  final double height;
  final _IngridientsPageState state;
  final bool shortMode;
  int get _currentPage => state._currentPage.value.round();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: $dimensions.sizes.maxContentWidth2,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.md),
      alignment: Alignment.center,
      child: Stack(
        children: [
          /// Text
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap($dimensions.insets.xl),
              Column(
                children: [
                  IgnorePointer(
                    child: Semantics(
                      button: true,
                      onIncrease: () => state._handleIngridientTap(_currentPage + 1),
                      onDecrease: () => state._handleIngridientTap(_currentPage - 1),
                      onTap: () => state._handleIngridientTap(_currentPage),
                      liveRegion: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Force column to stretch horizontally so text is centered
                          const SizedBox(width: double.infinity),
                          // Stop text from scaling to make layout a little easier, it's already quite large
                          StaticTextScale(
                            child: Text(
                              ingridient.strIngredient1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black, height: 1.2, fontSize: 32),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          if (!shortMode) ...[
                            Gap($dimensions.insets.xxs),
                            const Text(
                              "",
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ],
                      ).animate(key: ValueKey(ingridient.strIngredient1)).fadeIn(),
                    ),
                  ),
                ],
              ),
              if (!shortMode) Gap($dimensions.insets.sm), 
              Gap($dimensions.insets.md),
              if (!shortMode)
                AppPageIndicator(
                  count: state._drinks.length,
                  controller: state._pageController!,
                  semanticPageTitle: ingridient.strIngredient1,
                ),
              Gap($dimensions.insets.sm),
              AppBtn.from(
                text: "View Cocktails",
                expand: true,
                onPressed: () => state._handleIngridientTap(_currentPage),
              ),
              Gap($dimensions.insets.lg),
            ],
          ),
        ],
      ),
    );
  }
}