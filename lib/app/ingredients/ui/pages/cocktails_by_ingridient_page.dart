import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/app_icons.dart';

import '../../../../constants/router.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import '../../../components/buttons.dart';
import '../../../components/circle_buttons.dart';
import '../../../components/error_widget.dart';
import '../../../components/scroll_decorator.dart';

part '../widgets/_ingridient_by_glass_grid.dart';
part '../widgets/_result_tile.dart';

class CocktailsByIngridientPage extends StatelessWidget {
  final String ingridient;

  const CocktailsByIngridientPage({super.key, required this.ingridient});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(cocktailByIngredientProvider(ingridient)).map(
          data: (cocktailByIngridientAsyncValue) {
        CocktailResponse cocktailResponse =
            cocktailByIngridientAsyncValue.value;

        Widget content = GestureDetector(
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            AppHeader(title: '', subtitle: '$ingridient cocktails'),
            Expanded(
                child: RepaintBoundary(
                    child: CocktailByIngrientGrid(
              cocktailResponse: cocktailResponse,
              onPressed: (Drinks drink) {
                context.push(ScreenPaths.cocktailDetails(drink.idDrink));
              },
            )))
          ]),
        );
        return Stack(
          children: [
            Positioned.fill(
                child: ColoredBox(
                    color: Theme.of(context).cardColor, child: content)),
          ],
        );
      }, loading: (_) {
        return Scaffold(
          body: Center(
            child: Lottie.asset('assets/anim/intro_loading.json'),
          ),
        );
      }, error: (error) {
        return Scaffold(
            body: customErrorWidget(() {
          return ref.refresh(cocktailByIngredientProvider(ingridient));
        }, context: context));
      });
    });
  }

  Widget _buildInput(BuildContext context, TextEditingController textController,
      FocusNode focusNode) {
    Color captionColor = Theme.of(context).hintColor;
    return Container(
      height: $dimensions.insets.xl,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular($dimensions.insets.xs),
      ),
      child: Row(
        children: [
          Gap($dimensions.insets.xs * 1.5),
          Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          Expanded(
            child: TextField(
              onSubmitted: (String value) {},
              controller: textController,
              focusNode: focusNode,
              style: TextStyle(color: captionColor),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all($dimensions.insets.xs),
                labelStyle: TextStyle(color: captionColor),
                hintStyle: TextStyle(color: captionColor.withOpacity(0.5)),
                prefixStyle: TextStyle(color: captionColor),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Search',
              ),
            ),
          ),
          Gap($dimensions.insets.xs),
          ValueListenableBuilder(
            valueListenable: textController,
            builder: (_, value, __) => Visibility(
              visible: textController.value.text.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(right: $dimensions.insets.xs),
                child: CircleIconBtn(
                  bgColor: Theme.of(context).cardColor,
                  color: Theme.of(context).cardColor,
                  icon: AppIcons.close,
                  semanticLabel: 'Search',
                  size: $dimensions.insets.md,
                  iconSize: $dimensions.insets.sm,
                  onPressed: () {
                    textController.clear();
                    // onSubmit('');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
