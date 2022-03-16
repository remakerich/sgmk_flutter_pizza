import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/pages/add_pizza_page.dart';
import 'package:sgmk_flutter_pizza/pages/order_details_page.dart';
import 'package:sgmk_flutter_pizza/pages/pizza_market_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OrderDetailsPage.routeName:
        return MaterialPageRoute(builder: (_) => const OrderDetailsPage());
      case AddPizzaPage.routeName:
        return MaterialPageRoute(builder: (_) => const AddPizzaPage());
      default:
        return MaterialPageRoute(builder: (_) => const PizzaMarketPage());
    }
  }
}
