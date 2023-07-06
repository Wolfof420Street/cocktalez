class IngridientSearchResults {
  late List<Ingredients> ingredients;

  IngridientSearchResults({required this.ingredients});

  factory IngridientSearchResults.fromJson(Map<String, dynamic> json) {
    return IngridientSearchResults(
      ingredients: List<Ingredients>.from(json['ingredients'].map((e) => Ingredients.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ingredients'] = ingredients.map((e) => e.toJson()).toList();
    return data;
  }
}

class Ingredients {
  late String idIngredient;
  late String strIngredient;
  late String strDescription;
  late String strType;
  late String strAlcohol;
  late String strABV;

  Ingredients({
    required this.idIngredient,
    required this.strIngredient,
    required this.strDescription,
    required this.strType,
    required this.strAlcohol,
    required this.strABV,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      idIngredient: json['idIngredient'],
      strIngredient: json['strIngredient'],
      strDescription: json['strDescription'],
      strType: json['strType'],
      strAlcohol: json['strAlcohol'],
      strABV: json['strABV'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idIngredient'] = idIngredient;
    data['strIngredient'] = strIngredient;
    data['strDescription'] = strDescription;
    data['strType'] = strType;
    data['strAlcohol'] = strAlcohol;
    data['strABV'] = strABV;
    return data;
  }
}
