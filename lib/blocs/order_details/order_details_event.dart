part of 'order_details_bloc.dart';

@freezed
class OrderDetailsEvent with _$OrderDetailsEvent {
  const factory OrderDetailsEvent.started() = OrderDetailsStarted;

  const factory OrderDetailsEvent.subtracted(Pizza pizza) = OrderDetailsSubtracted;

  const factory OrderDetailsEvent.added(Pizza pizza) = OrderDetailsAdded;

  const factory OrderDetailsEvent.orderPlaced() = OrderDetailsOrderPlaced;
}
