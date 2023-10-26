import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/config/routes/routes.dart';
import 'package:flutter_todos_app/controller/controller.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:flutter_todos_app/utils/utils.dart';
import 'package:flutter_todos_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) => const CreateTaskScreen();
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DisplayWhiteText(
          text: 'Add New Task',
          color: context.colorScheme.surface,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                controller: _titleController,
                title: 'Task Title',
                hintText: 'title',
              ),
              const SizedBox(height: 16),
              const SelectCategory(),
              const SizedBox(height: 16),
              const SelectDateTime(),
              const SizedBox(height: 16),
              CommonTextField(
                controller: _noteController,
                title: 'Note',
                hintText: 'note',
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              CommonButton(
                onPressed: _createTask,
                child: const DisplayWhiteText(text: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();

    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        category: category,
        isCompleted: false,
      );

      return ref.read(taskProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Todos created successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}
