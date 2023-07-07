class IngridientsResponse {
  late List<Drinks> drinks;

  IngridientsResponse({required this.drinks});

  factory IngridientsResponse.fromJson(Map<String, dynamic> json) {
    return IngridientsResponse(
      drinks: List<Drinks>.from(json['drinks'].map((e) => Drinks.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['drinks'] = drinks.map((e) => e.toJson()).toList();
    return data;
  }
}

class Drinks {
  late String strIngredient1;

  Drinks({required this.strIngredient1});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      strIngredient1: json['strIngredient1'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strIngredient1'] = strIngredient1;
    return data;
  }
}
