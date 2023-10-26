import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/controller/controller.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:flutter_todos_app/utils/utils.dart';
import 'package:go_router/go_router.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: context.colorScheme.surface,
      duration: const Duration(seconds: 1),
      content: Text(
        message,
        style: context.textTheme.bodyLarge,
      ),
    ));
  }

  static Future<void> showDeleteDialog(BuildContext context, WidgetRef ref, Task task) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('No'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then((value) {
          AppAlerts.displaySnackbar(context, 'Task deleted.');
          context.pop();
        });
      },
      child: const Text('Yes'),
    );
    AlertDialog alert = AlertDialog(
      content: const Text('Are you sure want to delete this task?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    return showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
