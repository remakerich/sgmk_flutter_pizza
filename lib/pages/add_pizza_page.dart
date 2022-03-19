import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgmk_flutter_pizza/blocs/add_pizza/add_pizza_bloc.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';

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
          onTap: () => context.read<AddPizzaBloc>().add(const AddPizzaItemCreated()),
        ),
      ),
      body: Builder(builder: (context) {
        final addPizzaBlocState = context.watch<AddPizzaBloc>().state;

        return Column(
          children: [
            Expanded(
              child: addPizzaBlocState.maybeWhen(
                success: (addedItems) => ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + PizzaSizes.appBarHeight,
                  ),
                  itemCount: addedItems.length,
                  itemBuilder: (context, index) {
                    return _AddedItem(pizza: addedItems[index]);
                  },
                ),
                orElse: () => const SizedBox(),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<AddPizzaBloc>().add(const AddPizzaSaved());
                Navigator.of(context).pop();
              },
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
        );
      }),
    );
  }
}

class _AddedItem extends StatefulWidget {
  const _AddedItem({
    Key? key,
    required this.pizza,
  }) : super(key: key);

  final Pizza pizza;

  @override
  State<_AddedItem> createState() => _AddedItemState();
}

class _AddedItemState extends State<_AddedItem> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.pizza.name;
    _priceController.text = widget.pizza.price.toString();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      padding: const EdgeInsets.fromLTRB(12, 40, 32, 40),
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
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(
              height: 75,
              child: Image.asset(
                widget.pizza.assetPicture,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _TextInput(
                    controller: _nameController,
                    inputType: TextInputType.name,
                    onChanged: (name) {
                      if (name.isEmpty) {
                        return;
                      }
                      final event = AddPizzaEdited(
                        name: name,
                        price: _priceController.text,
                        pizza: widget.pizza,
                      );
                      context.read<AddPizzaBloc>().add(event);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _TextInput(
                    controller: _priceController,
                    inputType: TextInputType.number,
                    onChanged: (price) {
                      if (price.isEmpty) {
                        return;
                      }
                      final event = AddPizzaEdited(
                        name: _nameController.text,
                        price: price,
                        pizza: widget.pizza,
                      );
                      context.read<AddPizzaBloc>().add(event);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            RemoveButton(
              onTap: () => context.read<AddPizzaBloc>().add(AddPizzaSubtracted(widget.pizza)),
            ),
            const SizedBox(width: 12),
            Text(
              widget.pizza.quantity.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            AddButton(
              onTap: () => context.read<AddPizzaBloc>().add(AddPizzaAdded(widget.pizza)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              keyboardType: inputType,
              cursorColor: Colors.black,
              cursorWidth: 1,
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              obscureText: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
                isCollapsed: true,
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => controller.clear(),
            child: SvgPicture.asset(
              PizzaAssets.clearIcon,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
