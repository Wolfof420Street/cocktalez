import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/cocktail_card_renderer.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/rotation_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';
import '../../data/model/cocktail_response.dart';

class AlcoholicCocktails extends StatefulWidget {
  const AlcoholicCocktails({super.key});

  @override
  State<AlcoholicCocktails> createState() => _AlcoholicCocktailsState();
}

class _AlcoholicCocktailsState extends State<AlcoholicCocktails>
    with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;

  PageController? _pageController;

  double _cardWidth = 160;
  double _cardHeight = 200;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  Animation<double>? _tweenAnim;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _cardHeight = (size.height * .48).clamp(300.0, 400.0);
    _cardWidth = _cardHeight * .8;
    //Calculate the viewPort fraction for this aspect ratio, since PageController does not accept pixel based size values
    _pageController = PageController(
        initialPage: 1, viewportFraction: _cardWidth / size.width);
    _cardHeight = (size.height * .48).clamp(300.0, 400.0);
    _cardWidth = _cardHeight * .8;
    //Calculate the viewPort fraction for this aspect ratio, since PageController does not accept pixel based size values
    _pageController = PageController(
        initialPage: 1, viewportFraction: _cardWidth / size.width);

    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(alcoholicCocktailsProvider).map(
          data: (alcoholicCocktailAsyncValue) {
        CocktailResponse? cocktailResponse;

        var value = alcoholicCocktailAsyncValue.value;

        if (value is CocktailResponse) {
          cocktailResponse = value;
        }

        Widget _buildItemRenderer(int itemIndex) {
          return Rotation3d(
            rotationY: _normalizedOffset * _maxRotation,
            //Create the actual content renderer for our list
            child: CocktailCardRenderer(
              //Pass in the offset, renderer can update it's own view from there
              _normalizedOffset,
              //Pass in city path for the image asset links
              cocktail: cocktailResponse!.drinks[itemIndex],
              cardWidth: _cardWidth,
              cardHeight: _cardHeight,
            ),
          );
        }

        //Create our main list
        Widget listContent = SizedBox(
          //Wrap list in a container to control height and padding
          height: _cardHeight,
          //Use a ListView.builder, calls buildItemRenderer() lazily, whenever it need to display a listItem
          child: PageView.builder(
            //Use bounce-style scroll physics, feels better with this demo
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: cocktailResponse?.drinks.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) => _buildItemRenderer(i),
          ),
        );

        //If the user has released a pointer, and is currently scrolling, we'll assume they're done scrolling and tween our offset to zero.
        //This is a bit of a hack, we can't be sure this event actually came from the same finger that was scrolling, but should work most of the time.

        //Helper function, any time we change the offset, we want to rebuild the widget tree, so all the renderers get the new value.
        void _setOffset(double value) {
          setState(() {
            _normalizedOffset = value;
          });
        }

        void _startOffsetTweenToZero() {
          //The first time this runs, setup our controller, tween and animation. All 3 are required to control an active animation.
          int tweenTime = 1000;
          if (_tweenController == null) {
            //Create Controller, which starts/stops the tween, and rebuilds this widget while it's running
            _tweenController = AnimationController(
                vsync: this, duration: Duration(milliseconds: tweenTime));
            //Create Tween, which defines our begin + end values
            _tween = Tween<double>(begin: -1, end: 0);
            //Create Animation, which allows us to access the current tween value and the onUpdate() callback.
            _tweenAnim = _tween?.animate(CurvedAnimation(
                parent: _tweenController!, curve: Curves.elasticOut))
              //Set our offset each time the tween fires, triggering a rebuild
              ?..addListener(() {
                _setOffset(_tweenAnim?.value ?? 0);
              });
          }
          //Restart the tweenController and inject a new start value into the tween
          _tween?.begin = _normalizedOffset;
          _tweenController?.reset();
          _tween?.end = 0;
          _tweenController?.forward();
        }

        void _handlePointerUp(PointerUpEvent event) {
          if (_isScrolling) {
            _isScrolling = false;
            _startOffsetTweenToZero();
          }
        }

        //Check the notifications bubbling up from the ListView, use them to update our currentOffset and isScrolling state
        bool _handleScrollNotifications(Notification notification) {
          //Scroll Update, add to our current offset, but clamp to -1 and 1
          if (notification is ScrollUpdateNotification) {
            if (_isScrolling) {
              double dx = notification.metrics.pixels - _prevScrollX;
              double scrollFactor = .01;
              double newOffset = (_normalizedOffset + dx * scrollFactor);
              _setOffset(newOffset.clamp(-1.0, 1.0));
            }
            _prevScrollX = notification.metrics.pixels;
            //Calculate the index closest to middle
            //_focusedIndex = (_prevScrollX / (_itemWidth + _listItemPadding)).round();
            // widget.onCityChange(widget.cities.elementAt(_pageController.page.round() % widget.cities.length));
          }
          //Scroll Start
          else if (notification is ScrollStartNotification) {
            _isScrolling = true;
            _prevScrollX = notification.metrics.pixels;
            if (_tween != null) {
              _tweenController?.stop();
            }
          }
          return true;
        }

        return cocktailResponse != null
            ? Listener(
                onPointerUp: _handlePointerUp,
                child: NotificationListener(
                  onNotification: _handleScrollNotifications,
                  child: listContent,
                ),
              )
            : Container();
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
