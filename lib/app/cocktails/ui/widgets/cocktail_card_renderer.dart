import 'package:cocktalez/constants/router.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';
import '../../../components/adaptive/adaptive_tappable.dart';
import '../../../components/app_image.dart';

// Global dimensions constant assumed to be available via main.dart or app_sizes.dart
// If $dimensions is not found, ensure 'package:cocktalez/constants/app_sizes.dart' is imported.

class CocktailCardRenderer extends StatelessWidget {
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final dynamic cocktail;

  const CocktailCardRenderer(
    this.offset, {
    super.key,
    this.cardWidth = 250,
    required this.cocktail,
    required this.cardHeight,
  });

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
              boxShadow: const [
                // PERFORMANCE FIX: Static blur radius prevents expensive recalculations during scroll
                BoxShadow(color: AppColors.accent, blurRadius: 6),
                BoxShadow(color: AppColors.cardDark, blurRadius: 12),
              ],
            ),
          ),
          // Cocktail image, out of card by 15px
          Positioned(
            top: -15,
            child: AdaptiveTappable(
              onTap: () => context.push(ScreenPaths.cocktailDetails(cocktail.idDrink)),
              child: _buildCocktailImage(),
            ),
          ),
          // Cocktail information
          Gap($dimensions.insets.xxl),
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
    
    return SizedBox(
      height: cardHeight + 60,
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
        // The sized box mocks the space of the image
        SizedBox(width: double.infinity, height: cardHeight * .40),
        Gap($dimensions.insets.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Text(
            cocktail.strDrink,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
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
      child: AppImage(
        image: NetworkImage(path),
        width: width, // Use the dynamic width to restore parallax depth
        // Removed explicit height & fit: Allows image to scale naturally (1:1 aspect ratio)
        // matching the original Image.network behavior exactly.
        distractor: false, // PERFORMANCE FIX: Disable spinners for background layers
      ),
    );
  }
}