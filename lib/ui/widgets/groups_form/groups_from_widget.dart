import 'package:flutter/material.dart';
import 'package:todolist/main_model.dart';
import 'groups_from_model_widget.dart';

class GroupsFormWidget extends StatefulWidget {
  const GroupsFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupsFormWidget> createState() => _GroupsFormWidgetState();
}

class _GroupsFormWidgetState extends State<GroupsFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvadier(
      child: const BodyGroupsFormWidget(),
      model: _model,
    );
  }
}

class BodyGroupsFormWidget extends StatefulWidget {
  const BodyGroupsFormWidget({Key? key}) : super(key: key);

  @override
  State<BodyGroupsFormWidget> createState() => _BodyGroupsFormWidgetState();
}

class _BodyGroupsFormWidgetState extends State<BodyGroupsFormWidget> {
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
          child: CreateNewGroupName(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupFormWidgetModelProvadier.read(context)
            ?.model
            .saveGroup(context),
        child: const Icon(Icons.done_sharp),
      ),
    );
  }
}

class CreateNewGroupName extends StatelessWidget {
  const CreateNewGroupName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = GroupFormWidgetModelProvadier.read(context)?.model;
    return TextField(
      onChanged: (value) => _model?.groupName = value,
      onEditingComplete: () => _model?.saveGroup(context),
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Group name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
