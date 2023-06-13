import 'package:cocktalez/app/components/buttons.dart';
import 'package:cocktalez/app/components/error_widget.dart';
import 'package:cocktalez/app/glass/provider/glass_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/router.dart';
import '../../../../main.dart';
import '../../../cocktails/data/model/cocktail_response.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import '../../../components/scroll_decorator.dart';


part '../widgets/_cocktail_by_glass_grid.dart';
part '../widgets/_glass_tile.dart';

class CocktailByGlassPage extends StatelessWidget {
  final String glass;

  const CocktailByGlassPage({Key? key, required this.glass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(cocktailByGlassProvider(glass)).map(
          data: (cocktailByGlassAsyncValue) {
        CocktailResponse cocktailResponse = cocktailByGlassAsyncValue.value;

        Widget content = GestureDetector(
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            AppHeader(
                title: '', subtitle: '$glass cocktails'),
            Expanded(
                child: RepaintBoundary(
                    child: CocktailByGlassGrid(
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
        return Center(child: customErrorWidget((){}, 
          context: context
        ));
      });
    });
  }
}
