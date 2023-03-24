class CocktailResponse {
  CocktailResponse({
    required this.drinks,
  });
  late final List<Drinks> drinks;
  
  CocktailResponse.fromJson(Map<String, dynamic> json){
    drinks = List.from(json['drinks']).map((e)=>Drinks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['drinks'] = drinks.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Drinks {
  Drinks({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });
  late final String strDrink;
  late final String strDrinkThumb;
  late final String idDrink;
  
  Drinks.fromJson(Map<String, dynamic> json){
    strDrink = json['strDrink'];
    strDrinkThumb = json['strDrinkThumb'];
    idDrink = json['idDrink'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strDrink'] = strDrink;
    data['strDrinkThumb'] = strDrinkThumb;
    data['idDrink'] = idDrink;
    return data;
  }
}