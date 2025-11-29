import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/components/app_image.dart';

import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../components/adaptive/adaptive_scaffold.dart';
import '../../../components/adaptive/adaptive_sliver_app_bar.dart';
import '../../../components/adaptive/platform_provider.dart';
import '../../../components/app_header.dart';
import 'package:cocktalez/app/components/async_data_widget.dart';
import 'package:cocktalez/app/components/loading_indicator.dart';import '../../../components/buttons.dart';
import '../../../components/cocktail_divider.dart';
import '../../../components/full_screen_image_viewer.dart';

import 'package:cocktalez/app/cocktails/ui/widgets/ingredient_row.dart';
import 'package:cocktalez/app/common/providers/locale_provider.dart';
import 'package:cocktalez/app/cocktails/utils/cocktail_extensions.dart';
import 'package:cocktalez/app/cocktails/utils/cocktail_localization.dart';

part  '../widgets/image_button.dart';
part '../widgets/info_column.dart';

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
    return Consumer(builder: (context, ref, child) {
      final locale = ref.watch(localeProvider);
      
      return AsyncDataWidget<FullCocktailResponse>(
        provider: cocktailDetailsProvider(widget.id),
        data: (fullCocktailResponse) {
          if (fullCocktailResponse.drinks.isNotEmpty) {
            cocktail = fullCocktailResponse.drinks[0];
          }

          Widget content;

          bool hzMode = context.isLandscape;

          // Determine platform for conditional rendering
          final platform = ref.watch(platformProvider);
          final isIos = platform == TargetPlatform.iOS;

          content = hzMode
              ? Row(
                  children: [
                    Expanded(child: _ImageBtn(data: fullCocktailResponse.drinks[0])),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 600,
                          child: _InfoColumn(data: fullCocktailResponse.drinks[0], locale: locale),
                        ),
                      ),
                    ),
                  ],
                )
              : CustomScrollView(
                  slivers: [
                    AdaptiveSliverAppBar(
                      pinned: true,
                      // On iOS, we use the title for the cocktail name if we want a Large Title,
                      // but here the design uses a big image header.
                      // If we pass title, it shows text.
                      // Let's pass the title for iOS (so we have a header) and null for Android (since it's in the flexible space? No, Android usually has title too or just image).
                      // The original code had NO title in SliverAppBar, just flexibleSpace.
                      // So for Android: title is null.
                      // For iOS: We probably want the cocktail name as the Large Title since we are moving the image to body.
                      title: isIos ? Text(cocktail!.strDrink) : null, 
                      expandedHeight: context.height * .5,
                      collapsedHeight: context.height * .35,
                      flexibleSpace: isIos ? null : _ImageBtn(data: fullCocktailResponse.drinks.first),
                      leading: const SizedBox.shrink(), // Keep original behavior
                    ),
                    // On iOS, insert the image as the first body item since it's not in the navbar
                    if (isIos)
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: context.height * .5,
                          child: _ImageBtn(data: fullCocktailResponse.drinks.first),
                        ),
                      ),
                    SliverToBoxAdapter(child: _InfoColumn(data: fullCocktailResponse.drinks.first, locale: locale)),
                  ],
                );

          return AdaptiveScaffold(
            body: Stack(
              children: [
                content,
                const AppHeader(isTransparent: true),
              ],
            ),
          );
        },
        wrapLoadingInScaffold: true,
        loading: () => const AppLoadingIndicator(),
      );
    });
  }
}
