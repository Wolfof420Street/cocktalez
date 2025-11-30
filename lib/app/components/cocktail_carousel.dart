// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cocktalez/app/cocktails/ui/widgets/cocktail_card_renderer.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/rotation_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_widget.dart';
import 'loading_indicator.dart';

/// Unified reusable 3D carousel widget for displaying cocktails
/// 
/// Features:
/// - 3D rotation effects based on scroll position
/// - Elastic snap-back animation when scrolling stops
/// - Responsive card sizing based on screen dimensions
/// - Generic type support for different cocktail response types
/// 
/// Usage:
/// ```dart
/// CocktailCarousel<CocktailResponse>(
///   provider: alcoholicCocktailsProvider,
///   extractDrinks: (response) => response.drinks,
/// )
/// ```
class CocktailCarousel<T> extends StatefulWidget {
  /// The Riverpod provider that supplies the cocktail data
  final Refreshable<dynamic> provider;
  
  /// Function to extract the list of drinks from the response type T
  /// Returns a list of dynamic objects (can be Drinks or CocktailObject)
  final List<dynamic> Function(T response) extractDrinks;
  
  /// Optional callback when refresh is triggered on error
  final VoidCallback? onRefresh;

  const CocktailCarousel({
    super.key,
    required this.provider,
    required this.extractDrinks,
    this.onRefresh,
  });

  @override
  State<CocktailCarousel<T>> createState() => _CocktailCarouselState<T>();
}

class _CocktailCarouselState<T> extends State<CocktailCarousel<T>>
    with SingleTickerProviderStateMixin {
  // 3D rotation configuration
  final double _maxRotation = 20;

  // PageController for carousel scrolling
  late PageController _pageController;

  // Card dimensions (calculated responsively)
  double _cardWidth = 160;
  double _cardHeight = 200;

  // Scroll state tracking - using ValueNotifier for performance
  final ValueNotifier<double> _normalizedOffset = ValueNotifier<double>(0);
  double _prevScrollX = 0;
  bool _isScrolling = false;

  // Animation controllers for elastic snap-back effect
  AnimationController? _tweenController;
  Tween<double>? _tween;
  Animation<double>? _tweenAnim;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tweenController?.dispose();
    _normalizedOffset.dispose();
    super.dispose();
  }

  /// Updates the normalized offset without triggering full widget rebuild
  void _setOffset(double value) {
    _normalizedOffset.value = value;
  }

  /// Starts elastic animation to snap rotation back to zero
  void _startOffsetTweenToZero() {
    const int tweenTime = 1000;
    
    // Lazy initialization of animation controllers
    if (_tweenController == null) {
      _tweenController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: tweenTime),
      );
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween?.animate(
        CurvedAnimation(
          parent: _tweenController!,
          curve: Curves.elasticOut,
        ),
      );
      _tweenAnim?.addListener(() {
        _setOffset(_tweenAnim?.value ?? 0);
      });
    }

    // Restart animation with current offset as start value
    _tween?.begin = _normalizedOffset.value;
    _tweenController?.reset();
    _tween?.end = 0;
    _tweenController?.forward();
  }

  /// Handles pointer up events to trigger snap-back animation
  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  /// Handles scroll notifications to update rotation offset
  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        const double scrollFactor = .01;
        double newOffset = (_normalizedOffset.value + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController?.stop();
      }
    }
    return true;
  }

  /// Builds an individual carousel item with 3D rotation
  /// Uses ValueListenableBuilder to minimize rebuilds during scroll
  Widget _buildItemRenderer(dynamic cocktail) {
    return ValueListenableBuilder<double>(
      valueListenable: _normalizedOffset,
      builder: (context, offset, child) {
        return Rotation3d(
          rotationY: offset * _maxRotation,
          child: CocktailCardRenderer(
            offset,
            cocktail: cocktail,
            cardWidth: _cardWidth,
            cardHeight: _cardHeight,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Calculate responsive card dimensions
    _cardHeight = (size.height * .48).clamp(300.0, 400.0);
    _cardWidth = _cardHeight * .8;

    // Update viewport fraction if screen size changed
    final newViewportFraction = _cardWidth / size.width;
    if (_pageController.viewportFraction != newViewportFraction) {
      final currentPage = _pageController.hasClients 
          ? _pageController.page ?? 1 
          : 1;
      _pageController.dispose();
      _pageController = PageController(
        initialPage: currentPage.round(),
        viewportFraction: newViewportFraction,
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        return (ref.watch(widget.provider) as AsyncValue<T>).when(
          data: (response) {
            final drinks = widget.extractDrinks(response);

            if (drinks.isEmpty) {
              return Container();
            }

            // Build the carousel widget
            final listContent = SizedBox(
              height: _cardHeight,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: drinks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _buildItemRenderer(drinks[index]),
              ),
            );

            // Wrap with gesture listeners for 3D effect
            return Listener(
              onPointerUp: _handlePointerUp,
              child: NotificationListener(
                onNotification: _handleScrollNotifications,
                child: listContent,
              ),
            );
          },
          loading: () => const AppLoadingScaffold(),
          error: (error, stackTrace) {
            return Scaffold(
              body: AppErrorWidget(
                onRetry: () async {
                  widget.onRefresh?.call();
                },
              ),
            );
          },
        );
      },
    );
  }
}
