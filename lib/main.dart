import 'package:flutter/material.dart';
import 'package:workout1/app_router.dart';
import 'crud/init_crud.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitCrud.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return MaterialApp(
      title: 'Workout',
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
