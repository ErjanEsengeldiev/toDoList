import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  ThemeData themeOfApp = ThemeData.light();
  void changeThemeOfApp() {
    themeOfApp == ThemeData.dark()
        ? themeOfApp = ThemeData.light()
        : themeOfApp = ThemeData.dark();

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
