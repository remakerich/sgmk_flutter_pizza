import 'package:flutter/material.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
