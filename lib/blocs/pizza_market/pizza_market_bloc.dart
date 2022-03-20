import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';

part 'pizza_market_event.dart';
part 'pizza_market_state.dart';
part 'pizza_market_bloc.freezed.dart';

@injectable
class PizzaMarketBloc extends Bloc<PizzaMarketEvent, PizzaMarketState> {
  PizzaMarketBloc() : super(const PizzaMarketInitial()) {
    on<PizzaMarketStarted>(_started);
    on<PizzaMarketPicked>(_handlePicked);
  }

  Future<void> _started(
    PizzaMarketStarted event,
    Emitter<PizzaMarketState> emit,
  ) async {
    emit(const PizzaMarketInitial());

    

    emit(PizzaMarketSuccess(marketItems));
  }

  Future<void> _handlePicked(
    PizzaMarketPicked event,
    Emitter<PizzaMarketState> emit,
  ) async {
    emit(const PizzaMarketInitial());
    marketItems.removeWhere((pizza) => pizza.id == event.pizza.id);
    myOrders.add(event.pizza);

    emit(PizzaMarketSuccess(marketItems));
  }
}
