import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../network/api_client.dart';

/// Repository responsible for fetching search-related data.
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
class SearchRepository {
  final ApiClient _client;

  SearchRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<FullCocktailResponse> searchCocktails(String query) async {
    if (kDebugMode) debugPrint('SearchRepository: searching cocktails with query: $query');

    return _client.get<FullCocktailResponse>(
      Endpoints.search,
      queryParameters: {'s': query},
      decoder: (json) => FullCocktailResponse.fromJson(json),
    );
  }

  Future<FullCocktailResponse> searchIngredient(String ingredient) async {
    if (kDebugMode) debugPrint('SearchRepository: searching by ingredient: $ingredient');

    return _client.get<FullCocktailResponse>(
      Endpoints.search,
      queryParameters: {'i': ingredient},
      decoder: (json) => FullCocktailResponse.fromJson(json),
    );
  }
}
