part of 'pizza_market_bloc.dart';

@freezed
class PizzaMarketState with _$PizzaMarketState {
  const factory PizzaMarketState.initial() = PizzaMarketInitial;

  const factory PizzaMarketState.success(List<Pizza> items) = PizzaMarketSuccess;
}
