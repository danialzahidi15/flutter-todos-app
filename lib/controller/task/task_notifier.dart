import 'package:flutter/cupertino.dart';
import 'package:flutter_todos_app/controller/controller.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:riverpod/riverpod.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepositories _repository;
  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getAllTask();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      getAllTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getAllTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updateTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updateTask);
      getAllTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllTask() async {
    try {
      final tasks = await _repository.getAllTask();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
