class GlassResponse {
  GlassResponse({
    required this.drinks,
  });
  late final List<Drinks> drinks;
  
  GlassResponse.fromJson(Map<String, dynamic> json){
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
    required this.strGlass,
  });
  late final String strGlass;
  
  Drinks.fromJson(Map<String, dynamic> json){
    strGlass = json['strGlass'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strGlass'] = strGlass;
    return data;
  }
}