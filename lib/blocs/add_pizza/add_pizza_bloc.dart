import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sgmk_flutter_pizza/models/pizza.dart';

part 'add_pizza_event.dart';
part 'add_pizza_state.dart';
part 'add_pizza_bloc.freezed.dart';

@injectable
class AddPizzaBloc extends Bloc<AddPizzaEvent, AddPizzaState> {
  AddPizzaBloc() : super(const AddPizzaInitial()) {
    on<AddPizzaStarted>(_started);
  }

  Future<void> _started(
    AddPizzaStarted event,
    Emitter<AddPizzaState> emit,
  ) async {}
}
