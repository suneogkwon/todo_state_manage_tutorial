import 'package:fast_app_base/data/memory/vo/todo_status.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_vo.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required DateTime createdTime,
    DateTime? modifyTime,
    required DateTime dueDate,
    required TodoStatus status,
  }) = _Todo;
}
