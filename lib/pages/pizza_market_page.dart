import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/order_details/order_details_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/pizza_market/pizza_market_bloc.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class PizzaMarketPage extends StatelessWidget {
  const PizzaMarketPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return PizzaScaffold(
      appBar: const PizzaAppBar(
        title: 'Pizza Market',
      ),
      body: Builder(
        builder: (context) {
          final stockBlocState = context.watch<PizzaMarketBloc>().state;

          return stockBlocState.maybeWhen(
            success: (pizzaStock) => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + PizzaSizes.appBarHeight),
              itemCount: pizzaStock.length,
              itemBuilder: (context, index) {
                return _PizzaMarketItem(pizza: pizzaStock[index]);
              },
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}

class _PizzaMarketItem extends StatelessWidget {
  const _PizzaMarketItem({
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
              color: PizzaColors.shadowColor,
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
              PizzaFormatters.pizzaPrice(pizza.price),
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
