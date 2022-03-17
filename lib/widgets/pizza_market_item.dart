import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/pizza_market/pizza_market_bloc.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

class PizzaMarketItem extends StatelessWidget {
  const PizzaMarketItem({
    Key? key,
    required this.pizza,
  }) : super(key: key);

  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PizzaMarketBloc>().add(
            PizzaMarketPicked(
              pizza: pizza,
            ),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        padding: const EdgeInsets.fromLTRB(12, 12, 32, 12),
        height: 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(90, 108, 234, 0.08),
              blurRadius: 50,
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              pizza.assetPicture,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                pizza.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              '\$${pizza.price.toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 29,
                color: PizzaColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
