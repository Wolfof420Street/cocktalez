

import 'package:cocktalez/app/cocktails/data/model/glass_response.dart';
import 'package:cocktalez/app/components/buttons.dart';
import 'package:cocktalez/app/glass/ui/widgets/liquid_painter.dart';
import 'package:cocktalez/app/glass/ui/widgets/rounded_shadow.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:cocktalez/constants/router.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class GlassCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 220;

  final Function(Drinks) onTap;

  final bool isOpen;

  final Drinks drink;

  const GlassCard(
      {super.key,
      required this.drink,
      required this.onTap,
      this.isOpen = false,
     });

  @override
  createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> with TickerProviderStateMixin {
  bool _wasOpen = false;
  late Animation<double> _fillTween;
  // ignore: unused_field
  late Animation<double> _pointsTween;
  late AnimationController _liquidSimController;

  //Create 2 simulations, that will be passed to the LiquidPainter to be drawn.
  final LiquidSimulation _liquidSim1 = LiquidSimulation();
  final LiquidSimulation _liquidSim2 = LiquidSimulation();

  Row _buildTopContent() {
    return Row(
      children: <Widget>[
        //Icon

        const SizedBox(width: 24),
        //Label
        Expanded(
          child: Text(
            widget.drink.strGlass.toUpperCase(),
          ),
        ),
        //Star Icon
      ],
    );
  }

  Column _buildBottomContent(double pointsValue) {
   
    List<Widget> rowChildren = [];

    if (pointsValue == 0) {
      rowChildren.add(
        Text(widget.drink.strGlass),
      );
    } else {
      rowChildren.addAll([
        Text(
            "Have a look at our ${widget.drink.strGlass} cocktails!"),
        Text(
          "We have ${pointsValue.round()} ",
        ),
        const Text("cocktails for you to try!"),
      ]);
    }

    return Column(
      children: [
        //Body Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        Gap($dimensions.insets.md),
         Text(
          "Click view all to view more ${widget.drink.strGlass} cocktails!",
        ),
       Gap($dimensions.insets.md),
        //Main Button
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: Opacity(
            opacity: 1,
            child: AppBtn(
              //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
              onPressed: () {
                context.push(ScreenPaths.cocktailByGlassScreen(widget.drink.strGlass));
              } ,
              bgColor: AppColors.accent,
      
              semanticLabel: 'view All',
              child: const Text(
                "View all",
              ),
            ),
          ),
        )
      ],
    );
  }

  void _handleTap() {
    widget.onTap(widget.drink);
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }

  Stack _buildLiquidBackground() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
              0,
              GlassCard.nominalHeightOpen * 1.2 -
                  GlassCard.nominalHeightOpen * _fillTween.value * 1.2),
          child: CustomPaint(
            painter:
                LiquidPainter(1, _liquidSim1, _liquidSim2, waveHeight: 100),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    //Create a controller to drive the "fill" animations
    _liquidSimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _liquidSimController.addListener(_rebuildIfOpen);
    //create tween to raise the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _liquidSimController,
          curve: const Interval(.12, .45, curve: Curves.easeOut)),
    );
    //create tween to animate the 'points remaining' text
    _pointsTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _liquidSimController,
          curve: const Interval(.1, .5, curve: Curves.easeOutQuart)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //If our open state has changed...
    if (widget.isOpen != _wasOpen) {
      //Kickoff the fill animations if we're opening up
      if (widget.isOpen) {
        //Start both of the liquid simulations, they will initialize to random values
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);
        //Run the animation controller, kicking off all tweens
        _liquidSimController.forward(from: 0);
      }
      _wasOpen = widget.isOpen;
    }

    //_maxFillLevel * _fillTween.value;
    double cardHeight = widget.isOpen
        ? GlassCard.nominalHeightOpen
        : GlassCard.nominalHeightClosed;

    return GestureDetector(
      onTap: _handleTap,
      //Use an animated container so we can easily animate our widget height
      child: AnimatedContainer(
        curve: !_wasOpen ? const ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: cardHeight,
        //Wrap content in a rounded shadow widget, so it will be rounded on the corners but also have a drop shadow
        child: RoundedShadow.fromRadius(
          12,
          child: Container(
            color: Theme.of(context).cardColor,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background liquid layer
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: _buildLiquidBackground(),
                ),

                //Card Content
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  //Wrap content in a ScrollView, so there's no errors on over scroll.
                  child: SingleChildScrollView(
                    //We don't actually want the scrollview to scroll, disable it.
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        //Top Header Row
                        _buildTopContent(),
                        //Spacer
                        const SizedBox(height: 12),
                        //Bottom Content, use AnimatedOpacity to fade
                        AnimatedOpacity(
                          duration: Duration(
                              milliseconds: widget.isOpen ? 1000 : 500),
                          curve: Curves.easeOut,
                          opacity: widget.isOpen ? 1 : 0,
                          //Bottom Content
                          child: _buildBottomContent(0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
