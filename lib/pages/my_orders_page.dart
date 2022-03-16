import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  static const String routeName = '/myOrders';

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
        ],
      ),
    );
  }
}
