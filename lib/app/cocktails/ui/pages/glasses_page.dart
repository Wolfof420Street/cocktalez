import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/components/app_header.dart';
import 'package:cocktalez/app/glass/ui/widgets/glass_card.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../components/error_widget.dart';
import '../../../glass/provider/glass_provider.dart';

class GlassesPage extends StatefulWidget {
  const GlassesPage({super.key});

  @override
  State<GlassesPage> createState() => _GlassesPageState();
}

class _GlassesPageState extends State<GlassesPage> {
  final double _listPadding = 20;
  final ScrollController _scrollController = ScrollController();



  String? _selectedGlass;

  GlassResponse? _glassResponse;

  void _handleDrinkTapped(Drinks drink) {
    setState(() {
      //If the same drink was tapped twice, un-select it
      if (_selectedGlass == drink.strGlass) {
        _selectedGlass = null;
      }
      //Open tapped drink card and scroll to it
      else {
        _selectedGlass = drink.strGlass;
        var selectedIndex = _glassResponse?.drinks.indexOf(drink);
        var closedHeight = GlassCard.nominalHeightClosed;
        //Calculate scrollTo offset, subtract a bit so we don't end up perfectly at the top
      var offset = selectedIndex! * (closedHeight + _listPadding) - closedHeight * .35;
        _scrollController.animateTo(offset, duration: const Duration(milliseconds: 700), curve: Curves.easeOutQuad);
      }
    });
  }

   Widget _buildListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _listPadding / 2, horizontal: _listPadding),
      child: GlassCard(
        isOpen: _glassResponse!.drinks[index].strGlass == _selectedGlass,
        drink: _glassResponse!.drinks[index],
        onTap: (Drinks drink) {

          _handleDrinkTapped(drink);
          
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      return ref.watch(glassesProvider).map(data: (glassesAsyncValue) {
        var glasses = glassesAsyncValue.value;

        if(glasses is Failure) {
          return Scaffold(body: customErrorWidget(() {
            return ref.refresh(glassesProvider);
          }, context: context));
        } 

        _glassResponse = glasses;

        return  Scaffold(
          appBar: PreferredSize(
            preferredSize: $dimensions.sizes.minAppSize,
            child: const AppHeader(
              title: 'Glasses',
              showBackBtn: false)),
          body: ListView.builder(
            itemCount: _glassResponse!.drinks.length, 
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 40, top: 10),
            itemBuilder: (context, index) => _buildListItem(index),
            
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
        }, context: context));
      });
    });
  }
}
