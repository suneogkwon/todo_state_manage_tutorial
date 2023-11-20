import 'package:fast_app_base/data/memory/vo/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/write_todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>(
  (ref) => TodoDataHolder(),
);

class TodoDataHolder extends StateNotifier<List<Todo>> {
  TodoDataHolder() : super([]);

  void addTodo() async {
    final result = await WriteTodoDialog().show();

    if (result != null) {
      state.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
        ),
      );
      state = List.of(state);
    }
  }

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog(
          '정말로 처음 상태로 변경하시겠어요?',
        ).show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }

    state = List.of(state);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todo: todo).show();

    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;

      final resolvedTodoList = List.of(state);
      final todoIndex = resolvedTodoList.indexWhere(
        (element) => element.id == todo.id,
      );

      state = resolvedTodoList..[todoIndex] = todo;
    }
  }

  void remove(Todo todo) {
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get todoHolder => read(todoDataProvider.notifier);
}
