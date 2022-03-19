import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: PizzaColors.pinkGradient,
        ),
        child: Image.asset(
          PizzaAssets.plusIcon,
          width: 16,
        ),
      ),
    );
  }
}

class RemoveButton extends StatelessWidget {
  const RemoveButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: PizzaColors.minusButton,
        ),
        child: Image.asset(
          PizzaAssets.minusIcon,
          width: 16,
        ),
      ),
    );
  }
}
