import 'package:fast_app_base/common/data/preference/app_preferences.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList extends ConsumerWidget {
  TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoDataProvider);

    if (todoList.isEmpty) {
      return Center(
        child: Text(
          '할일을 작성해보세요.',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      );
    }

    return Column(
      children: [
        ...todoList.map(
          (e) => TodoItem(
            todo: e,
          ),
        ),
      ],
    );
  }
}
