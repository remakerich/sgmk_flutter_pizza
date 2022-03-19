import 'package:flutter/material.dart';

class PizzaAssets {
  static const backgroundPicture = 'assets/background_picture.png';
  static const ordersIcon = 'assets/orders_icon.png';
  static const adminIcon = 'assets/admin_icon.png';
  static const buffaloPizzaPicture = 'assets/buffalo_pizza.png';
  static const mexicanPizzaPicture = 'assets/mexican_pizza.png';
  static const originalPizzaPicture = 'assets/original_pizza.png';
  static const pepperoniPizzaPicture = 'assets/pepperoni_pizza.png';
  static const sanMarzanoPizzaPicture = 'assets/san_marzano_pizza.png';
  static const minusIcon = 'assets/minus_icon.png';
  static const plusIcon = 'assets/plus_icon.png';
  static const clearIcon = 'assets/cross.svg';
}

class PizzaColors {
  static const backButton = Color.fromRGBO(244, 63, 94, 0.1);
  static const backButtonIcon = Color.fromRGBO(244, 63, 94, 0.7);
  static const primary = Color(0xFFF43F5E);
  static const shadowColor = Color.fromRGBO(90, 108, 234, 0.08);
  static const minusButton = Color.fromRGBO(244, 63, 94, 0.1);
  static const pinkGradient = LinearGradient(
    transform: GradientRotation(1.1),
    colors: [
      Color(0xFFFF7E95),
      Color(0xFFFF1843),
    ],
  );
}

class PizzaSizes {
  static const appBarHeight = 100.0;
}

class PizzaFormatters {
  static String pizzaPrice(int price) {
    return '\$${price.toString()}';
  }
}
