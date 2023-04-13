import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';
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
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            onPressed: () {
              // Handle search action here
            },
            icon: Icon(Icons.search, color: Theme.of(ctx).iconTheme.color),
          ),
        ),
      ],
    ),
  );
}
