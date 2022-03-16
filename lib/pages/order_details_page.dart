import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return const PizzaScaffold(
      appBar: PizzaAppBar(
        title: 'Order Details',
      ),
      body: SizedBox(),
    );
  }
}
