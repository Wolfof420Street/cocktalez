import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/alcohol_cocktails.dart';
import 'package:cocktalez/app/search/ui/pages/search_cocktail_page.dart';
import 'package:cocktalez/main.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';
import '../widgets/non_alcoholic_cocktails.dart';

class CocktailsPage extends StatefulWidget {
  const CocktailsPage({Key? key}) : super(key: key);

  @override
  _CocktailsPageState createState() => _CocktailsPageState();
}

class _CocktailsPageState extends State<CocktailsPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          return ref.watch(randomCocktailProvider).when(
            data: (randomCocktailValue) {
              if (kDebugMode) print('Value : $randomCocktailValue');

              return Column(
                children: [
                  Gap($dimensions.insets.xl),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.md),
                    child: const Text(
                      "Mix & Sip: Unleash the Magic of Spirited Concoctions! 🍹✨",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap($dimensions.insets.xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
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
                  Expanded(
                    child: _searchController.text.isNotEmpty && _searchController.text.length > 3
                        ? CocktailSearchScreen(searchQuery: _searchController.text)
                        : _buildTabbedContent(),
                  ),
                ],
              );
            },
            loading: () => Center(child: Lottie.asset('assets/anim/intro_loading.json')),
            error: (_, __) => customErrorWidget(() {}),
          );
        }),
      ),
    );
  }

  Widget _buildTabbedContent() {
    return Column(
      children: [
        TabBar(
          controller: _tabController!,
          tabs: const [
            Tab(
              child: Text(
                'Popular',
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
          ],
        ),
        Gap($dimensions.insets.xl),
        Expanded(
            child: TabBarView(
            controller: _tabController,
            children: const [
              AlcoholicCocktails(),
              AlcoholicCocktails(),
              NonAlcoholicCocktails(),
            ],
          ),
        ),
      ],
    );
  }
}

