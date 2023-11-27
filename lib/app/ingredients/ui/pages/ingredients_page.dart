// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';
import 'dart:ui';

import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/components/error_widget.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:cocktalez/di/intro_logic.dart';
import 'package:cocktalez/main.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/router.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import '../../../components/app_indicator.dart';
import '../../../components/buttons.dart';
import '../../../components/static_text_scale.dart';

part '../widgets/_blurred_image_bg.dart';
part '../widgets/_collapsing_carousel_item.dart';
part '../widgets/_bottom_text_content.dart';

class IngridientsPage extends StatefulWidget {
  const IngridientsPage({super.key});

  @override
  State<IngridientsPage> createState() => _IngridientsPageState();
}

class _IngridientsPageState extends State<IngridientsPage> {
  PageController? _pageController;

  final List<Drinks> _drinks = [];

  final _currentPage = ValueNotifier<double>(9999);

  IngridientsResponse? ingridientsResponse;

  late final _currentArtifactIndex = ValueNotifier<num>(_wrappedPageIndex);

  num get _wrappedPageIndex => _currentPage.value.round() % _drinks.length;

  void _handlePageChanged() {
    _currentPage.value = _pageController?.page ?? 0;
    _currentArtifactIndex.value = _wrappedPageIndex;
  }

  void _handleIngridientTap(int index) {
    int delta = index - _currentPage.value.round();
    if (delta == 0) {
      Drinks data = _drinks[index % _drinks.length];
      // context.push(ScreenPaths.artifact(data.artifactId));
      context.push(ScreenPaths.cocktailByIngredientScreen(data.strIngredient1));
    } else {
      _pageController?.animateToPage(
        _currentPage.value.round() + delta,
        duration: $dimensions.times.fast,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return ref.watch(ingredientsProvider).map(data: (ingridientsAsyncValue) {
        var val = ingridientsAsyncValue.value;

        if (val is Failure) {
          debugPrint("Failure");
          return customErrorWidget(() {
            return ref.refresh(ingredientsProvider);
          }, context: context);
        } else {
          ingridientsResponse = val;
        }

        _drinks.clear();
        _drinks.addAll(ingridientsResponse?.drinks ?? []);

        bool shortMode = context.heightPx <= 800;
        final double bottomHeight =
            context.heightPx / 2.75; // Prev 340, dynamic seems to work better
        // Allow objects to become wider as the screen becomes tall, this allows
        // them to grow taller as well, filling the available space better.
        double itemHeight =
            (context.heightPx - 200 - bottomHeight).clamp(250, 400);
        double itemWidth = itemHeight * .666;
        _pageController?.dispose();
        _pageController = PageController(
          viewportFraction: itemWidth / context.widthPx,
          initialPage: _currentPage.value.round(),
        );

        _pageController?.addListener(_handlePageChanged);
        final pages = ingridientsResponse?.drinks.map((e) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: _DoubleBorderImage(e),
          );
        }).toList();

        OverflowBox _buildBgCircle(double height) {
          const double size = 2000;
          return OverflowBox(
            maxWidth: size,
            maxHeight: size,
            child: Transform.translate(
              offset: const Offset(0, size / 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(size)),
                ),
              ),
            ),
          );
        }

        return Stack(
          children: [
            /// Blurred Bg
            Positioned.fill(
              child: ValueListenableBuilder<num>(
                  valueListenable: _currentArtifactIndex,
                  builder: (_, value, __) {
                    debugPrint(
                        'url: https://www.thecocktaildb.com/images/ingredients/${_drinks[value.toInt()].strIngredient1}.png');
                    return _BlurredImageBg(
                        url:
                            'https://www.thecocktaildb.com/images/ingredients/${_drinks[value.toInt()].strIngredient1}.png');
                  }),
            ),

            /// BgCircle
            _buildBgCircle(bottomHeight),

            /// Carousel Items
            PageView.builder(
              controller: _pageController,
              itemBuilder: (_, index) {
                final wrappedIndex = index % pages!.length;
                final child = pages[wrappedIndex];
                return ValueListenableBuilder<double>(
                  valueListenable: _currentPage,
                  builder: (_, value, __) {
                    final int offset = (value.round() - index).abs();
                    return _CollapsingCarouselItem(
                      width: itemWidth,
                      indexOffset: min(3, offset),
                      onPressed: () => _handleIngridientTap(index),
                      title: _drinks[wrappedIndex].strIngredient1,
                      child: child,
                    );
                  },
                );
              },
            ),

            /// Bottom Text
            BottomCenter(
              child: ValueListenableBuilder<num>(
                valueListenable: _currentArtifactIndex,
                builder: (_, value, __) => _BottomTextContent(
                  ingridient: _drinks[value.toInt()],
                  height: bottomHeight,
                  shortMode: shortMode,
                  state: this,
                ),
              ),
            ),

            /// Header
            const AppHeader(
              title: 'Ingridients',
              showBackBtn: false,
              isTransparent: true,
            ),
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
          return ref.refresh(randomCocktailProvider);
        }, context: context));
      });
    }));
  }
}
