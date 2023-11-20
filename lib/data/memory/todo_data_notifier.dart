import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:flutter/material.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo) {
    value.add(todo);

    notifyListeners();
  }
}
