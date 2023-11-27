import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/cocktail_card_renderer.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/rotation_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseCocktailState<T extends StatefulWidget, TResponse>
    extends State<T> with SingleTickerProviderStateMixin {
  final double maxRotation = 20;
  PageController? pageController;
  late double cardWidth;
  late double cardHeight = 200;
  double normalizedOffset = 0;
  double prevScrollX = 0;
  bool isScrolling = false;

  AnimationController? tweenController;
  Tween<double>? tween;
  Animation<double>? tweenAnim;

  @override
  void initState() {
    super.initState();

    
    // Use WidgetsBinding to defer code execution until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Now it's safe to use context
      Size size = MediaQuery.of(context).size;
      cardHeight = (size.height * .48).clamp(300.0, 400.0);
      cardWidth = cardHeight * .8;

      pageController = PageController(
          initialPage: 1, viewportFraction: cardWidth / size.width);
   
    });
  }

  @override
  void dispose() {
    tweenController?.dispose();
    pageController?.dispose();
    super.dispose();
  }

  Widget buildCocktailWidget(
      BuildContext context,
      ProviderListenable<AsyncValue<TResponse>> provider,
      Widget Function(TResponse) builder) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(provider).when(
            data: builder,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
    });
  }

  Widget buildCocktailList(CocktailResponse cocktailResponse) {
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotifications,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          itemCount: cocktailResponse.drinks.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              buildItemRenderer(index, cocktailResponse),
        ),
      ),
    );
  }

  Widget buildItemRenderer(int itemIndex, CocktailResponse cocktailResponse) {
    return Rotation3d(
      rotationY: normalizedOffset * maxRotation,
      child: CocktailCardRenderer(
        normalizedOffset,
        cocktail: cocktailResponse.drinks[itemIndex],
        cardWidth: cardWidth,
        cardHeight: cardHeight,
      ),
    );
  }

  void _setOffset(double value) {
    setState(() {
      normalizedOffset = value;
    });
  }

  void _startOffsetTweenToZero() {
    int tweenTime = 1000;
    if (tweenController == null) {
      tweenController = AnimationController(
          vsync: this, duration: Duration(milliseconds: tweenTime));
      tween = Tween<double>(begin: -1, end: 0);
      tweenAnim = tween?.animate(
          CurvedAnimation(parent: tweenController!, curve: Curves.elasticOut))
        ?..addListener(() {
          _setOffset(tweenAnim?.value ?? 0);
        });
    }
    tween?.begin = normalizedOffset;
    tweenController?.reset();
    tween?.end = 0;
    tweenController?.forward();
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (isScrolling) {
      isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  bool _handleScrollNotifications(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (isScrolling) {
        double dx = notification.metrics.pixels - prevScrollX;
        double scrollFactor = .01;
        double newOffset = (normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      prevScrollX = notification.metrics.pixels;
    } else if (notification is ScrollStartNotification) {
      isScrolling = true;
      prevScrollX = notification.metrics.pixels;
      if (tween != null) {
        tweenController?.stop();
      }
    }
    return true;
  }
}
