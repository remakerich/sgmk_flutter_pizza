import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';

class PizzaOrderService {
  static void getPizzaFromStock() {
    for (final order in myOrders) {
      if (order.quantity == 0) {
        continue;
      }
      final pizzaInStock = pizzaStock.firstWhere((pizza) => pizza.name == order.name);
      final index = pizzaStock.indexWhere((pizza) => pizza.name == order.name);

      final remainingPizza = pizzaInStock.copyWith(quantity: pizzaInStock.quantity - order.quantity);
      if (remainingPizza.quantity == 0) {
        pizzaStock.removeAt(index);
      } else {
        pizzaStock.replaceRange(index, index + 1, [remainingPizza]);
      }
    }

    pizzaMarketItems = [
      ...pizzaStock.map(
        (pizza) => pizza.copyWith(quantity: 0),
      ),
    ];

    myOrders.clear();
  }

  static int calculateTotalPrice() {
    return myOrders.map((pizza) => pizza.price * pizza.quantity).toList().reduce((value, element) => value + element);
  }

  static void changeQuantity(int value, String pizzaName) {
    final pizzaInStock = pizzaStock.firstWhere((pizza) => pizza.name == pizzaName);

    final initialPizza = myOrders.firstWhere((pizza) => pizza.name == pizzaName);
    final index = myOrders.indexWhere((pizza) => pizza.name == pizzaName);
    final changedPizza = initialPizza.copyWith(quantity: initialPizza.quantity + value);

    if (changedPizza.quantity < 0 || changedPizza.quantity > pizzaInStock.quantity) {
      return;
    }

    myOrders.replaceRange(index, index + 1, [changedPizza]);
  }
}
