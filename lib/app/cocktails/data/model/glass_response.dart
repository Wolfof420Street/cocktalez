class GlassResponse {
  GlassResponse({
    required this.drinks,
  });

  factory GlassResponse.fromJson(Map<String, dynamic> json) {
    return GlassResponse(
      drinks: List<Drinks>.from(json['drinks'].map((e) => Drinks.fromJson(e))),
    );
  }

  List<Drinks> drinks;

  Map<String, dynamic> toJson() {
    return {
      'drinks': drinks.map((e) => e.toJson()).toList(),
    };
  }
}

class Drinks {
  Drinks({
    required this.strGlass,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      strGlass: json['strGlass'],
    );
  }

  String strGlass;

  Map<String, dynamic> toJson() {
    return {
      'strGlass': strGlass,
    };
  }
}
