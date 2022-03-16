import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class PizzaListPage extends StatelessWidget {
  const PizzaListPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const PizzaScaffold(
      appBar: PizzaAppBar(
        title: 'Pizza Market',
      ),
      body: SizedBox(),
    );
  }
}
