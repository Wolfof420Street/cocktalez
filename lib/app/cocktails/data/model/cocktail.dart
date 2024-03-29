class CocktailObject {
  late final String idDrink;
  late final String strDrink;
  late final String? strDrinkAlternate;
  late final String strTags;
  late final String? strVideo;
  late final String strCategory;
  late final String strIBA;
  late final String strAlcoholic;
  late final String strGlass;
  late final String strInstructions;
  late final String? strInstructionsES;
  late final String strInstructionsDE;
  late final String? strInstructionsFR;
  late final String strInstructionsIT;
  late final String? strInstructionsZHHANS;
  late final String? strInstructionsZHHANT;
  late final String strDrinkThumb;
  late final String strIngredient1;
  late final String strIngredient2;
  late final String strIngredient3;
  late final String strIngredient4;
  late final String? strIngredient5;
  late final String? strIngredient6;
  late final String? strIngredient7;
  late final String? strIngredient8;
  late final String? strIngredient9;
  late final String? strIngredient10;
  late final String? strIngredient11;
  late final String? strIngredient12;
  late final String? strIngredient13;
  late final String? strIngredient14;
  late final String? strIngredient15;
  late final String strMeasure1;
  late final String strMeasure2;
  late final String strMeasure3;
  late final String? strMeasure4;
  late final String? strMeasure5;
  late final String? strMeasure6;
  late final String? strMeasure7;
  late final String? strMeasure8;
  late final String? strMeasure9;
  late final String? strMeasure10;
  late final String? strMeasure11;
  late final String? strMeasure12;
  late final String? strMeasure13;
  late final String? strMeasure14;
  late final String? strMeasure15;
  late final String strImageSource;
  late final String strImageAttribution;
  late final String strCreativeCommonsConfirmed;
  late final String dateModified;

  CocktailObject({
    required this.idDrink,
    required this.strDrink,
    this.strDrinkAlternate,
    required this.strTags,
    this.strVideo,
    required this.strCategory,
    required this.strIBA,
    required this.strAlcoholic,
    required this.strGlass,
    required this.strInstructions,
    this.strInstructionsES,
    required this.strInstructionsDE,
    this.strInstructionsFR,
    required this.strInstructionsIT,
    this.strInstructionsZHHANS,
    this.strInstructionsZHHANT,
    required this.strDrinkThumb,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    required this.strMeasure1,
    required this.strMeasure2,
    required this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    required this.strImageSource,
    required this.strImageAttribution,
    required this.strCreativeCommonsConfirmed,
    required this.dateModified,
  });

  factory CocktailObject.fromJson(Map<String, dynamic> json) {
    return CocktailObject(
      idDrink: json['idDrink'] ?? '',
      strDrink: json['strDrink'] ?? '',
      strDrinkAlternate: json['strDrinkAlternate'],
      strTags: json['strTags'] ?? '',
      strVideo: json['strVideo'],
      strCategory: json['strCategory'] ?? '',
      strIBA: json['strIBA'] ?? '',
      strAlcoholic: json['strAlcoholic'] ?? '',
      strGlass: json['strGlass'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strInstructionsES: json['strInstructionsES'],
      strInstructionsDE: json['strInstructionsDE'] ?? '',
      strInstructionsFR: json['strInstructionsFR'],
      strInstructionsIT: json['strInstructionsIT'] ?? '',
      strInstructionsZHHANS: json['strInstructionsZH-HANS'],
      strInstructionsZHHANT: json['strInstructionsZH-HANT'],
      strDrinkThumb: json['strDrinkThumb'] ?? '',
      strIngredient1: json['strIngredient1'] ?? '',
      strIngredient2: json['strIngredient2'] ?? '',
      strIngredient3: json['strIngredient3'] ?? '',
      strIngredient4: json['strIngredient4'] ?? '',
      strIngredient5: json['strIngredient5'],
      strIngredient6: json['strIngredient6'],
      strIngredient7: json['strIngredient7'],
      strIngredient8: json['strIngredient8'],
      strIngredient9: json['strIngredient9'],
      strIngredient10: json['strIngredient10'],
      strIngredient11: json['strIngredient11'],
      strIngredient12: json['strIngredient12'],
      strIngredient13: json['strIngredient13'],
      strIngredient14: json['strIngredient14'],
      strIngredient15: json['strIngredient15'],
      strMeasure1: json['strMeasure1'] ?? '',
      strMeasure2: json['strMeasure2'] ?? '',
      strMeasure3: json['strMeasure3'] ?? '',
      strMeasure4: json['strMeasure4'],
      strMeasure5: json['strMeasure5'],
      strMeasure6: json['strMeasure6'],
      strMeasure7: json['strMeasure7'],
      strMeasure8: json['strMeasure8'],
      strMeasure9: json['strMeasure9'],
      strMeasure10: json['strMeasure10'],
      strMeasure11: json['strMeasure11'],
      strMeasure12: json['strMeasure12'],
      strMeasure13: json['strMeasure13'],
      strMeasure14: json['strMeasure14'],
      strMeasure15: json['strMeasure15'],
      strImageSource: json['strImageSource'] ?? '',
      strImageAttribution: json['strImageAttribution'] ?? '',
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] ?? '',
      dateModified: json['dateModified'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDrink': idDrink,
      'strDrink': strDrink,
      'strDrinkAlternate': strDrinkAlternate,
      'strTags': strTags,
      'strVideo': strVideo,
      'strCategory': strCategory,
      'strIBA': strIBA,
           'strAlcoholic': strAlcoholic,
      'strGlass': strGlass,
      'strInstructions': strInstructions,
      'strInstructionsES': strInstructionsES,
      'strInstructionsDE': strInstructionsDE,
      'strInstructionsFR': strInstructionsFR,
      'strInstructionsIT': strInstructionsIT,
      'strInstructionsZHHANS': strInstructionsZHHANS,
      'strInstructionsZHHANT': strInstructionsZHHANT,
      'strDrinkThumb': strDrinkThumb,
      'strIngredient1': strIngredient1,
      'strIngredient2': strIngredient2,
      'strIngredient3': strIngredient3,
      'strIngredient4': strIngredient4,
      'strIngredient5': strIngredient5,
      'strIngredient6': strIngredient6,
      'strIngredient7': strIngredient7,
      'strIngredient8': strIngredient8,
      'strIngredient9': strIngredient9,
      'strIngredient10': strIngredient10,
      'strIngredient11': strIngredient11,
      'strIngredient12': strIngredient12,
      'strIngredient13': strIngredient13,
      'strIngredient14': strIngredient14,
      'strIngredient15': strIngredient15,
      'strMeasure1': strMeasure1,
      'strMeasure2': strMeasure2,
      'strMeasure3': strMeasure3,
      'strMeasure4': strMeasure4,
      'strMeasure5': strMeasure5,
      'strMeasure6': strMeasure6,
      'strMeasure7': strMeasure7,
      'strMeasure8': strMeasure8,
      'strMeasure9': strMeasure9,
      'strMeasure10': strMeasure10,
      'strMeasure11': strMeasure11,
      'strMeasure12': strMeasure12,
      'strMeasure13': strMeasure13,
      'strMeasure14': strMeasure14,
      'strMeasure15': strMeasure15,
      'strImageSource': strImageSource,
      'strImageAttribution': strImageAttribution,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };
  }
}


