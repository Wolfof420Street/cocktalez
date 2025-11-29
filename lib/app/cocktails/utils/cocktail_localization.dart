import 'package:flutter/material.dart';
import '../data/model/cocktail.dart';

extension CocktailLocalization on CocktailObject {
  String instructionFor(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return strInstructionsES ?? strInstructions;
      case 'de':
        return strInstructionsDE; // strInstructionsDE is not nullable in model, but logic holds
      case 'fr':
        return strInstructionsFR ?? strInstructions;
      case 'it':
        return strInstructionsIT; // strInstructionsIT is not nullable in model
      case 'zh':
        if (locale.scriptCode == 'Hans') {
          return strInstructionsZHHANS ?? strInstructions;
        } else if (locale.scriptCode == 'Hant') {
          return strInstructionsZHHANT ?? strInstructions;
        }
        return strInstructions;
      default:
        return strInstructions;
    }
  }
}
