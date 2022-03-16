import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/pages/admin_page.dart';
import 'package:sgmk_flutter_pizza/pages/my_orders_page.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class PizzaListPage extends StatelessWidget {
  const PizzaListPage({Key? key}) : super(key: key);

  static const String routeName = '/';

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
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MyOrdersPage.routeName);
                },
                child: Text('My orders'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AdminPage.routeName);
                },
                child: Text('Admin'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
