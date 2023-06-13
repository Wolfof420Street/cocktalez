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
import 'package:lottie/lottie.dart';

import '../../../../constants/app_colors.dart';
import '../../../components/buttons.dart';
import '../../../components/cocktail_divider.dart';
import '../../../components/error_widget.dart';
import '../../../components/full_screen_image_viewer.dart';

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
      return ref.watch(cocktailDetailsProvider(widget.id)).map(
          data: (cocktailDetailsAsyncValue) {
        FullCocktailResponse fullCocktailResponse =
            cocktailDetailsAsyncValue.value;

        if (fullCocktailResponse.drinks.isNotEmpty) {
          cocktail = fullCocktailResponse.drinks[0];
        }

        late Widget content;

        bool hzMode = context.isLandscape;

        content = hzMode
            ? Row(children: [
          Expanded(child: _ImageBtn(data: fullCocktailResponse.drinks[0])),
          Expanded(child: Center(child: SizedBox(width: 600, child: _InfoColumn(data: fullCocktailResponse.drinks[0])))),
        ])
            : CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              leading: const SizedBox.shrink(),
              expandedHeight: context.height * .5,
              collapsedHeight: context.height * .35,
              flexibleSpace: _ImageBtn(data: fullCocktailResponse.drinks.first),
            ),
            SliverToBoxAdapter(child: _InfoColumn(data: fullCocktailResponse.drinks.first)),
          ],
        );

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                content
              ],
            )
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
