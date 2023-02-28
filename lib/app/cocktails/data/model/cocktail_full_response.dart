import 'package:cocktalez/app/cocktails/data/model/cocktail.dart';

class FullCocktailResponse {
  FullCocktailResponse({
    required this.drinks,
  });
  late final List<CocktailObject> drinks;
  
  FullCocktailResponse.fromJson(Map<String, dynamic> json){
    drinks = List.from(json['drinks']).map((e)=>CocktailObject.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['drinks'] = drinks.map((e)=>e.toJson()).toList();
    return _data;
  }
}