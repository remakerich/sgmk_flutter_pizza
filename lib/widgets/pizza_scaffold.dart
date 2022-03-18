import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class PizzaScaffold extends StatelessWidget {
  const PizzaScaffold({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);

  final Widget body;
  final Widget appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            child: Image.asset(
              PizzaAssets.backgroundPicture,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white,
                ],
              ),
            ),
          ),
          body,
          appBar,

          // Padding(
          //   padding: EdgeInsets.only(
          //     top: MediaQuery.of(context).padding.top + PizzaSizes.appBarHeight,
          //   ),
          //   child: ,
          // ),
        ],
      ),
    );
  }
}
