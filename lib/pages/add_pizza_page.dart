import 'package:flutter/material.dart';
import 'package:sgmk_flutter_pizza/utils/ui.dart';
import 'package:sgmk_flutter_pizza/widgets/add_remove_buttons.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_app_bar.dart';
import 'package:sgmk_flutter_pizza/widgets/pizza_scaffold.dart';

class AddPizzaPage extends StatelessWidget {
  const AddPizzaPage({Key? key}) : super(key: key);

  static const String routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return PizzaScaffold(
      appBar: PizzaAppBar(
        title: 'Add Pizza',
        actionButtons: AddButton(
          onTap: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              height: 75,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: PizzaColors.pinkGradient,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
