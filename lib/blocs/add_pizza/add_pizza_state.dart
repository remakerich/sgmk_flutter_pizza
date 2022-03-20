part of 'add_pizza_bloc.dart';

@freezed
class AddPizzaState with _$AddPizzaState {
  const factory AddPizzaState.initial() = AddPizzaInitial;

  const factory AddPizzaState.success(List<Pizza> stock) = AddPizzaSuccess;
}
