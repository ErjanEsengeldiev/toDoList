import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/ui/widgets/tasks/task_widget_model.dart';

class TasksWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final groupKey;
  const TasksWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TaskWidgetModel _model;
  @override
  void initState() {
    super.initState();
    _model = TaskWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;

    return TaskWidgetModelProvider(
      child: const TasksWidgetBody(),
      model: model,
    );
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.whatch(context)?.model;
    final title = model?.group?.name ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const _TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model!.viewForm(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TaskWidgetModelProvider.whatch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
        itemBuilder: (context, index) {
          return _TaskListRowWidget(
            index: index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 1,
          );
        },
        itemCount: groupsCount);
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int index;
  const _TaskListRowWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.read(context)?.model;
    final task = TaskWidgetModelProvider.read(context)?.model.tasks[index];
    final icon = task!.isDone
        ? const Icon(Icons.done, color: Colors.green)
        : const Icon(Icons.stop_circle, color: Colors.blue);

    final style = task.isDone
        ? const TextStyle(decoration: TextDecoration.lineThrough)
        : null;
    return Card(
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                model!.deleteTasks(index);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Удалить',
            ),
          ],
        ),
        child: ListTile(
          leading: icon,
          title: Text(
            task.text,
            style: style,
          ),
          onTap: () => model?.doneToggle(index),
        ),
      ),
    );
  }
}
