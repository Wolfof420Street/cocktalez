part of '../pages/cocktails_by_ingridient_page.dart';

class CocktailByIngrientGrid extends StatefulWidget {
  final CocktailResponse cocktailResponse;

   final void Function(Drinks) onPressed;

  const CocktailByIngrientGrid({super.key, required this.cocktailResponse, required this.onPressed});

  @override
  State<CocktailByIngrientGrid> createState() => _CocktailByIngrientGridState();
}

class _CocktailByIngrientGridState extends State<CocktailByIngrientGrid> {
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
                  itemBuilder: (context, index) => _ResultTile(
                      onPressed: widget.onPressed,
                      data: widget.cocktailResponse.drinks[index]),
                ),
              ),
            ],
          );
        });
  }
}
