import 'package:flutter/material.dart';
import 'package:todolist/ui/widgets/groups.dart/groups_widget.dart';
import 'package:todolist/ui/widgets/groups_form/groups_from_widget.dart';
import 'package:todolist/ui/widgets/tasks/task_widget.dart';
import 'package:todolist/ui/widgets/tasks_form/task_form_widget.dart';

abstract class MainNavigationRouteName {
  static const group = '/';
  static const groupForim = '/groupForim';
  static const task = '/tasks';
  static const taskForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.group;
  final routes = {
    MainNavigationRouteName.group: (context) => const Groups(),
    MainNavigationRouteName.groupForim: (context) => const GroupsFormWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.task:
        final groupKey = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => TasksWidget(groupKey: groupKey));
      case MainNavigationRouteName.taskForm:
        final groupKey = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => TaskFormWidget(groupKey: groupKey));
      default:
        const widget = Text('eror');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
