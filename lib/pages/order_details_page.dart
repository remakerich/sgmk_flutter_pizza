import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/order_details/order_details_bloc.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return PizzaScaffold(
      appBar: const PizzaAppBar(
        title: 'Order Details',
      ),
      body: Builder(
        builder: (context) {
          final orderDetailsBlocState = context.watch<OrderDetailsBloc>().state;

          return Column(
            children: [
              Expanded(
                child: orderDetailsBlocState.maybeMap(
                  success: (state) => ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + PizzaSizes.appBarHeight),
                    itemCount: state.myOrders.length,
                    itemBuilder: (context, index) {
                      return _OrderDetailsItem(pizza: state.myOrders[index]);
                    },
                  ),
                  orElse: () => const SizedBox(),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                padding: const EdgeInsets.all(24),
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: PizzaColors.pinkGradient,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            orderDetailsBlocState.maybeMap(
                              success: (state) => PizzaFormatters.pizzaPrice(state.totalPrice),
                              orElse: () => PizzaFormatters.pizzaPrice(0),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        const event = OrderDetailsOrderPlaced();
                        context.read<OrderDetailsBloc>().add(event);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                        ),
                        child: const Text(
                          'Place my order',
                          style: TextStyle(
                            color: PizzaColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _OrderDetailsItem extends StatelessWidget {
  const _OrderDetailsItem({Key? key, required this.pizza}) : super(key: key);

  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      padding: const EdgeInsets.fromLTRB(12, 12, 32, 12),
      height: 99,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizza.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  PizzaFormatters.pizzaPrice(pizza.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: PizzaColors.primary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.read<OrderDetailsBloc>().add(OrderDetailsSubtracted(pizza: pizza)),
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
          ),
          const SizedBox(width: 12),
          Text(
            pizza.quantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => context.read<OrderDetailsBloc>().add(OrderDetailsAdded(pizza: pizza)),
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
          ),
        ],
      ),
    );
  }
}
