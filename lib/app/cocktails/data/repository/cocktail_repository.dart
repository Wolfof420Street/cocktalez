import 'package:cocktalez/app/cocktails/data/model/category_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../network/api_client.dart';

/// Repository responsible for fetching cocktail-related data.
///
/// Responsibilities:
/// - Compose endpoint paths and query parameters
/// - Call the shared [ApiClient] to execute network requests
/// - Decode JSON into strongly-typed domain objects
///
/// This class intentionally does not perform error-to-Failure conversion —
/// network errors bubble as exceptions (for Riverpod providers to treat as
/// failure states). If you prefer the old `Failure` objects, we can add a
/// conversion layer later.
class CocktailRepository {
  final ApiClient _client;

  CocktailRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<CocktailResponse> getAlcoholicCocktails() async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching alcoholic cocktails');
    return _client.get<CocktailResponse>(
      Endpoints.getAlcoholicCocktails,
      decoder: (json) => CocktailResponse.fromJson(json),
    );
  }

  Future<FullCocktailResponse> getPopularCocktails() async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching popular cocktails');

    return _client.get<FullCocktailResponse>(
      Endpoints.popular,
      decoder: (json) => FullCocktailResponse.fromJson(json),
    );
  }

  Future<CocktailResponse> getNonAlcoholicCocktails() async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching non-alcoholic cocktails');

    return _client.get<CocktailResponse>(
      Endpoints.getNonAlcoholicCocktails,
      decoder: (json) => CocktailResponse.fromJson(json),
    );
  }

  Future<CategoryResponse> getCategories() async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching categories');

    return _client.get<CategoryResponse>(
      Endpoints.getCategories,
      decoder: (json) => CategoryResponse.fromJson(json),
    );
  }

  Future<FullCocktailResponse> getRandomCocktail() async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching random cocktail');

    return _client.get<FullCocktailResponse>(
      Endpoints.getRandomCocktail,
      decoder: (json) => FullCocktailResponse.fromJson(json),
    );
  }

  Future<FullCocktailResponse> getCocktailDetails(String id) async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching details for id=$id');

    return _client.get<FullCocktailResponse>(
      Endpoints.getCocktailDetails,
      queryParameters: {'i': id},
      decoder: (json) => FullCocktailResponse.fromJson(json),
    );
  }

  Future<CocktailResponse> getCocktailsByGlass(String glass) async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching cocktails by glass=$glass');

    return _client.get<CocktailResponse>(
      Endpoints.filterCocktail,
      queryParameters: {'g': glass},
      decoder: (json) => CocktailResponse.fromJson(json),
    );
  }

  Future<CocktailResponse> getCocktailsByCategory(String category) async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching cocktails by category=$category');

    return _client.get<CocktailResponse>(
      Endpoints.filterCocktail,
      queryParameters: {'c': category},
      decoder: (json) => CocktailResponse.fromJson(json),
    );
  }

  Future<CocktailResponse> getCocktailsByIngredient(String ingredient) async {
    if (kDebugMode) debugPrint('CocktailRepository: fetching cocktails by ingredient=$ingredient');

    return _client.get<CocktailResponse>(
      Endpoints.filterCocktail,
      queryParameters: {'i': ingredient},
      decoder: (json) => CocktailResponse.fromJson(json),
    );
  }
}
