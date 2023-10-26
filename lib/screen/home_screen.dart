import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/config/routes/routes.dart';
import 'package:flutter_todos_app/controller/controller.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:flutter_todos_app/utils/utils.dart';
import 'package:flutter_todos_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) => const HomeScreen();
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    final selectedDate = ref.watch(dateProvider);
    final completedTask = _completedTasks(taskState.tasks, ref);
    final incompletedTask = _incompletedTask(taskState.tasks, ref);

    final deviceSize = context.deviceSize;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                // color: Colors.white,
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(2, -2),
                  ),
                ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Helpers.selectDate(context, ref),
                        child: DisplayWhiteText(
                          text: DateFormat.yMMMMd().format(selectedDate),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const DisplayWhiteText(
                        text: 'My Todo List',
                        fontSize: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListTask(
                      tasks: incompletedTask,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    // ignore: prefer_const_constructors
                    DisplayListTask(
                      tasks: completedTask,
                      isCompletedTask: true,
                    ),
                    const SizedBox(height: 20),
                    CommonButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const DisplayWhiteText(text: 'Add New Task'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Task> _completedTasks(List<Task> tasks, WidgetRef ref) {
  final selectedDate = ref.watch(dateProvider);
  final List<Task> filteredTask = [];

  for (var task in tasks) {
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
    if (task.isCompleted && isTaskDay) {
      filteredTask.add(task);
    }
  }
  return filteredTask;
}

List<Task> _incompletedTask(List<Task> tasks, WidgetRef ref) {
  final selectedDate = ref.watch(dateProvider);
  final List<Task> filteredTask = [];

  for (var task in tasks) {
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
    if (!task.isCompleted && isTaskDay) {
      filteredTask.add(task);
    }
  }
  return filteredTask;
}
