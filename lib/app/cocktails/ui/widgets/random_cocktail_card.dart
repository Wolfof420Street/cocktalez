import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';
import 'package:cocktalez/app/components/regular_text.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget randomCocktailCard(CocktailObject cocktailObject, BuildContext ctx) {
  Size size = MediaQuery.of(ctx).size;

  return Container(
    height: size.height * 0.4,
    width: size.width,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
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
                  color: AppColors.secondary, fontSize: 30),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    ),
  );
}
