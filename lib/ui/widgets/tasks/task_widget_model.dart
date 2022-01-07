import 'package:flutter/material.dart';
import 'package:todolist/domain/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/domain/entity/task.dart';
import 'package:todolist/ui/navigation/main_navigation.dart';

class TaskWidgetModel extends ChangeNotifier {
  late final Future<Box<Group>> _gorupBox;
  int groupKey;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TaskWidgetModel({required this.groupKey}) {
    _setUp();
  }

  void viewForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.taskForm, arguments: groupKey);
  }

  void _loadGruop() async {
    final box = await _gorupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void deleteTasks(int groupIndex) async {
    await _group?.tasks?.deleteFromHive(groupIndex);
    _group?.save();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setUpListenTasks() async {
    final box = await _gorupBox;
    _readTasks();
    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void doneToggle(int groupIndex) async {
    final task=group?.tasks?[groupIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setUp() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _gorupBox = Hive.openBox<Group>('groups_box');
    
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _loadGruop();
    _setUpListenTasks();
  }
}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;
  const TaskWidgetModelProvider({
    required this.model,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static TaskWidgetModelProvider? whatch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
  }

  static TaskWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskWidgetModelProvider>()
        ?.widget;
    return widget is TaskWidgetModelProvider ? widget : null;
  }
}
