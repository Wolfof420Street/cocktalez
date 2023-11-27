import 'package:cocktalez/app/cocktails/data/model/category_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:dio/dio.dart';


class CocktailService {
  final Dio dio;

  CocktailService(this.dio);

  Future<Result<T, Failure>> _getGenericCocktailResponse<T>(
      String endpoint, T Function(dynamic data) fromJson,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.get('${Endpoints.baseUrl}$endpoint',
          queryParameters: queryParameters);

      if (response.statusCode == 200) {
        T result = fromJson(response.data);
        return Result.success(result);
      } else {
        return Result.failure(
            Failure(response.statusMessage, type: "HTTP Error"));
      }
    } catch (e) {
      return Result.failure(Failure(e.toString(), type: "Exception"));
    }
  }

  Future<Result<CocktailResponse, Failure>> getAlcoholicCocktails() async {
    return _getGenericCocktailResponse(
        Endpoints.getAlcoholicCocktails, (data) => CocktailResponse.fromJson(data));
  }

  Future<Result<FullCocktailResponse, Failure>> getPopularCocktails() async {
    return _getGenericCocktailResponse(Endpoints.popular, (data) => FullCocktailResponse.fromJson(data));
  }

  Future<Result<CocktailResponse, Failure>> getNonAlcoholicCocktails() async {
    return _getGenericCocktailResponse(Endpoints.getNonAlcoholicCocktails, (data) => CocktailResponse.fromJson(data));
  }

  Future<Result<CategoryResponse, Failure>> getCategories() async {
    return _getGenericCocktailResponse(Endpoints.getCategories, (data) => CategoryResponse.fromJson(data));
  }

  Future<Result<GlassResponse, Failure>> getGlasses() async {
    return _getGenericCocktailResponse(Endpoints.getGlasses, (data) => GlassResponse.fromJson(data));
  }

  Future<Result<IngridientsResponse, Failure>> getIngridients() async {
    return _getGenericCocktailResponse(Endpoints.getIngridients, (data) => IngridientsResponse.fromJson(data));
  }

  Future<Result<FullCocktailResponse, Failure>> getRandomCocktail() async {
    return _getGenericCocktailResponse(Endpoints.getRandomCocktail, (data) => FullCocktailResponse.fromJson(data));
  }

  Future<Result<FullCocktailResponse, Failure>> getCocktailDetails(
      String id) async {
    return _getGenericCocktailResponse(Endpoints.getCocktailDetails,
        (data) => FullCocktailResponse.fromJson(data),
        queryParameters: {'i': id});
  }

  Future<Result<CocktailResponse, Failure>> getCocktailsByGlass(
      String glass) async {
    return _getGenericCocktailResponse(Endpoints.filterCocktail,
        (data) => CocktailResponse.fromJson(data),
        queryParameters: {'g': glass});
  }

  Future<Result<CocktailResponse, Failure>> getCocktailsByCategory(
      String category) async {
    return _getGenericCocktailResponse(Endpoints.filterCocktail,
        (data) => CocktailResponse.fromJson(data),
        queryParameters: {'c': category});
  }

  Future<Result<CocktailResponse, Failure>> getCocktailsByIngredient(
      String ingredient) async {
    return _getGenericCocktailResponse(Endpoints.filterCocktail,
       (data) => CocktailResponse.fromJson(data),
        queryParameters: {'i': ingredient});
  }
}

class Result<T, E> {
  final T? _data;
  final E? _error;

  Result._(this._data, this._error);

  factory Result.success(T data) => Result._(data, null);
  factory Result.failure(E error) => Result._(null, error);

  T get data => _data!;
  E get error => _error!;

  bool get isSuccess => _data != null;
  bool get isFailure => _error != null;
}
