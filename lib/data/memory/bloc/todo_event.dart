import 'package:fast_app_base/data/memory/vo/todo_vo.dart';

sealed class TodoEvent {}

class TodoAddEvent extends TodoEvent {}

class TodoStatusUpdateEvent extends TodoEvent {
  TodoStatusUpdateEvent({
    required this.updatedTodo,
  });
  final Todo updatedTodo;
}

class TodoContentUpdateEvent extends TodoEvent {
  TodoContentUpdateEvent({
    required this.updatedTodo,
  });
  final Todo updatedTodo;
}

class TodoRemoveEvent extends TodoEvent {
  TodoRemoveEvent({
    required this.removedTodo,
  });
  final Todo removedTodo;
}
