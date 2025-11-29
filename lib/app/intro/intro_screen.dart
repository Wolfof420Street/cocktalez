import 'package:cocktalez/app/components/gradient_container.dart';

import 'package:cocktalez/app/components/static_text_scale.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/main.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_hactics.dart';
import '../../constants/app_icons.dart';
import '../../constants/assets.dart';
import '../../constants/router.dart';
import '../components/app_indicator.dart';
import '../components/circle_buttons.dart';
import '../components/themed_text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const double _imageSize = 250;
  static const double _logoHeight = 126;
  static const double _textHeight = 100;
  static const double _pageIndicatorHeight = 55;

  static List<_PageData> pageData = [];

  late final PageController _pageController = PageController()
    ..addListener(_handlePageChanged);
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  bool get _isOnLastPage => _currentPage.value.round() == pageData.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleIntroCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {
      context.go(ScreenPaths.home);
      introLogic.hasCompletedOnboarding.value = true;
    }
  }

  void _handlePageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int dir) {
    _pageController.animateToPage((_pageController.page ?? 0).round() + dir,
        duration: $dimensions.times.fast, curve: Curves.easeOut);
  }

  void _handleNavTextDoubleTapped() {
    final int current = _pageController.page!.round();
    if (_isOnLastPage) return;
    _pageController.animateToPage(current + 1,
        duration: 250.ms, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // Set the page data, as strings may have changed based on locale
    pageData = [
      const _PageData(
          "Welcome to Cocktalez,",
          "the ultimate cocktail app. Discover new recipes, master classic cocktails, and elevate your at-home bartending game",
          'one',
          '1'),
      const _PageData(
          "Let's get started",
          "Whether you're a seasoned mixologist or a beginner, Mixologist has everything you need to create amazing cocktails. Browse our extensive recipe library and start mixing today.",
          'two',
          '2'),
      const _PageData(
          "Find your perfect recipe",
          "With Mixologist, you have access to hundreds of cocktail recipes, each with detailed instructions and ingredient lists. Try something new or mix up an old favorite",
          'three',
          '3'),
    ];

    // This view uses a full screen PageView to enable swipe navigation.
    // However, we only want the title / description to actually swipe,
    // so we stack a PageView with that content over top of all the other
    // content, and line up their layouts.
    final List<Widget> pages = pageData.map((e) => _Page(data: e)).toList();

    /// Return resulting widget tree
    return DefaultTextColor(
      color: Colors.white,
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: Animate(
            delay: 500.ms,
            effects: const [FadeEffect()],
            child: Stack(
              children: [
                // page view with title & description:
                MergeSemantics(
                  child: Semantics(
                    onIncrease: () => _handleSemanticSwipe(1),
                    onDecrease: () => _handleSemanticSwipe(-1),
                    child: PageView(
                      controller: _pageController,
                      children: pages,
                      onPageChanged: (_) => AppHaptics.lightImpact(),
                    ),
                  ),
                ),

                IgnorePointer(
                  child: Column(children: [
                    const Spacer(),

                    // logo:
                    Semantics(
                      header: true,
                      child: Container(
                        height: _logoHeight,
                        alignment: Alignment.center,
                        child: _WonderousLogo(),
                      ),
                    ),

                    // masked image:
                    SizedBox(
                      height: _imageSize,
                      width: _imageSize,
                      child: ValueListenableBuilder<int>(
                        valueListenable: _currentPage,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: $dimensions.times.slow,
                            child: KeyedSubtree(
                              key: ValueKey(
                                  value), // so AnimatedSwitcher sees it as a different child.
                              child: _PageImage(data: pageData[value]),
                            ),
                          );
                        },
                      ),
                    ),

                    // placeholder gap for text:
                    const Gap(_IntroScreenState._textHeight),

                   // page indicator:
                    Container(
                      height: _pageIndicatorHeight,
                      alignment: const Alignment(0.0, 0),
                      child: AppPageIndicator(
                          count: pageData.length, controller: _pageController, color: AppColors.accent),
                    ),

                    const Spacer(flex: 2),
                  ]),
                ),

                // Build a cpl overlays to hide the content when swiping on very wide screens
                _buildHzGradientOverlay(left: true),
                _buildHzGradientOverlay(),

                // finish button:
                Positioned(
                  right: $dimensions.insets.lg,
                  bottom: $dimensions.insets.lg,
                  child: _buildFinishBtn(context),
                ),

                // nav help text:
                BottomCenter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: $dimensions.insets.lg),
                    child: _buildNavText(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHzGradientOverlay({bool left = false}) {
    return Align(
      alignment: Alignment(left ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: .5,
        child: Padding(
          padding: EdgeInsets.only(left: left ? 0 : 200, right: left ? 200 : 0),
          child: Transform.scale(
              scaleX: left ? -1 : 1,
              child: HzGradient([
                Colors.black.withAlpha(0),
                Colors.black,
              ], const [
                0,
                .2
              ])),
        ),
      ),
    );
  }

  Widget _buildFinishBtn(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 1 : 0,
          duration: $dimensions.times.fast,
          child: CircleIconBtn(
            icon: AppIcons.nextLarge,
            bgColor: AppColors.accent,
            onPressed: _handleIntroCompletePressed,
            semanticLabel: "Next",
          ),
        );
      },
    );
  }

  Widget _buildNavText(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 0 : 1,
          duration: $dimensions.times.fast,
          child: Semantics(
            onTapHint: "Next",
            onTap: _isOnLastPage ? null : _handleNavTextDoubleTapped,
            child: const Text("Swipe Left"),
          ),
        );
      },
    );
  }
}

@immutable
class _PageData {
  const _PageData(this.title, this.desc, this.img, this.mask);

  final String title;
  final String desc;
  final String img;
  final String mask;
}

class _Page extends StatelessWidget {
  const _Page({required this.data});

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.md),
        child: Column(children: [
          const Spacer(),
          const Gap(
              _IntroScreenState._imageSize + _IntroScreenState._logoHeight),
          SizedBox(
            height: _IntroScreenState._textHeight,
            width: 400,
            child: StaticTextScale(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 20 * $dimensions.scale),
                  ),
                  Gap($dimensions.insets.sm),
                  Expanded(child: Text(data.desc, textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),
          const Gap(_IntroScreenState._pageIndicatorHeight),
          const Spacer(flex: 2),
        ]),
      ),
    );
  }
}

class _WonderousLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: SvgPicture.asset(SvgPaths.compassSimple,
              theme: const SvgTheme(currentColor: Colors.white) , height: 48),
        ),
        Gap($dimensions.insets.xs),
        StaticTextScale(
          child: Text(
            "Cocktalez",
            style: TextStyle(
              fontSize: 32 * $dimensions.scale,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({required this.data});

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    debugPrint('  Path : ${ImagePaths.common}/intro_${data.img}.png');
    
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro_${data.img}.png',
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        Positioned.fill(
            child: Image.asset(
          '${ImagePaths.common}/intro-mask-${data.mask}.png',
          fit: BoxFit.fill,
        )),
      ],
    );
  }
}
