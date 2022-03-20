import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/add_pizza/add_pizza_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/order_details/order_details_bloc.dart';
import 'package:sgmk_flutter_pizza/blocs/pizza_market/pizza_market_bloc.dart';
import 'package:sgmk_flutter_pizza/injection/injection.dart';
import 'package:sgmk_flutter_pizza/utils/router.dart';

void main() async {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PizzaMarketBloc>()..add(const PizzaMarketStarted()),
        ),
        BlocProvider(
          create: (_) => getIt<OrderDetailsBloc>()..add(const OrderDetailsStarted()),
        ),
        BlocProvider(
          create: (_) => getIt<AddPizzaBloc>()..add(const AddPizzaStarted()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OrderDetailsBloc, OrderDetailsState>(
            listenWhen: (_, state) => state is OrderDetailsDone,
            listener: (context, _) {
              const event = PizzaMarketStarted();
              context.read<PizzaMarketBloc>().add(event);
            },
          ),
          BlocListener<PizzaMarketBloc, PizzaMarketState>(
            listenWhen: (_, state) => state is PizzaMarketSuccess,
            listener: (context, __) {
              context.read<OrderDetailsBloc>().add(const OrderDetailsStarted());
            },
          ),
          BlocListener<AddPizzaBloc, AddPizzaState>(
            listenWhen: (_, state) => state is AddPizzaSuccess,
            listener: (context, _) {
              const event = PizzaMarketStarted();
              context.read<PizzaMarketBloc>().add(event);
            },
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
