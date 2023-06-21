import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/search/provider/search_provider.dart';
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
import '../../../cocktails/provider/cocktail_provider.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import '../../../components/buttons.dart';
import '../../../components/scroll_decorator.dart';

part '../widgets/_search_tile.dart';
part '../widgets/_search_cocktail_grid.dart';

class CocktailSearchScreen extends StatelessWidget {
  final String searchQuery;

  const CocktailSearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(searchCocktailsProvider(searchQuery)).when(
        data: (searchCocktailsResponse) {
          return SearchCocktailsResult(
            searchCocktailsResponse: searchCocktailsResponse,
            onPressed: (drink) => context.push(ScreenPaths.cocktailDetails(drink.idDrink)),
          );
        },
        loading: () =>  Center(
            child: Lottie.asset('assets/anim/intro_loading.json'),
          ),
        error: (_, __) => ErrorWidget(
          ref.refresh(randomCocktailProvider),
        ),
      );
    });
  }
}

class SearchCocktailsResult extends StatelessWidget {
  final FullCocktailResponse searchCocktailsResponse;
  final void Function(Drinks drink) onPressed;

  const SearchCocktailsResult({
    Key? key,
    required this.searchCocktailsResponse,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Container(
        height: context.heightPx,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(
              isTransparent: true,
              showBackBtn: false,
              title: '',
              subtitle: 'Search results',
            ),
            searchCocktailsResponse.drinks.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'No cocktails found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
                :
            Expanded(
              child: RepaintBoundary(
                child: SearchCocktailGrid(
                  cocktailResponse: searchCocktailsResponse,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
