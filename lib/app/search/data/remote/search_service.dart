import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:dio/dio.dart';

import '../../../../constants/endpoints.dart';



class SearchService {
  final Dio dio;

  SearchService(this.dio);

  searchCocktails(String query) async {
    try {
      var response = await dio.get("${Endpoints.baseUrl}${Endpoints.search}",
          queryParameters: {'s': query});

      if (response.statusCode == 200) {
        FullCocktailResponse cocktailResponse =
            FullCocktailResponse.fromJson(response.data);

        return cocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  searchIngridient(String ingridient) async {
    try {
      var response = await dio.get("${Endpoints.baseUrl}${Endpoints.search}",
          queryParameters: {'i': ingridient});

      if (response.statusCode == 200) {
        FullCocktailResponse cocktailResponse =
            FullCocktailResponse.fromJson(response.data);

        return cocktailResponse;
      } else {
        return Failure(response.statusMessage);
      }
    } catch (e) {
      return Failure('$e');
    }
  }

  
}
