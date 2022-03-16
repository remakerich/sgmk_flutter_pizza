import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

List<Pizza> pizzaStock = [
  const Pizza(
    name: 'Original',
    assetPicture: PizzaAssets.originalPizzaPicture,
    quantity: 2,
    price: 8,
  ),
  const Pizza(
    name: 'Buffalo',
    assetPicture: PizzaAssets.buffaloPizzaPicture,
    quantity: 2,
    price: 10,
  ),
  const Pizza(
    name: 'San Marzano',
    assetPicture: PizzaAssets.sanMarzanoPizzaPicture,
    quantity: 2,
    price: 6,
  ),
  const Pizza(
    name: 'Pepperoni',
    assetPicture: PizzaAssets.pepperoniPizzaPicture,
    quantity: 2,
    price: 11,
  ),
  const Pizza(
    name: 'Mexican',
    assetPicture: PizzaAssets.mexicanPizzaPicture,
    quantity: 2,
    price: 13,
  ),
];

List<Pizza> myOrders = [];
