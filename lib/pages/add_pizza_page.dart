import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class AddPizzaPage extends StatelessWidget {
  const AddPizzaPage({Key? key}) : super(key: key);

  static const String routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return const PizzaScaffold(
      appBar: PizzaAppBar(
        title: 'Add Pizza',
      ),
      body: SizedBox(),
    );
  }
}
