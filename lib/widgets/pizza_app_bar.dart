import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/blocs/order_details/order_details_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/pizza_market/pizza_market_bloc.dart';
import 'package:sgmk_flutter_pizza/pages/add_pizza_page.dart';
import 'package:sgmk_flutter_pizza/pages/order_details_page.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PizzaAppBar extends StatelessWidget {
  const PizzaAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final firstInStack = ModalRoute.of(context)!.isFirst;

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: PizzaSizes.appBarHeight,
          child: Row(
            children: [
              if (!firstInStack)
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: PizzaColors.backButton,
                    ),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: PizzaColors.backButtonIcon,
                      size: 30,
                    ),
                  ),
                ),
              if (!firstInStack) const SizedBox(width: 24),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                ),
              ),
              if (firstInStack)
                Builder(builder: (context) {
                  context.watch<PizzaMarketBloc>();
                  final pizzaMarketBlocState = context.watch<OrderDetailsBloc>().state;

                  final badgeCount = pizzaMarketBlocState.maybeMap(
                    success: (state) => state.myOrders.length,
                    orElse: () => 0,
                  );

                  return Badge(
                    showBadge: badgeCount != 0,
                    shape: badgeCount < 10 ? BadgeShape.circle : BadgeShape.square,
                    borderRadius: BorderRadius.circular(18),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    position: BadgePosition.topEnd(top: -14),
                    elevation: 0,
                    toAnimate: false,
                    badgeColor: PizzaColors.primary,
                    badgeContent: Text(
                      badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(OrderDetailsPage.routeName),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(
                          PizzaAssets.ordersIcon,
                          height: 24,
                        ),
                      ),
                    ),
                  );
                }),
              const SizedBox(width: 50),
              if (firstInStack)
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AddPizzaPage.routeName),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      PizzaAssets.adminIcon,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
