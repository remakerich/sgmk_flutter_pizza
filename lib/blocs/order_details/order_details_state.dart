part of 'order_details_bloc.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.initial() = OrderDetailsInitial;

  const factory OrderDetailsState.success({
    required List<Pizza> myOrders,
  }) = OrderDetailsSuccess;
}
