import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';
import 'package:sgmk_flutter_pizza/services/add_pizza_service.dart';
import 'package:sgmk_flutter_pizza/utils/pizza_stock.dart';

part 'add_pizza_event.dart';
part 'add_pizza_state.dart';
part 'add_pizza_bloc.freezed.dart';

@injectable
class AddPizzaBloc extends Bloc<AddPizzaEvent, AddPizzaState> {
  AddPizzaBloc() : super(const AddPizzaInitial()) {
    on<AddPizzaStarted>(_started);
    on<AddPizzaItemCreated>(_handleCreated);
    on<AddPizzaSubtracted>(_handleSubtracted);
    on<AddPizzaAdded>(_handleAdded);
    on<AddPizzaEdited>(_handleEdited);
    on<AddPizzaSaved>(_handleSaved);
  }

  Future<void> _started(
    AddPizzaStarted event,
    Emitter<AddPizzaState> emit,
  ) async {
    emit(const AddPizzaInitial());

    emit(AddPizzaSuccess(stock));
  }

  Future<void> _handleSaved(
    AddPizzaSaved event,
    Emitter<AddPizzaState> emit,
  ) async {
    emit(const AddPizzaInitial());

    AddPizzaService.save();

    emit(const AddPizzaSuccess([]));
  }

  Future<void> _handleEdited(
    AddPizzaEdited event,
    Emitter<AddPizzaState> emit,
  ) async {
    AddPizzaService.editPizza(
      event.price,
      event.name,
      event.pizza.id,
    );
  }

  Future<void> _handleAdded(
    AddPizzaAdded event,
    Emitter<AddPizzaState> emit,
  ) async {
    emit(const AddPizzaInitial());

    AddPizzaService.changeQuantity(1, event.pizza.id);

    emit(AddPizzaSuccess(stock));
  }

  Future<void> _handleSubtracted(
    AddPizzaSubtracted event,
    Emitter<AddPizzaState> emit,
  ) async {
    emit(const AddPizzaInitial());

    AddPizzaService.changeQuantity(-1, event.pizza.id);

    emit(AddPizzaSuccess(stock));
  }

  Future<void> _handleCreated(
    AddPizzaItemCreated event,
    Emitter<AddPizzaState> emit,
  ) async {
    emit(const AddPizzaInitial());

    AddPizzaService.createPizza();

    emit(AddPizzaSuccess(stock));
  }
}
