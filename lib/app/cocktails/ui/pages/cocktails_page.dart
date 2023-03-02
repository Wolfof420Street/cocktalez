import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/alcohol_cocktails.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/random_cocktail_card.dart';
import 'package:cocktalez/app/components/regular_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';

class CocktailsPage extends StatefulWidget {
  const CocktailsPage({super.key});

  @override
  State<CocktailsPage> createState() => _CocktailsPageState();
}

class _CocktailsPageState extends State<CocktailsPage> {
  FullCocktailResponse? fullCocktailResponse;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(randomCocktailProvider).map(
          data: (randomCocktailAsyncvalue) {
        var randomCocktailValue = randomCocktailAsyncvalue.value;

        print('Value : $randomCocktailValue');

        if (randomCocktailValue is FullCocktailResponse) {
          fullCocktailResponse = randomCocktailValue;
        } else {
          
        }
        return Scaffold(
          body: SafeArea(
            child: Column(children: [
              fullCocktailResponse != null
                  ? Expanded(
                    flex: 2,
                    child: randomCocktailCard(fullCocktailResponse!.drinks[0], context))
                  : Container(),
                 const SizedBox(height: 10),
                 regularText('Alcoholic Cocktails',
                 fontWeight: FontWeight.bold
                 ),
                 const Expanded(
                   flex: 1,
                  child: AlcoholicCocktails())
            ]),
          ),
        );
      }, loading: (_) {
        return Scaffold(
          body: Center(
            child: Lottie.asset('assets/anim/intro_loading.json'),
          ),
        );
      }, error: (error) {
        return Scaffold(body: customErrorWidget(() {
          return ref.refresh(randomCocktailProvider);
        }));
      });
    });
  }
}
