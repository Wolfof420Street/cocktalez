import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IngridientsSearchPage extends StatefulWidget {
  final String ingredient;

  const IngridientsSearchPage({super.key, required this.ingredient});

  @override
  State<IngridientsSearchPage> createState() => _IngridientsSearchPageState();
}

class _IngridientsSearchPageState extends State<IngridientsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ingridients Search'),
        ),
        body: const Center(
          child: Text('Ingridients Search'),
        ),
      );
    }));
  }
}
