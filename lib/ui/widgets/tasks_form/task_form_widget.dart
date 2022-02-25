import 'package:flutter/material.dart';
import 'package:todolist/main_model.dart';
import 'package:todolist/ui/widgets/tasks_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final groupKey;
  const TaskFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  _TaskFormWidgetState createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvadier(
      model: _model,
      child: const _BodyTaskFormWidget(),
    );
  }
}

class _BodyTaskFormWidget extends StatefulWidget {
  const _BodyTaskFormWidget({Key? key}) : super(key: key);

  @override
  State<_BodyTaskFormWidget> createState() => _BodyTaskFormWidgetState();
}

class _BodyTaskFormWidgetState extends State<_BodyTaskFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  context
                      .dependOnInheritedWidgetOfExactType<MainProvider>()!
                      .model
                      .changeThemeOfApp();
                });
              },
              icon: Icon(
                context
                            .dependOnInheritedWidgetOfExactType<MainProvider>()!
                            .model
                            .themeOfApp ==
                        ThemeData.light()
                    ? Icons.nights_stay_outlined
                    : Icons.light,
                color: context
                            .dependOnInheritedWidgetOfExactType<MainProvider>()!
                            .model
                            .themeOfApp ==
                        ThemeData.light()
                    ? Colors.black
                    : Colors.white,
              )),
        ],
        title: const Text('Группы'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CreateNewTaskText(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TaskFormWidgetModelProvadier.read(context)
            ?.model
            .savezTask(context),
        child: const Icon(Icons.done_sharp),
      ),
    );
  }
}

class CreateNewTaskText extends StatelessWidget {
  const CreateNewTaskText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = TaskFormWidgetModelProvadier.read(context)?.model;
    return TextField(
      onChanged: (value) => _model?.tasksText = value,
      onEditingComplete: () => _model?.savezTask(context),
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        hintText: 'Текст задач',
        border: InputBorder.none,
      ),
    );
  }
}
