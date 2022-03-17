import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/pizza_market/pizza_market_bloc.dart';
import 'package:sgmk_flutter_pizza/injection/injection.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_market_item.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class PizzaMarketPage extends StatelessWidget {
  const PizzaMarketPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PizzaMarketBloc>()..add(const PizzaMarketStarted()),
        ),
      ],
      child: PizzaScaffold(
        appBar: const PizzaAppBar(
          title: 'Pizza Market',
        ),
        body: Builder(
          builder: (context) {
            final stockBlocState = context.watch<PizzaMarketBloc>().state;

            return stockBlocState.maybeWhen(
              success: (pizzaStock) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: pizzaStock.length,
                itemBuilder: (context, index) {
                  return PizzaMarketItem(pizza: pizzaStock[index]);
                },
              ),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
