import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/constants/router.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';

class CocktailCardRenderer extends StatelessWidget {
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final Drinks cocktail;

  const CocktailCardRenderer(this.offset, {Key? key, this.cardWidth = 250, required this.cocktail,
    required this.cardHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(top: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          // Card background color & decoration
          Container(
            margin: const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.cardLight
                  : AppColors.cardDark,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: AppColors.accent, blurRadius: 4 * offset.abs()),
                BoxShadow(color: AppColors.cardDark, blurRadius: 10 + 6 * offset.abs()),
              ],
            ),
          ),
          // City image, out of card by 15px
          Positioned(top: -15, child: InkWell(
            onTap: () => context.push(ScreenPaths.cocktailDetails(cocktail.idDrink)),
            child: _buildCocktailImage())),
          // City information
          _buildCocktailData()
        ],
      ),
    );
  }

  Widget _buildCocktailImage() {
    double maxParallax = 30;
    double globalOffset = offset * maxParallax * 2;
    double cardPadding = 28;
    double containerWidth = cardWidth - cardPadding;
    return Container(
      height: cardHeight,
      width: containerWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildPositionedLayer(cocktail.strDrinkThumb, containerWidth * .8, maxParallax * .1, globalOffset),
          _buildPositionedLayer(cocktail.strDrinkThumb, containerWidth * .9, maxParallax * .6, globalOffset),
          _buildPositionedLayer(cocktail.strDrinkThumb, containerWidth * .9, maxParallax, globalOffset),
        ],
      ),
    );
  }

  Widget _buildCocktailData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // The sized box mock the space of the city image
        SizedBox(width: double.infinity, height: cardHeight * .40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(cocktail.strDrink,
          textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionedLayer(String path, double width, double maxOffset, double globalOffset) {
    double cardPadding = 24;
    double layerWidth = cardWidth - cardPadding;
    return Positioned(
        left: ((layerWidth * .5) - (width / 2) - offset * maxOffset) + globalOffset,
        bottom: cardHeight * .45,
        child: Image.network(
          path,
          width: width,
        ));
  }
}