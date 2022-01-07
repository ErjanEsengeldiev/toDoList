import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/domain/entity/group.dart';
import 'package:todolist/domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var tasksText = '';

  TaskFormWidgetModel({required this.groupKey});

  void savezTask(BuildContext context) async {
    if (tasksText.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(isDone: false, text: tasksText);
    taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvadier extends InheritedWidget {
  final TaskFormWidgetModel model;
  // ignore: use_key_in_widget_constructors
  const TaskFormWidgetModelProvadier(
      {required Widget child, required this.model})
      : super(
          child: child,
        );

  static TaskFormWidgetModelProvadier? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvadier>();
  }

  static TaskFormWidgetModelProvadier? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvadier>()
        ?.widget;
    return widget is TaskFormWidgetModelProvadier ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
