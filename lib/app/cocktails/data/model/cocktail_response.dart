class CocktailResponse {
  CocktailResponse({
    required this.drinks,
  });

  final List<Drinks> drinks;

  factory CocktailResponse.fromJson(Map<String, dynamic> json) {
    return CocktailResponse(
      drinks: List.from(json['drinks']).map((e) => Drinks.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drinks': drinks.map((e) => e.toJson()).toList(),
    };
  }
}

class Drinks {
  Drinks({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  final String strDrink;
  final String strDrinkThumb;
  final String idDrink;

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      strDrink: json['strDrink'],
      strDrinkThumb: json['strDrinkThumb'],
      idDrink: json['idDrink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strDrink': strDrink,
      'strDrinkThumb': strDrinkThumb,
      'idDrink': idDrink,
    };
  }
}
