import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;

class AddPizzaService {
  static void changeQuantity(int value, String id) {
    final initialPizza = stock.firstWhere((pizza) => pizza.id == id);
    final index = stock.indexWhere((pizza) => pizza.id == id);
    final changedPizza = initialPizza.copyWith(quantity: initialPizza.quantity + value);

    if (changedPizza.quantity < 0) {
      return;
    }

    stock.replaceRange(index, index + 1, [changedPizza]);
  }

  static void editPizza(String price, String name, String id) {
    int priceConverted = 0;
    try {
      priceConverted = int.parse(price);
    } catch (e) {
      return;
    }

    final initialPizza = stock.firstWhere((pizza) => pizza.id == id);
    final index = stock.indexWhere((pizza) => pizza.id == id);

    final changedPizza = initialPizza.copyWith(
      price: priceConverted,
      name: name,
    );

    stock.replaceRange(index, index + 1, [changedPizza]);
  }

  static void createPizza() {
    final pizzaPictures = [
      PizzaAssets.pepperoniPizzaPicture,
      PizzaAssets.mexicanPizzaPicture,
      PizzaAssets.buffaloPizzaPicture,
      PizzaAssets.originalPizzaPicture,
      PizzaAssets.sanMarzanoPizzaPicture,
    ];

    final newPizza = Pizza(
      id: const Uuid().v4(),
      name: '',
      assetPicture: pizzaPictures[math.Random().nextInt(pizzaPictures.length)],
      quantity: 0,
      price: 0,
    );

    stock.add(newPizza);
  }

  static void save() {
    marketItems = [];
    myOrders = [];

    marketItems = [
      ...stock
          .where((pizza) => pizza.name.isNotEmpty)
          .where((pizza) => pizza.price != 0)
          .where((pizza) => pizza.quantity != 0)
          .map((pizza) => pizza.copyWith(quantity: 0))
          .toList(),
    ];
  }
}
