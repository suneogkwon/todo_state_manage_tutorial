import 'package:fast_app_base/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/data/memory/bloc/todo_event.dart';
import 'package:fast_app_base/data/memory/vo/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/write_todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  TodoBloc()
      : super(
          TodoBlocState(
            todoList: [],
            status: BlocStatus.initial,
          ),
        ) {
    on<TodoAddEvent>(_addTodo);
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoContentUpdateEvent>(_editTodo);
    on<TodoRemoveEvent>(_remove);
  }

  void _addTodo(TodoAddEvent event, Emitter<TodoBlocState> emit) async {
    final result = await WriteTodoDialog().show();

    if (result != null) {
      final orgTodoList = List.of(state.todoList)
        ..add(
          Todo(
            id: DateTime.now().millisecondsSinceEpoch,
            title: result.text,
            dueDate: result.dateTime,
            createdTime: DateTime.now(),
            status: TodoStatus.incomplete,
          ),
        );
      emit(
        state.copyWith(todoList: orgTodoList),
      );
    }
  }

  void _changeTodoStatus(
      TodoStatusUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final orgTodoList = List.of(state.todoList);
    final todoIndex = orgTodoList.indexWhere(
      (element) => element == event.updatedTodo,
    );

    TodoStatus status = event.updatedTodo.status;
    switch (event.updatedTodo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog(
          '정말로 처음 상태로 변경하시겠어요?',
        ).show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }

    orgTodoList[todoIndex] = event.updatedTodo.copyWith(
      status: status,
    );

    emit(
      state.copyWith(
        todoList: orgTodoList,
      ),
    );
  }

  void _editTodo(
      TodoContentUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final result = await WriteTodoDialog(todo: event.updatedTodo).show();

    if (result != null) {
      final todo = event.updatedTodo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
        modifyTime: DateTime.now(),
      );

      final orgTodoList = List.of(state.todoList);
      final todoIndex = orgTodoList.indexWhere(
        (element) => element == event.updatedTodo,
      );
      orgTodoList[todoIndex] = todo;

      emit(
        state.copyWith(
          todoList: orgTodoList,
        ),
      );
    }
  }

  void _remove(TodoRemoveEvent event, Emitter<TodoBlocState> emit) {
    final orgTodoList = List.of(state.todoList)
      ..removeWhere((element) => element.id == event.removedTodo.id);

    emit(
      state.copyWith(
        todoList: orgTodoList,
      ),
    );
  }
}
