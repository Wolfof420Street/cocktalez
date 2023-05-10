import 'package:cocktalez/app/cocktails/data/model/category_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/network_provider.dart';

final cocktailServiceProvider = Provider<CocktailService>((ref) {
  var dio = ref.read(networkProvider);
  return CocktailService(dio);
});

class CocktailService {
  Dio dio;

  CocktailService(this.dio);

  getAlcoholicCocktails() async {
    try {
      var response = await dio
          .get('${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}');

      if (response.statusCode == 200) {
        CocktailResponse cocktailResponse =
            CocktailResponse.fromJson(response.data);

        return cocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getNonAlcoholicCocktails() async {
    try {
      var response = await dio
          .get('${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}');

      if (response.statusCode == 200) {
        CocktailResponse cocktailResponse =
            CocktailResponse.fromJson(response.data);

        return cocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getCategories() async {
    try {
      var response =
          await dio.get("${Endpoints.baseUrl}${Endpoints.getCategories}");

      if (response.statusCode == 200) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(response.data);

        return categoryResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getGlasses() async {
    try {
      var response =
          await dio.get('${Endpoints.baseUrl}${Endpoints.getGlasses}');

      if (response.statusCode == 200) {
        GlassResponse glassResponse = GlassResponse.fromJson(response.data);

        return glassResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getIngridients() async {
    try {
      var response =
          await dio.get('${Endpoints.baseUrl}${Endpoints.getIngridients}');

      if (response.statusCode == 200) {
        IngridientsResponse glassResponse =
            IngridientsResponse.fromJson(response.data);

        return glassResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getRandomCocktail() async {
    try {
      var response =
          await dio.get('${Endpoints.baseUrl}${Endpoints.getRandomCocktail}');

      if (kDebugMode) {
        print("Response : ${response.data}");
      }

      if (response.statusCode == 200) {
        FullCocktailResponse fullCocktailResponse =
            FullCocktailResponse.fromJson(response.data);
        if (kDebugMode) {
          print('Cocktail Response : ${fullCocktailResponse.toJson()}');
        }
        return fullCocktailResponse;
      } else {
        if (kDebugMode) {
          print('Failure : ${response.statusMessage}');
        }
        return Failure(response.statusMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failure : $e');
      }
      return Failure('$e');
    }
  }

  getCocktailDetails(String id) async {
    try {
      var response = await dio.get(
          '${Endpoints.baseUrl}${Endpoints.getCocktailDetails}',
          queryParameters: {'i': id});

      if (response.statusCode == 200) {
        FullCocktailResponse fullCocktailResponse =
            FullCocktailResponse.fromJson(response.data);

        return fullCocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getCocktailsByGlass(String glass) async {
    try {
      var response = await dio.get(
          '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
          queryParameters: {'g': glass});

      if (response.statusCode == 200) {
        CocktailResponse fullCocktailResponse =
            CocktailResponse.fromJson(response.data);

        return fullCocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getCocktailsByCategory(String category) async {
    try {
      var response = await dio.get(
          '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
          queryParameters: {'c': category});

      if (response.statusCode == 200) {
        CocktailResponse fullCocktailResponse =
            CocktailResponse.fromJson(response.data);

        return fullCocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  getCocktailsByIngredient(String ingridient) async {
    try {
      var response = await dio.get(
          '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
          queryParameters: {'i': ingridient});

      if (response.statusCode == 200) {
        CocktailResponse fullCocktailResponse =
            CocktailResponse.fromJson(response.data);

        return fullCocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  

 }
