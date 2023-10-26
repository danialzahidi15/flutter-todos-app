// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/controller/controller.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:flutter_todos_app/utils/utils.dart';
import 'package:flutter_todos_app/widgets/widgets.dart';

class DisplayListTask extends ConsumerWidget {
  const DisplayListTask({
    Key? key,
    required this.tasks,
    this.isCompletedTask = false,
  }) : super(key: key);

  final List<Task> tasks;
  final bool isCompletedTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height = isCompletedTask ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyListTask = isCompletedTask ? 'There is no completed task yet' : 'There is no task todo';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyListTask,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1.5);
              },
              itemBuilder: (context, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showDeleteDialog(context, ref, task);
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return TaskDetails(task: task);
                        });
                  },
                  child: TaskTile(
                    task: task,
                    onComplete: (value) async {
                      await ref.read(taskProvider.notifier).updateTask(task).then((value) {
                        AppAlerts.displaySnackbar(
                          context,
                          task.isCompleted ? 'Task incompleted' : 'Task completed',
                        );
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
