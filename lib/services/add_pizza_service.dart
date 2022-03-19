import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;

class AddPizzaService {
  static void changeQuantity(int value, String id) {
    final initialPizza = addedItems.firstWhere((pizza) => pizza.id == id);
    final index = addedItems.indexWhere((pizza) => pizza.id == id);
    final changedPizza = initialPizza.copyWith(quantity: initialPizza.quantity + value);

    if (changedPizza.quantity < 0) {
      return;
    }

    addedItems.replaceRange(index, index + 1, [changedPizza]);
  }

  static void editPizza(String price, String name, String id) {
    int priceConverted = 0;
    try {
      priceConverted = int.parse(price);
    } catch (e) {
      return;
    }

    final initialPizza = addedItems.firstWhere((pizza) => pizza.id == id);
    final index = addedItems.indexWhere((pizza) => pizza.id == id);

    final changedPizza = initialPizza.copyWith(
      price: priceConverted,
      name: name,
    );

    addedItems.replaceRange(index, index + 1, [changedPizza]);
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

    addedItems.add(newPizza);
  }

  static void save() {
    for (final item in addedItems) {
      if (item.name.isEmpty) {
        addedItems.removeWhere((element) => element.id == item.id);
        continue;
      }
      if (item.price == 0) {
        addedItems.removeWhere((element) => element.id == item.id);
        continue;
      }

      stock.addAll([...addedItems]);

      marketItems = [
        ...stock.map(
          (pizza) => pizza.copyWith(quantity: 0),
        ),
      ];

      addedItems = [];
    }
  }
}
