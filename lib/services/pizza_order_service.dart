import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';

class PizzaOrderService {
  static void getPizzaFromStock() {
    for (final order in myOrders) {
      if (order.quantity == 0) {
        continue;
      }
      final pizzaInStock = stock.firstWhere((pizza) => pizza.id == order.id);
      final index = stock.indexWhere((pizza) => pizza.id == order.id);

      final remainingPizza = pizzaInStock.copyWith(quantity: pizzaInStock.quantity - order.quantity);
      if (remainingPizza.quantity == 0) {
        stock.removeAt(index);
      } else {
        stock.replaceRange(index, index + 1, [remainingPizza]);
      }
    }

    marketItems = [
      ...stock.map(
        (pizza) => pizza.copyWith(quantity: 0),
      ),
    ];

    myOrders = [];
  }

  static int calculateTotalPrice() {
    return myOrders.map((pizza) => pizza.price * pizza.quantity).toList().reduce((value, element) => value + element);
  }

  static void changeQuantity(int value, String id) {
    final pizzaInStock = stock.firstWhere((pizza) => pizza.id == id);

    final initialPizza = myOrders.firstWhere((pizza) => pizza.id == id);
    final index = myOrders.indexWhere((pizza) => pizza.id == id);
    final changedPizza = initialPizza.copyWith(quantity: initialPizza.quantity + value);

    if (changedPizza.quantity < 0 || changedPizza.quantity > pizzaInStock.quantity) {
      return;
    }

    myOrders.replaceRange(index, index + 1, [changedPizza]);
  }
}
