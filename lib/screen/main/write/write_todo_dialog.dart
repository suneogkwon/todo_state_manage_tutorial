import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/rounded_container.dart';
import 'package:fast_app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/main/write/write_todo_result_vo.dart';
import 'package:flutter/material.dart';
import 'package:nav_hooks/dialog/hook_dialog.dart';

class WriteTodoDialog extends HookDialogWidget<WriteTodoResult> {
  WriteTodoDialog({
    super.key,
    this.todo,
  });

  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState(DateTime.now());
    final textController = useTextEditingController();
    final textController2 = useTextEditingController();
    final node = useFocusNode();

    useMemoized(() {
      if (todo != null) {
        selectedDate.value = todo!.dueDate;
        textController.text = todo!.title;
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        AppKeyboardUtil.show(context, node);
      });
    });

    final Future<void> Function() onSelectDate = useCallback(() async {
      final date = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now().subtract(365.days),
        lastDate: DateTime.now().add(3650.days),
      );
      if (date != null) {
        selectedDate.value = date;
      }
    });

    return BottomDialogScaffold(
      body: RoundedContainer(
        color: context.backgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '할일을 작성해주세요.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  selectedDate.value.formattedDate,
                ),
                IconButton(
                  onPressed: onSelectDate,
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            HeightBox(20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: node,
                    controller: textController,
                  ),
                ),
                RoundButton(
                  text: todo != null ? '수정' : '추가',
                  onTap: () {
                    hide(
                      WriteTodoResult(
                        dateTime: selectedDate.value,
                        text: textController.text,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
