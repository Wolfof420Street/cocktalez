part of '../pages/search_cocktail_page.dart';

class SearchCocktailGrid extends StatefulWidget {
  final FullCocktailResponse cocktailResponse;

   final void Function(Drinks) onPressed;

  const SearchCocktailGrid({super.key, required this.cocktailResponse, required this.onPressed});

  @override
  State<SearchCocktailGrid> createState() => _SearchCocktailGridGridState();
}

class _SearchCocktailGridGridState extends State<SearchCocktailGrid> {
  
  late ScrollController _controller;

  double _prevVel = -1;

  void _handleResultsScrolled() {
    // Hide the keyboard if the list is scrolled manually by the pointer, ignoring velocity based scroll changes like deceleration or over-scroll bounce
    // ignore: INVALID_USE_OF_PROTECTED_MEMBER, INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
    final vel = _controller.position.activity?.velocity;
    if (vel == 0 && _prevVel == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    _prevVel = vel ?? _prevVel;
  }

  
  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
        onInit: (controller) => controller.addListener(_handleResultsScrolled),
        builder: (controller) {
          _controller = controller;
          return CustomScrollView(
            controller: controller,
            scrollBehavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            clipBehavior: Clip.hardEdge,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all($dimensions.insets.sm)
                    .copyWith(bottom: $dimensions.insets.offset * 1.5),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: (context.widthPx / 300).ceil(),
                  mainAxisSpacing: $dimensions.insets.sm,
                  crossAxisSpacing: $dimensions.insets.sm,
                  childCount: widget.cocktailResponse.drinks.length,
                  itemBuilder: (context, index) => _SearchTile(
                      onPressed: widget.onPressed,
                      data: Drinks(strDrink: widget.cocktailResponse.drinks[index].strDrink, strDrinkThumb:  widget.cocktailResponse.drinks[index].strDrinkThumb, idDrink:  widget.cocktailResponse.drinks[index].idDrink)),
                ),
              ),
            ],
          );
        });
  }
}
