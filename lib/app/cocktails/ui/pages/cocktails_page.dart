import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/alcohol_cocktails.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/random_cocktail_card.dart';
import 'package:cocktalez/main.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';
import '../widgets/non-alcoholic-cocktails.dart';

class CocktailsPage extends StatefulWidget {
  const CocktailsPage({super.key});

  @override
  State<CocktailsPage> createState() => _CocktailsPageState();
}

class _CocktailsPageState extends State<CocktailsPage>  with SingleTickerProviderStateMixin  {
  FullCocktailResponse? fullCocktailResponse;

   TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(randomCocktailProvider).map(
          data: (randomCocktailAsyncvalue) {
        var randomCocktailValue = randomCocktailAsyncvalue.value;

        if (kDebugMode) {
          print('Value : $randomCocktailValue');
        }

        if (randomCocktailValue is FullCocktailResponse) {
          fullCocktailResponse = randomCocktailValue;
        } else {
          
        }
        return Scaffold(
          body: SafeArea(
            child: Column(children:  [
              Gap($dimensions.insets.xl),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: $dimensions.insets.md),
                child: const Text("Mix & Sip: Unleash the Magic of Spirited Concoctions! 🍹✨",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        )),
              ),
               Gap($dimensions.insets.xl),
                Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for Cocktails',
          filled: true,
          
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
           
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    ),
   Gap($dimensions.insets.xl),
              TabBar(
                controller: _tabController!,
                tabs: const [
                  Tab(
                  child: Text(
                    'Random',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Alcoholic',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                   Tab(
                  child: Text(
                    'Mocktails',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                ]),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      randomCocktailCard(
                        fullCocktailResponse!.drinks.first,
                        context
                      ),
                      const AlcoholicCocktails(),
                      const NonAlcoholicCocktails()
                    ],
                  ),
                ),
            ]),
          ),
        );
      }, loading: (_) {
        return Scaffold(
          body: Center(
            child: Lottie.asset('assets/anim/intro_loading.json'),
          ),
        );
      }, error: (error) {
        return Scaffold(body: customErrorWidget(() {
          return ref.refresh(randomCocktailProvider);
        }));
      });
    });
  }
}
