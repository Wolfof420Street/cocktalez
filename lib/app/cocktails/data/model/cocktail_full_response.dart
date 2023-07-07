import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';

class FullCocktailResponse {
  late final List<CocktailObject> drinks;

  FullCocktailResponse({required this.drinks});

  factory FullCocktailResponse.fromJson(Map<String, dynamic> json) {
    return FullCocktailResponse(
      drinks: List<CocktailObject>.from(json['drinks'].map((e) => CocktailObject.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drinks': drinks.map((e) => e.toJson()).toList(),
    };
  }
}
