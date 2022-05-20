import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final _box = Hive.box('theme');

ThemeData getThemeFromHive() {
  print('initial Value in theme ${_box.get('theme')}');

  if (_box.isEmpty) {
    _box.put('theme', 'dark');
    return ThemeData.dark();
  }

  switch (_box.get('theme')) {
    case 'dark':
      return ThemeData.dark();
    case 'ligth':
      return ThemeData.light();
    default:
      return ThemeData();
  }
}

class MainModel extends ChangeNotifier {
  ThemeData themeOfApp = getThemeFromHive();

  void changeThemeOfApp() {
    _box.get('theme') == 'dark'
        ? _box.put('theme', 'light')
        : _box.put('theme', 'dark');

    _box.get('theme') == 'dark'
        ? themeOfApp = ThemeData.dark()
        : themeOfApp = ThemeData.light();

    notifyListeners();
  }
}

class MainProvider extends InheritedNotifier {
  final MainModel model;

  const MainProvider({Key? key, required Widget child, required this.model})
      : super(key: key, child: child, notifier: model);

  static MainProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainProvider>();
  }

  static MainProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<MainProvider>()?.widget;
    return widget is MainProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
