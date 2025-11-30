import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../../../../network/api_client.dart';

/// Repository responsible for fetching glass-related data.
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
class GlassRepository {
  final ApiClient _client;

  GlassRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<GlassResponse> getGlasses() async {
    if (kDebugMode) debugPrint('GlassRepository: fetching glasses');

    return _client.get<GlassResponse>(
      Endpoints.getGlasses,
      decoder: (json) => GlassResponse.fromJson(json),
    );
  }
}
