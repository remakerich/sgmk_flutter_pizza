import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/pages/admin_page.dart';
import 'package:sgmk_flutter_pizza/pages/my_orders_page.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';

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
          height: 100,
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
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(MyOrdersPage.routeName),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(
                      PizzaAssets.ordersIcon,
                      height: 24,
                    ),
                  ),
                ),
              const SizedBox(width: 50),
              if (firstInStack)
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AdminPage.routeName),
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
