class CategoryResponse {
  late final List<Drinks> drinks;

  CategoryResponse({required this.drinks});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      drinks: List<Drinks>.from(json['drinks'].map((e) => Drinks.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drinks': drinks.map((e) => e.toJson()).toList(),
    };
  }
}

class Drinks {
  late final String strCategory;

  Drinks({required this.strCategory});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      strCategory: json['strCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strCategory': strCategory,
    };
  }
}
