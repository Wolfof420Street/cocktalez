class IngridientSearchResults {
  IngridientSearchResults({
    required this.ingredients,
  });
  late final List<Ingredients> ingredients;
  
  IngridientSearchResults.fromJson(Map<String, dynamic> json){
    ingredients = List.from(json['ingredients']).map((e)=>Ingredients.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ingredients'] = ingredients.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Ingredients {
  Ingredients({
    required this.idIngredient,
    required this.strIngredient,
    required this.strDescription,
    required this.strType,
    required this.strAlcohol,
    required this.strABV,
  });
  late final String idIngredient;
  late final String strIngredient;
  late final String strDescription;
  late final String strType;
  late final String strAlcohol;
  late final String strABV;
  
  Ingredients.fromJson(Map<String, dynamic> json){
    idIngredient = json['idIngredient'];
    strIngredient = json['strIngredient'];
    strDescription = json['strDescription'];
    strType = json['strType'];
    strAlcohol = json['strAlcohol'];
    strABV = json['strABV'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idIngredient'] = idIngredient;
    _data['strIngredient'] = strIngredient;
    _data['strDescription'] = strDescription;
    _data['strType'] = strType;
    _data['strAlcohol'] = strAlcohol;
    _data['strABV'] = strABV;
    return _data;
  }
}