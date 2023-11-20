import 'package:fast_app_base/data/memory/todo_data_notifier.dart';
import 'package:fast_app_base/data/memory/vo/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/write_todo_dialog.dart';
import 'package:flutter/material.dart';

class TodoDataHolder extends InheritedWidget {
  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  final TodoDataNotifier notifier;

  static TodoDataHolder _of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<TodoDataHolder>();

    return inherited!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();

    if (result != null) {
      notifier.addTodo(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
        ),
      );
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

    notifier.notifyListeners();
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todo: todo).show();

    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      notifier.notifyListeners();
    }
  }

  void remove(Todo todo) {
    notifier.value.remove(todo);
    notifier.notifyListeners();
  }
}

extension TodoDataHolderContextExt on BuildContext {
  TodoDataHolder get todoHolder => TodoDataHolder._of(this);
}
