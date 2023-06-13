
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'mocks/network_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
   
  late CocktailService cocktailService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    cocktailService = CocktailService(mockDio);
  });

  //  testWidgets('IngridientsPage initializes with empty drinks list', (WidgetTester tester) async {
  
  //   final container = ProviderContainer(overrides: [
  //   ingridientsProvider.overrideWith(
      
  //   ),
  // ]);

  // addTearDown(container.dispose);

  
  //   await tester.pumpWidget(
  //     const ProviderScope(  
  //       child: MaterialApp(
  //         home: IngridientsPage(),
  //       ),
  //     ),
  //   );


  // await tester.pumpAndSettle(); // allow any futures to complete

  

  //   expect(find.byType(IngridientsPage), findsOneWidget);
  // });

}