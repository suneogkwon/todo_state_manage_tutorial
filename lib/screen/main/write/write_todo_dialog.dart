import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/rounded_container.dart';
import 'package:fast_app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:fast_app_base/screen/main/write/write_todo_result_vo.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';

class WriteTodoDialog extends DialogWidget<WriteTodoResult> {
  WriteTodoDialog({
    super.key,
    this.todo,
  });

  final Todo? todo;

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

class _WriteTodoDialogState extends DialogState<WriteTodoDialog> {
  DateTime _selectedDate = DateTime.now();
  final textController = TextEditingController();
  final node = FocusNode();

  get isEdit => widget.todo != null;

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(365.days),
      lastDate: DateTime.now().add(3650.days),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _selectedDate = widget.todo!.dueDate;
      textController.text = widget.todo!.title;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppKeyboardUtil.show(context, node);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  _selectedDate.formattedDate,
                ),
                IconButton(
                  onPressed: _selectDate,
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
                  text: isEdit ? '수정' : '추가',
                  onTap: () {
                    widget.hide(
                      WriteTodoResult(
                        dateTime: _selectedDate,
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
