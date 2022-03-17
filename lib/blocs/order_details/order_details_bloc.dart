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
  }

    Future<void> _started(
    OrderDetailsStarted event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(OrderDetailsSuccess(myOrders: myOrders));
  }
}
