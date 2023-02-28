class IngridientsResponse {
  IngridientsResponse({
    required this.drinks,
  });
  late final List<Drinks> drinks;
  
  IngridientsResponse.fromJson(Map<String, dynamic> json){
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
    required this.strIngredient1,
  });
  late final String strIngredient1;
  
  Drinks.fromJson(Map<String, dynamic> json){
    strIngredient1 = json['strIngredient1'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strIngredient1'] = strIngredient1;
    return data;
  }
}