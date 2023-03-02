import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/components/regular_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/app_colors.dart';
import '../../../components/error_widget.dart';

class CocktailDetailsPage extends StatefulWidget {
  final String id;

  const CocktailDetailsPage({super.key, required this.id});

  @override
  State<CocktailDetailsPage> createState() => _CocktailDetailsPageState();
}

class _CocktailDetailsPageState extends State<CocktailDetailsPage> {
  CocktailObject? cocktail;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, child) {
      return ref.watch(cocktailDetailsProvider(widget.id)).map(
          data: (cocktailDetailsAsyncValue) {
        FullCocktailResponse fullCocktailResponse =
            cocktailDetailsAsyncValue.value;

        if (fullCocktailResponse.drinks.isNotEmpty) {
          cocktail = fullCocktailResponse.drinks[0];
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(cocktail?.strDrinkThumb ?? ''),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                              
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: regularText('${cocktail?.strDrink}',
                              color: AppColors.secondary,
                              fontSize: 30
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      regularText('Glass : ${cocktail?.strGlass}'),
                      const SizedBox(height: 10),
                      regularText(
                        "Ingredients:",
                        fontWeight: FontWeight.bold
                      ),
                      const SizedBox(height: 10),
                      regularText(
                        "${cocktail?.strIngredient1} - ${cocktail?.strMeasure1}\n${cocktail?.strIngredient2} - ${cocktail?.strMeasure2}\n${cocktail?.strIngredient3} - ${cocktail?.strMeasure3}\n${cocktail?.strIngredient4} - ${cocktail?.strMeasure4}",
                      ),
                      const SizedBox(height: 20),
                      regularText(
                        "Instructions:",
                        fontWeight: FontWeight.bold
                      ),
                      const SizedBox(height: 10),
                      regularText(
                        '${cocktail?.strInstructions}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          return ref.refresh(alcoholicCocktailsProvider);
        }));
      });
    });
  }
}
