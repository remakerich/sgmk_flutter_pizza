part of 'add_pizza_bloc.dart';

@freezed
class AddPizzaEvent with _$AddPizzaEvent {
  const factory AddPizzaEvent.started() = AddPizzaStarted;

  const factory AddPizzaEvent.itemCreated() = AddPizzaItemCreated;

  const factory AddPizzaEvent.subtracted(Pizza pizza) = AddPizzaSubtracted;

  const factory AddPizzaEvent.added(Pizza pizza) = AddPizzaAdded;

  const factory AddPizzaEvent.stockUpdated() = AddPizzaItemStockUpdated;
}
