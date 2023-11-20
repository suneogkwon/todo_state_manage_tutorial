import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/rounded_container.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/main/tab/todo/todo_status_widget.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget with TodoDataProvider {
  TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      background: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WidthBox(20),
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
          ],
        ),
      ),
      secondaryBackground: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
            WidthBox(20),
          ],
        ),
      ),
      onDismissed: (direction) {
        todoData.remove(todo);
      },
      child: RoundedContainer(
        color: context.appColors.itemBackground,
        padding: const EdgeInsets.fromLTRB(5, 15, 15, 10),
        margin: const EdgeInsets.only(bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(todo.dueDate.relativeDays),
            Row(
              children: [
                TodoStatusWidget(
                  todo: todo,
                ),
                Expanded(
                  child: Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    todoData.editTodo(todo);
                  },
                  icon: const Icon(
                    EvaIcons.editOutline,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
