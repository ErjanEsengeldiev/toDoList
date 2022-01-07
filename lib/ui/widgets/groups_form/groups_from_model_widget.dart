import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/domain/entity/group.dart';

class GroupFormWidgetModel {
  var groupName = '';
  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    final group = Group(name: groupName);
    await box.add(group);
    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvadier extends InheritedWidget {
  final GroupFormWidgetModel model;
  // ignore: use_key_in_widget_constructors
  const GroupFormWidgetModelProvadier(
      {required Widget child, required this.model})
      : super(child: child);

  static GroupFormWidgetModelProvadier? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvadier>();
  }

  static GroupFormWidgetModelProvadier? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            GroupFormWidgetModelProvadier>()
        ?.widget;
    return widget is GroupFormWidgetModelProvadier ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
