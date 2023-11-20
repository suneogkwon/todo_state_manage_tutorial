import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/fire_button.dart';
import 'package:fast_app_base/data/memory/bloc/todo_event.dart';
import 'package:fast_app_base/data/memory/todo_bloc.dart';
import 'package:fast_app_base/data/memory/vo/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:flutter/material.dart';

class TodoStatusWidget extends StatelessWidget {
  const TodoStatusWidget({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        context.readTodoBloc.add(TodoStatusUpdateEvent(updatedTodo: todo));
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: switch (todo.status) {
          TodoStatus.complete => Checkbox(
              value: true,
              onChanged: null,
              fillColor:
                  MaterialStatePropertyAll(context.appColors.checkBoxColor),
            ),
          TodoStatus.incomplete => Checkbox(
              value: false,
              onChanged: null,
            ),
          TodoStatus.ongoing => FireButton(),
        },
      ),
    );
  }
}
