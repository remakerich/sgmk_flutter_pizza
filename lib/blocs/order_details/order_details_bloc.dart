import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/services/pizza_order_service.dart';
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

    PizzaOrderService.changeQuantity(-1, event.pizza.id);
    final totalPrice = PizzaOrderService.calculateTotalPrice();

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

    PizzaOrderService.changeQuantity(1, event.pizza.id);
    final totalPrice = PizzaOrderService.calculateTotalPrice();

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

    PizzaOrderService.getPizzaFromStock();

    emit(const OrderDetailsSuccess(
      myOrders: [],
      totalPrice: 0,
    ));
  }
}
