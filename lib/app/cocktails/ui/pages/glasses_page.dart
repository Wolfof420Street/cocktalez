import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';

class GlassesPage extends StatefulWidget {
  const GlassesPage({super.key});

  @override
  State<GlassesPage> createState() => _GlassesPageState();
}

class _GlassesPageState extends State<GlassesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(glassesProvider).map(data: (glassesAsyncValue) {
        return const Scaffold();
      },loading: (_) {
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
