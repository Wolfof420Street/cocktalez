import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../network/api_client.dart';

/// Repository responsible for fetching ingredient-related data.
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
class IngredientRepository {
  final ApiClient _client;

  IngredientRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<IngridientsResponse> getIngredients() async {
    if (kDebugMode) debugPrint('IngredientRepository: fetching ingredients');

    return _client.get<IngridientsResponse>(
      Endpoints.getIngridients,
      decoder: (json) => IngridientsResponse.fromJson(json),
    );
  }
}
