import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/pages/cocktail_details_page.dart';
import 'package:cocktalez/app/components/regular_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/app_colors.dart';
import '../../../components/error_widget.dart';
import '../../data/model/cocktail_response.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AlcoholicCocktails extends StatelessWidget {
  const AlcoholicCocktails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(alcoholicCocktailsProvider).map(
          data: (alcoholicCocktailAsyncValue) {
        CocktailResponse? cocktailResponse;

        var value = alcoholicCocktailAsyncValue.value;

        if (value is CocktailResponse) {
          cocktailResponse = value;
        }

        return cocktailResponse != null
            ? ListView.builder(
                itemCount: cocktailResponse.drinks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var cocktailObject = cocktailResponse!.drinks[index];
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: CocktailDetailsPage(
                          id: cocktailObject.idDrink,
                        ),
                        withNavBar: false, //
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(cocktailObject.strDrinkThumb),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Transform(
                        transform: Matrix4.rotationX(0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                regularText(cocktailObject.strDrink,
                                    color: AppColors.secondary, fontSize: 15),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
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
