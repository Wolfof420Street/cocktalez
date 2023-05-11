import 'package:cocktalez/app/cocktails/data/model/category_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:cocktalez/constants/endpoints.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'mocks/network_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late CocktailService cocktailService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    cocktailService = CocktailService(mockDio);
  });

  test(
      'getAlcoholicCocktails returns CocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'),
        data: {
          "drinks": [
            {
              "strDrink": "Margarita",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11007"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getAlcoholicCocktails();

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Margarita');
  });

  test(
      'getNonAlcoholicCocktails returns CocktailResponse when the call is successful',
      () async {
    when(mockDio
            .get('${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'),
        data: {
          "drinks": [
            {
              "strDrink": "Mocktail",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11008"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getNonAlcoholicCocktails();

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Mocktail');
  });

  test(
      'getRandomCocktail returns FullCocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'),
        data: {
          "drinks": [
            {
              "strDrink": "Random Cocktail",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11009"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getRandomCocktail();

    expect(result, isA<FullCocktailResponse>());
    expect(result.drinks[0].strDrink, 'Random Cocktail');
  });

  test('getCategories returns CategoryResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getCategories}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getCategories}'),
        data: {
          "drinks": [
            {"strCategory": "Ordinary Drink"}
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getCategories();

    expect(result, isA<CategoryResponse>());
    expect(result.drinks[0].strCategory, 'Ordinary Drink');
  });

  test('getGlasses returns GlassResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getGlasses}')).thenAnswer(
      (_) async => Response(
        requestOptions:
            RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.getGlasses}'),
        data: {
          "drinks": [
            {"strGlass": "Cocktail glass"}
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getGlasses();

    expect(result, isA<GlassResponse>());
    expect(result.drinks[0].strGlass, 'Cocktail glass');
  });

  test('getIngridients returns IngridientsResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getIngridients}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getIngridients}'),
        data: {
          "drinks": [
            {"strIngredient1": "Rum"}
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getIngridients();

    expect(result, isA<IngridientsResponse>());
    expect(result.drinks[0].strIngredient1, 'Rum');
  });

  test(
      'getCocktailDetails returns FullCocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getCocktailDetails}',
        queryParameters: {'i': '11009'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getCocktailDetails}',
            queryParameters: {'i': '11009'}),
        data: {
          "drinks": [
            {
              "strDrink": "Cocktail Details",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11009"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getCocktailDetails('11009');

    expect(result, isA<FullCocktailResponse>());
    expect(result.drinks[0].strDrink, 'Cocktail Details');
  });

// Continue with the tests for getCocktailsByGlass, getCocktailsByCategory, and getCocktailsByIngredient in the same way
  test(
      'getCocktailsByGlass returns CocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}',
        queryParameters: {'g': 'Cocktail glass'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
            queryParameters: {'g': 'Cocktail glass'}),
        data: {
          "drinks": [
            {
              "strDrink": "Glass Cocktail",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11010"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getCocktailsByGlass('Cocktail glass');

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Glass Cocktail');
  });

  test(
      'getCocktailsByCategory returns CocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}',
        queryParameters: {'c': 'Ordinary Drink'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
            queryParameters: {'c': 'Ordinary Drink'}),
        data: {
          "drinks": [
            {
              "strDrink": "Category Cocktail",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11011"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getCocktailsByCategory('Ordinary Drink');

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Category Cocktail');
  });

  test(
      'getCocktailsByIngredient returns CocktailResponse when the call is successful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}',
        queryParameters: {'i': 'Rum'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}',
            queryParameters: {'i': 'Rum'}),
        data: {
          "drinks": [
            {
              "strDrink": "Rum Cocktail",
              "strDrinkThumb": "https://someurl.com",
              "idDrink": "11012"
            }
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getCocktailsByIngredient('Rum');

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Rum Cocktail');
  });

  test('getAlcoholicCocktails returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'),
        statusCode: 404,
        statusMessage: 'Not Found',
      ),
    );

    var result = await cocktailService.getAlcoholicCocktails();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Not Found');
  });

  test('getNonAlcoholicCocktails returns Failure when the call is unsuccessful',
      () async {
    when(mockDio
            .get('${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'),
        statusCode: 500,
        statusMessage: 'Internal Server Error',
      ),
    );

    var result = await cocktailService.getNonAlcoholicCocktails();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Internal Server Error');
  });

  test('getRandomCocktail returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'),
        statusCode: 400,
        statusMessage: 'Bad Request',
      ),
    );

    var result = await cocktailService.getRandomCocktail();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Bad Request');
  });

// Continue this pattern for the rest of the methods
  test('getCategories returns Failure when the call is unsuccessful', () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getCategories}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getCategories}'),
        statusCode: 500,
        statusMessage: 'Internal Server Error',
      ),
    );

    var result = await cocktailService.getCategories();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Internal Server Error');
  });

  test('getGlasses returns Failure when the call is unsuccessful', () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getGlasses}')).thenAnswer(
      (_) async => Response(
        requestOptions:
            RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.getGlasses}'),
        statusCode: 404,
        statusMessage: 'Not Found',
      ),
    );

    var result = await cocktailService.getGlasses();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Not Found');
  });

  test('getIngridients returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getIngridients}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getIngridients}'),
        statusCode: 400,
        statusMessage: 'Bad Request',
      ),
    );

    var result = await cocktailService.getIngridients();

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Bad Request');
  });

  test('getCocktailDetails returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getCocktailDetails}',
        queryParameters: {'i': '12345'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.getCocktailDetails}'),
        statusCode: 500,
        statusMessage: 'Internal Server Error',
      ),
    );

    var result = await cocktailService.getCocktailDetails('12345');

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Internal Server Error');
  });

  test('getCocktailsByGlass returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}',
        queryParameters: {'g': 'Cocktail glass'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}'),
        statusCode: 404,
        statusMessage: 'Not Found',
      ),
    );

    var result = await cocktailService.getCocktailsByGlass('Cocktail glass');

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Not Found');
  });

  test('getCocktailsByCategory returns Failure when the call is unsuccessful',
      () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}',
        queryParameters: {'c': 'Ordinary Drink'})).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
            path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}'),
        statusCode: 400,
        statusMessage: 'Bad Request',
      ),
    );

    var result = await cocktailService.getCocktailsByCategory('Ordinary Drink');

    expect(result, isA<Failure>());
    expect(result.errorMessage, 'Bad Request');
  });

  test('getCocktailsByIngredient returns Failure when the call is unsuccessful', () async {
  when(mockDio.get('${Endpoints.baseUrl}${Endpoints.filterCocktail}', queryParameters: {'i': 'Tequila'}))
      .thenAnswer(
    (_) async => Response(
      requestOptions: RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.filterCocktail}'),
      statusCode: 500,
      statusMessage: 'Internal Server Error',
    ),
  );

  var result = await cocktailService.getCocktailsByIngredient('Tequila');

  expect(result, isA<Failure>());
  expect(result.errorMessage, 'Internal Server Error');
});

}
