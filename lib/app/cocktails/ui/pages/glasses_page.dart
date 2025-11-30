import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/components/app_header.dart';
import 'package:cocktalez/app/glass/ui/widgets/glass_card.dart';
import 'package:cocktalez/constants/failure.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cocktalez/app/components/async_data_widget.dart';
import 'package:cocktalez/app/components/loading_indicator.dart';import '../../../glass/provider/glass_provider.dart';

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
    return Consumer(builder: (context, ref, child) {
      return AsyncMapWidget<dynamic, GlassResponse>(
        provider: glassesProvider,
        extract: (data) {
          if (data is Failure) return null;
          return data as GlassResponse;
        },
        data: (glasses) {
          _glassResponse = glasses;

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: $dimensions.sizes.minAppSize,
              child: const AppHeader(
                title: 'Glasses',
                showBackBtn: false,
              ),
            ),
            body: ListView.builder(
              itemCount: _glassResponse!.drinks.length,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              itemBuilder: (context, index) => _buildListItem(index),
            ),
          );
        },
        wrapLoadingInScaffold: true,
        loading: () => const AppLoadingIndicator(),
      );
    });
  }
}
