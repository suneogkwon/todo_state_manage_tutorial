import 'package:fast_app_base/common/data/preference/app_preferences.dart';
import 'package:fast_app_base/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/data/memory/todo_bloc.dart';
import 'package:fast_app_base/screen/main/tab/todo/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      builder: (context, state) {
        if (state.todoList.isEmpty) {
          return const Center(
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
            ...state.todoList.map(
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
