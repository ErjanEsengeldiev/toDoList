import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/main_model.dart';
import 'package:todolist/ui/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel model = MainModel();
  @override
  Widget build(BuildContext context) {
    return MainProvider(
      model: model,
      child: const MaterialForApp(),
    );
  }
}

class MaterialForApp extends StatelessWidget {
  const MaterialForApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: context
            .dependOnInheritedWidgetOfExactType<MainProvider>()!
            .model
            .themeOfApp,
        onGenerateRoute: MyApp.mainNavigation.onGenerateRoute,
        initialRoute: MyApp.mainNavigation.initialRoute,
        routes: MyApp.mainNavigation.routes);
  }
}
