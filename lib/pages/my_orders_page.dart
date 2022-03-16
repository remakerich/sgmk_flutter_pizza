import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  static const String routeName = '/myOrders';

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
