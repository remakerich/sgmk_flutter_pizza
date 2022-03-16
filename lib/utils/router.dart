import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/pages/admin_page.dart';
import 'package:sgmk_flutter_pizza/pages/my_orders_page.dart';
import 'package:sgmk_flutter_pizza/pages/pizza_list_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyOrdersPage.routeName:
        return MaterialPageRoute(builder: (_) => const MyOrdersPage());
      case AdminPage.routeName:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      default:
        return MaterialPageRoute(builder: (_) => const PizzaListPage());
    }
  }
}
