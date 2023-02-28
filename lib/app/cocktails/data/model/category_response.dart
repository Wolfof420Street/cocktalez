class CategoryResponse {
  CategoryResponse({
    required this.drinks,
  });
  late final List<Drinks> drinks;
  
  CategoryResponse.fromJson(Map<String, dynamic> json){
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
    required this.strCategory,
  });
  late final String strCategory;
  
  Drinks.fromJson(Map<String, dynamic> json){
    strCategory = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strCategory'] = strCategory;
    return data;
  }
}