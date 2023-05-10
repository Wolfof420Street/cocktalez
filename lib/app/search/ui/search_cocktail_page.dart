import 'package:flutter/material.dart';



class CocktailSearchScreen extends StatefulWidget {
  const CocktailSearchScreen({super.key});

  @override
  State<CocktailSearchScreen> createState() => _CocktailSearchScreenState();
}

class _CocktailSearchScreenState extends State<CocktailSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Search'),
      ),
      body: const Center(
        child: Text('Cocktail Search'),
      ),
    );
  }
}