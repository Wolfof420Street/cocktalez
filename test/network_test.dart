import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:cocktalez/constants/endpoints.dart';
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

  test('getAlcoholicCocktails returns CocktailResponse when the call is successful', () async {
    when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.getAlcoholicCocktails}'),
        data: {
          "drinks": [
            {"strDrink": "Margarita", "strDrinkThumb": "https://someurl.com", "idDrink": "11007"}
          ]
        },
        statusCode: 200,
      ),
    );

    var result = await cocktailService.getAlcoholicCocktails();

    expect(result, isA<CocktailResponse>());
    expect(result.drinks[0].strDrink, 'Margarita');
  });

  test('getNonAlcoholicCocktails returns CocktailResponse when the call is successful', () async {
  when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'))
      .thenAnswer(
    (_) async => Response(
      requestOptions: RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.getNonAlcoholicCocktails}'),
      data: {
        "drinks": [
          {"strDrink": "Mocktail", "strDrinkThumb": "https://someurl.com", "idDrink": "11008"}
        ]
      },
      statusCode: 200,
    ),
  );

  var result = await cocktailService.getNonAlcoholicCocktails();

  expect(result, isA<CocktailResponse>());
  expect(result.drinks[0].strDrink, 'Mocktail');
  });


  test('getRandomCocktail returns FullCocktailResponse when the call is successful', () async {
  when(mockDio.get('${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'))
      .thenAnswer(
    (_) async => Response(
      requestOptions: RequestOptions(path: '${Endpoints.baseUrl}${Endpoints.getRandomCocktail}'),
      data: {
        "drinks": [
          {"strDrink": "Random Cocktail", "strDrinkThumb": "https://someurl.com", "idDrink": "11009"}
        ]
      },
      statusCode: 200,
    ),
  );

  var result = await cocktailService.getRandomCocktail();

  expect(result, isA<FullCocktailResponse>());
  expect(result.drinks[0].strDrink, 'Random Cocktail');
});

}