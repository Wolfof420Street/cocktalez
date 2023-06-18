import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget randomCocktailCard(CocktailObject cocktailObject, BuildContext ctx) {
  Size size = MediaQuery.of(ctx).size;

  return GestureDetector(
    onTap: () {
      ctx.push(ScreenPaths.cocktailDetails(cocktailObject.idDrink));
    },
    child: Container(
      height: size.height * 0.4,
      width: size.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(cocktailObject.strDrinkThumb),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Transform(
            transform: Matrix4.rotationX(0.1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
               
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(cocktailObject.strDrink,
                        style: const TextStyle(color: AppColors.accent, fontSize: 30)),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    ),
  );
}
