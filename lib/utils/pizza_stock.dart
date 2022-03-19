import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:uuid/uuid.dart';

List<Pizza> stock = [
  Pizza(
    id: const Uuid().v4(),
    name: 'Original',
    assetPicture: PizzaAssets.originalPizzaPicture,
    quantity: 2,
    price: 8,
  ),
];

List<Pizza> marketItems = [
  ...stock.map(
    (pizza) => pizza.copyWith(quantity: 0),
  ),
];

List<Pizza> myOrders = [];

List<Pizza> addedItems = [];
