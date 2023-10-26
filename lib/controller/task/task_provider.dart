import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/controller/controller.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoriesProvider);
  return TaskNotifier(repository);
});
