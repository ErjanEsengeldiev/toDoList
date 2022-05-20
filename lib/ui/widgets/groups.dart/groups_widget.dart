import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/main_model.dart';
import 'groups_model_widget.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: model,
      child: const GroupWidgetBody(),
    );
  }
}

class GroupWidgetBody extends StatefulWidget {
  const GroupWidgetBody({Key? key}) : super(key: key);

  @override
  State<GroupWidgetBody> createState() => _GroupWidgetBodyState();
}

class _GroupWidgetBodyState extends State<GroupWidgetBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavigationDrawer(),
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
      body: const _GroupsListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupsWidgetModelProvider.read(context)?.model.viewForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupsListWidget extends StatelessWidget {
  const _GroupsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
        itemBuilder: (context, index) {
          return _GroupListRowWidget(
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

class _GroupListRowWidget extends StatelessWidget {
  final int index;
  const _GroupListRowWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)?.model;
    return Card(
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                model!.deleteGroup(index);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Удалить',
            ),
          ],
        ),
        child: ListTile(
            title: Text(GroupsWidgetModelProvider.watch(context)
                    ?.model
                    .groups[index]
                    .name ??
                'noname'),
            onTap: () => model!.showTasks(context, index),
            trailing: const Icon(
              Icons.chevron_right,
            )),
      ),
    );
  }
}
