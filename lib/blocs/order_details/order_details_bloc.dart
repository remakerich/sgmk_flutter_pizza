import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';
part 'order_details_bloc.freezed.dart';

@injectable
class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(const OrderDetailsInitial()) {
    on<OrderDetailsStarted>(_started);
    on<OrderDetailsSubtracted>(_handleSubtracted);
    on<OrderDetailsAdded>(_handleAdded);
    on<OrderDetailsOrderPlaced>(_handleOrderPlaced);
  }

  Future<void> _started(
    OrderDetailsStarted event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(OrderDetailsSuccess(
      myOrders: myOrders,
      totalPrice: 0,
    ));
  }

  Future<void> _handleSubtracted(
    OrderDetailsSubtracted event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(const OrderDetailsInitial());

    _changeQantity(-1, event.pizza.name);
    final totalPrice = _calculateTotalPrice();

    emit(OrderDetailsSuccess(
      myOrders: myOrders,
      totalPrice: totalPrice,
    ));
  }

  Future<void> _handleAdded(
    OrderDetailsAdded event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(const OrderDetailsInitial());

    _changeQantity(1, event.pizza.name);
    final totalPrice = _calculateTotalPrice();

    emit(OrderDetailsSuccess(
      myOrders: myOrders,
      totalPrice: totalPrice,
    ));
  }

  Future<void> _handleOrderPlaced(
    OrderDetailsOrderPlaced event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(const OrderDetailsInitial());

    _getPizzaFromStock();

    emit(const OrderDetailsSuccess(
      myOrders: [],
      totalPrice: 0,
    ));
  }

  void _getPizzaFromStock() {
    for (final order in myOrders) {
      if (order.quantity == 0) {
        continue;
      }
      final pizzaInStock = pizzaStock.firstWhere((pizza) => pizza.name == order.name);
      final index = pizzaStock.indexWhere((pizza) => pizza.name == order.name);

      final remainingPizza = pizzaInStock.copyWith(quantity: pizzaInStock.quantity - order.quantity);
      if (remainingPizza.quantity == 0) {
        pizzaStock.removeAt(index);
      } else {
        pizzaStock.replaceRange(index, index + 1, [remainingPizza]);
      }
    }

    pizzaMarketItems = [
      ...pizzaStock.map(
        (pizza) => pizza.copyWith(quantity: 0),
      ),
    ];

    myOrders.clear();
  }

  int _calculateTotalPrice() {
    return myOrders.map((pizza) => pizza.price * pizza.quantity).toList().reduce((value, element) => value + element);
  }

  void _changeQantity(int value, String pizzaName) {
    final pizzaInStock = pizzaStock.firstWhere((pizza) => pizza.name == pizzaName);

    final initialPizza = myOrders.firstWhere((pizza) => pizza.name == pizzaName);
    final index = myOrders.indexWhere((pizza) => pizza.name == pizzaName);
    final changedPizza = initialPizza.copyWith(quantity: initialPizza.quantity + value);

    if (changedPizza.quantity < 0 || changedPizza.quantity > pizzaInStock.quantity) {
      return;
    }

    myOrders.replaceRange(index, index + 1, [changedPizza]);
  }
}
