import '../data/model/cocktail.dart';

class IngredientMeasure {
  final String ingredient;
  final String measure;

  const IngredientMeasure(this.ingredient, this.measure);
}

extension CocktailIngredients on CocktailObject {
  List<IngredientMeasure> get ingredients {
    final List<IngredientMeasure> list = [];
    
    void addIfValid(String? ingredient, String? measure) {
      if (ingredient != null && ingredient.isNotEmpty) {
        list.add(IngredientMeasure(ingredient, measure ?? ""));
      }
    }

    addIfValid(strIngredient1, strMeasure1);
    addIfValid(strIngredient2, strMeasure2);
    addIfValid(strIngredient3, strMeasure3);
    addIfValid(strIngredient4, strMeasure4);
    addIfValid(strIngredient5, strMeasure5);
    addIfValid(strIngredient6, strMeasure6);
    addIfValid(strIngredient7, strMeasure7);
    addIfValid(strIngredient8, strMeasure8);
    addIfValid(strIngredient9, strMeasure9);
    addIfValid(strIngredient10, strMeasure10);
    addIfValid(strIngredient11, strMeasure11);
    addIfValid(strIngredient12, strMeasure12);
    addIfValid(strIngredient13, strMeasure13);
    addIfValid(strIngredient14, strMeasure14);
    addIfValid(strIngredient15, strMeasure15);

    return list;
  }

  List<String> get ingredientsWithMeasures {
    final List<String> list = [];

    void addIfValid(String? ingredient, String? measure) {
      if (ingredient != null && ingredient.isNotEmpty) {
        if (measure != null && measure.isNotEmpty) {
          list.add("$measure $ingredient");
        } else {
          list.add(ingredient);
        }
      }
    }

    addIfValid(strIngredient1, strMeasure1);
    addIfValid(strIngredient2, strMeasure2);
    addIfValid(strIngredient3, strMeasure3);
    addIfValid(strIngredient4, strMeasure4);
    addIfValid(strIngredient5, strMeasure5);
    addIfValid(strIngredient6, strMeasure6);
    addIfValid(strIngredient7, strMeasure7);
    addIfValid(strIngredient8, strMeasure8);
    addIfValid(strIngredient9, strMeasure9);
    addIfValid(strIngredient10, strMeasure10);
    addIfValid(strIngredient11, strMeasure11);
    addIfValid(strIngredient12, strMeasure12);
    addIfValid(strIngredient13, strMeasure13);
    addIfValid(strIngredient14, strMeasure14);
    addIfValid(strIngredient15, strMeasure15);

    return list;
  }
}
