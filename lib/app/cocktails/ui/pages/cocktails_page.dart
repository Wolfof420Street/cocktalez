import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/alcohol_cocktails.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/popular_cocktails.dart';
import 'package:cocktalez/app/search/ui/pages/search_cocktail_page.dart';
import 'package:cocktalez/main.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:cocktalez/app/components/async_data_widget.dart';
import '../../../components/loading_indicator.dart';
import '../widgets/non_alcoholic_cocktails.dart';

class CocktailsPage extends StatefulWidget {
  const CocktailsPage({super.key});

  @override
  createState() => _CocktailsPageState();
}

class _CocktailsPageState extends State<CocktailsPage>
    with SingleTickerProviderStateMixin {
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
    return Consumer(builder: (context, ref, child) {
      return AsyncDataWidget<dynamic>(
        provider: randomCocktailProvider,
        data: (randomCocktailValue) => _buildContent(context, randomCocktailValue),
        loading: () => const AppLoadingIndicator(),
      );
    });
  }

  Widget _buildContent(BuildContext context, dynamic randomCocktailValue) {
    if (kDebugMode) print('Value : $randomCocktailValue');

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final maxWidth = isTablet ? 1200.0 : screenWidth;

    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: isTablet ? 32 : 0,
                    right: isTablet ? 32 : 0,
                  ),
                  child: Column(
                    children: [
                      Gap($dimensions.insets.xl),
                      _buildHeader(isTablet),
                      Gap($dimensions.insets.xl),
                      _buildSearchField(isTablet),
                      Gap($dimensions.insets.xl),
                      _buildMainContent(isTablet),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTapOutside() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget _buildHeader(bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $dimensions.insets.md),
      child: Text(
        "Mix & Sip: Unleash the Magic of Spirited Concoctions! 🍹✨",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isTablet ? 28 : 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 32 : 16,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for Cocktails',
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: isTablet ? 16 : 8,
              horizontal: isTablet ? 24 : 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: isTablet ? 28 : 24,
            ),
          ),
          style: TextStyle(
            fontSize: isTablet ? 18 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(bool isTablet) {
    return _searchController.text.isNotEmpty && _searchController.text.length > 3
        ? CocktailSearchScreen(searchQuery: _searchController.text)
        : _buildTabbedContent(isTablet);
  }

  Widget _buildTabbedContent(bool isTablet) {
    // Calculate appropriate height based on screen size
    final tabBarHeight = isTablet ? 600.0 : 400.0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 0),
          child: TabBar(
            controller: _tabController!,
            tabs: [
              Tab(
                child: Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Alcoholic',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Mocktails',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap($dimensions.insets.xl),
        SizedBox(
          height: tabBarHeight,
          child: TabBarView(
            controller: _tabController,
            children: const [
              PopularCocktails(),
              AlcoholicCocktails(),
              NonAlcoholicCocktails(),
            ],
          ),
        ),
      ],
    );
  }
}