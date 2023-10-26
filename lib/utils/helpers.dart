import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/data/data.dart';
import 'package:intl/intl.dart';

import '../controller/controller.dart';

class Helpers {
  Helpers._();

  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      return DateFormat.jm().format(date);
    } catch (e) {
      return '12.00 pm';
    }
  }

  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  static DateTime _stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static bool isTaskFromSelectedDate(Task task, DateTime selectedDate) {
    final DateTime taskDate = _stringToDateTime(task.date);
    if (taskDate.year == selectedDate.year && taskDate.month == selectedDate.month && taskDate.day == selectedDate.day) {
      return true;
    }
    return false;
  }
}
