// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_todos_app/utils/utils.dart';
import 'package:flutter_todos_app/widgets/circle_container.dart';
import '../data/data.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.5),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            task.title,
            style: style.titleMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(task.time, style: style.titleMedium),
          const SizedBox(height: 20),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Task to be completed on ${task.date}',
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            thickness: 2,
            color: task.category.color,
          ),
          const SizedBox(height: 20),
          Text(
            task.note.isEmpty ? 'There is no additional note' : task.note,
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Task completed',
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
