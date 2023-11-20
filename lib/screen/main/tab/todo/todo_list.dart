import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/todo_item.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.todoHolder.notifier,
      builder: (context, value, child) {
        if (value.isEmpty) {
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
            ...value.map(
              (e) => TodoItem(
                todo: e,
              ),
            ),
          ],
        );
      },
    );
  }
}
