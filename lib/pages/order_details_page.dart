import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/order_details/order_details_bloc.dart';
import 'package:sgmk_flutter_pizza/injection/injection.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_market_item.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<OrderDetailsBloc>()..add(const OrderDetailsStarted()),
        ),
      ],
      child: PizzaScaffold(
        appBar: const PizzaAppBar(
          title: 'Order Details',
        ),
        body: Builder(
          builder: (context) {
            final orderDetailsBlocState = context.watch<OrderDetailsBloc>().state;

            return orderDetailsBlocState.maybeWhen(
              success: (myOrders) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: myOrders.length,
                itemBuilder: (context, index) {
                  return PizzaMarketItem(pizza: myOrders[index]);
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
