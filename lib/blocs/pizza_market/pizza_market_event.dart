part of 'pizza_market_bloc.dart';

@freezed
class PizzaMarketEvent with _$PizzaMarketEvent {
  const factory PizzaMarketEvent.started() = PizzaMarketStarted;

  const factory PizzaMarketEvent.picked({
    required Pizza pizza,
  }) = PizzaMarketPicked;
}
