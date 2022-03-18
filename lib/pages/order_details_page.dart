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

          return Stack(
            children: [
              orderDetailsBlocState.maybeMap(
                success: (state) => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: state.myOrders.length,
                  itemBuilder: (context, index) {
                    return _OrderDetailsItem(pizza: state.myOrders[index]);
                  },
                ),
                orElse: () => const SizedBox(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    const event = OrderDetailsOrderPlaced();
                    context.read<OrderDetailsBloc>().add(event);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: Text(
                      orderDetailsBlocState.maybeMap(
                        success: (state) => '\$${state.totalPrice}',
                        orElse: () => '\$0',
                      ),
                    ),
                  ),
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
                gradient: const LinearGradient(
                  transform: GradientRotation(1.1),
                  colors: [
                    Color(0xFFFF7E95),
                    Color(0xFFFF1843),
                  ],
                ),
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
