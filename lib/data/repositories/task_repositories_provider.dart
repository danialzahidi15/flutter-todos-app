import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/data/data.dart';

final taskRepositoriesProvider = Provider<TaskRepositories>((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return TaskRepositoriesImpl(datasource);
});
