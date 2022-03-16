import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  static const String routeName = '/admin';

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
